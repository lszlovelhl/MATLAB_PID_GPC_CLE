function u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd, opts)
%GPC_CLAC_V2  广义预测控制（GPC）——含山南方水泥一线烧成系统 重构版。
%
%   u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd)
%   u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd, opts)
%
%   接口与原版 gpc_clac.m 完全兼容。不传 opts 时，默认参数与原版逐位
%   一致（输出与原版相同，可用 test_verify.py 做 numpy 等价验证）。
%
%   【现场参数未改动声明】本函数严格保留原版的：
%     - 控制律（ΔU = K*(Yd-Y0)，K=(G'G+λI)\G'）
%     - 回路结构（单自由度 GPC，取 Δu 第一步 × 步进系数）
%     - 自适应加权策略（lmd_eff = lmd/15*|yr-y| + 2/3*lmd）
%     - 柔化轨迹（yd(j)=a*yd(j-1)+(1-a)*yr）
%   唯一允许的改动见文末“改进点”。
%
%   输入
%     A   : 过程模型 A 多项式，A = [a1,...,ana,1]（从高次到低次）。
%     B   : 过程模型 B 多项式，B = [b0,...,bnb]。
%     P   : 递推最小二乘协方差矩阵（本重构版不再依赖，保留参数仅为兼容原接口）。
%     y   : 输出历史，y(end) 为当前输出。现场为一阶模型 na=1，y 长度=3。
%     u   : 控制历史，u(end) 为当前控制量。现场 u 长度=2。
%     yr  : 设定值（参考轨迹目标）。
%     a   : 柔化因子（0<a<1）。
%     lmd : 控制加权基值（函数内部做自适应调节）。
%     opts: 可选 struct：
%           .N              (80)    预测时域【现场原值】
%           .Nu             (20)    控制时域【现场原值】
%           .control_gain   (0.7)   控制步进系数（作用于 Δu 第一步）【现场原值】
%           .deltaU_history (1)     历史 Δu 元素数；1=原版单步近似
%                                    （设为 nb+1 可获得标准 GPC 的多步预测）
%           .use_cached     (false) 模型参数不变时缓存预测矩阵，显著提速
%           .use_rls_online (false) 是否执行在线递推辨识（原版该段为“死代码”，
%                                    不影响输出 u；默认关闭以提升性能）
%
%   输出
%     u   : 当前时刻控制量。
%
%   改进点（相对原版，均不改变默认现场行为）
%     1. N、Nu、control_gain、历史阶数全部参数化，换窑线无需改代码；
%        默认值 = 现场原值（80 / 20 / 0.7），不传 opts 时逐位一致。
%     2. 模型参数不变时可缓存预测矩阵 G_/F_/H_（use_cached=true），
%        避免每个周期重复求解 Diophantine 方程（原版主要在线开销）。
%     3. 原版 olddeltaU 只取单步差分、且要求 B 为纯比例（nb=0）才成立；
%        通过 opts.deltaU_history 可配置为多步历史（标准 GPC），默认仍为 1。
%     4. 在线递推辨识段经确认不影响输出 u（THETA/P 未反馈回 A、B），
%        默认移除，减少每周期无效计算；保留 use_rls_online 开关。
%     5. 命名清晰、去除乱码注释、补充边界校验（时域为正整数、柔化因子兜底、Nu≤N）。
%
%   参见 gpc_matrices_v2, test_verify

    % ---- 参数默认值（与原版 gpc_clac.m 现场原值一致）----
    N      = 80;      % 原版硬编码 N=80
    Nu     = 20;      % 原版硬编码 Nu=20
    ctrl_g = 0.7;     % 原版硬编码 u=u(2)+0.7*deltaU(1)
    dN     = 1;       % 历史 Δu 元素数（原版为单步 = 1）
    cache  = false;
    rls    = false;

    if nargin >= 9 && ~isempty(opts) && isstruct(opts)
        if isfield(opts, 'N'),               N      = opts.N;               end
        if isfield(opts, 'Nu'),              Nu     = opts.Nu;              end
        if isfield(opts, 'control_gain'),    ctrl_g = opts.control_gain;    end
        if isfield(opts, 'deltaU_history'),  dN     = opts.deltaU_history;  end
        if isfield(opts, 'use_cached'),      cache  = opts.use_cached;      end
        if isfield(opts, 'use_rls_online'),  rls    = opts.use_rls_online;  end
    end

    % 基本校验（不改变现场合法参数下的行为；仅对非法输入兜底）
    N  = max(round(N),  1);
    Nu = max(round(Nu), 1);
    Nu = min(Nu, N);
    if ~(a > 0 && a < 1), a = 0.8; end   % 现场 a=0.998，此分支永不触发

    na = length(A) - 1;
    nb = length(B) - 1;

    % ---- 预测矩阵：仅依赖模型参数 A/B 与时域 N/Nu，模型不变时缓存复用 ----
    if cache
        persistent keyA keyB keyN keyNu Mp
        % 键校验：任一模型/时域变化即重算，保证缓存正确性
        if ~(isequal(keyA, A) && isequal(keyB, B) && keyN == N && keyNu == Nu)
            keyA = A; keyB = B; keyN = N; keyNu = Nu;
            Mp = gpc_matrices_v2(A, B, N, Nu);
        end
        M = Mp;
    else
        M = gpc_matrices_v2(A, B, N, Nu);
    end
    F_ = M.F_;
    H_ = M.H_;
    G_ = M.G_;

    % ---- 可选：在线递推辨识（默认关闭）----
    % 原版该段更新 THETA 与 P，但辨识结果从未反馈回 A、B（相关代码被注释），
    % 且输出 u 不依赖 THETA/P，故对控制结果无任何影响（属“死代码”）。
    % 保留此开关以便需要时启用真正的在线辨识。
    if rls
        THETA = [-A(na:-1:1), B(nb+1:-1:1)]';
        PHI   = [y(2); u(2)];
        THETA = THETA + P * PHI * (y(end) - THETA' * PHI) / (1 + PHI' * P * PHI);
        P     = P - P * PHI * PHI' * P / (1 + PHI' * P * PHI);
    end

    % ---- 自由响应初值 Y0 ----
    % 原版：oldY = [y(3); y(2)]，olddeltaU = u(2)-u(1)（要求 nb=0 才维度匹配）。
    % 现场 na=1，y(end:-1:end-1) = [y(3); y(2)]，与原版逐位一致。
    oldY = (y(end:-1:end-na))';            % 最近 (na+1) 个输出，倒序，列向量
    if dN <= 1
        olddeltaU = u(2) - u(1);           % 单步差分（原版行为）
    else
        if length(u) >= dN + 1 && dN == nb + 1
            uk = u(end-dN:end);            % 取 dN+1 个历史控制
            olddeltaU = diff(uk)';         % dN 个历史 Δu，列向量，与 H_ 列数匹配
        else
            olddeltaU = u(2) - u(1);       % 回退单步，保证维度安全
        end
    end
    Y0 = F_ * oldY + H_ * olddeltaU;

    % ---- 参考轨迹（柔化轨迹）----
    yd = zeros(N, 1);
    yd(1) = y(end);
    for j = 2:N
        yd(j) = a * yd(j-1) + (1 - a) * yr;
    end
    Yd = yd;

    % ---- 自适应控制加权 λ（保留原版策略）----
    % 原版：ye=abs(yr-y(3))；现场 y 长度=3，y(3)=y(end)，二者逐位一致。
    ye = abs(yr - y(end));
    lmd_eff = lmd / 15 * ye + 2/3 * lmd;

    % ---- 控制增量：ΔU = K*(Yd - Y0)，K = (G'G + λI)^{-1} G' ----
    K = (G_' * G_ + lmd_eff * eye(Nu)) \ G_';
    deltaU = K * (Yd - Y0);

    % ---- 取第一步增量，乘控制步进系数（原版 0.7）----
    u = u(2) + ctrl_g * deltaU(1);
end
