function u = gpc_clac1_v2(A, B, P, y, u, yr, a, lmd, opts)
%GPC_CLAC1_V2  广义预测控制（GPC）——重构版【江油拉豪水泥，对应原版 gpc_clac1.m】。
%
%   u = gpc_clac1_v2(A, B, P, y, u, yr, a, lmd)
%   u = gpc_clac1_v2(A, B, P, y, u, yr, a, lmd, opts)
%
%   接口与原版 gpc_clac1.m 完全兼容。不传 opts 时，默认参数（N=50, Nu=15,
%   control_gain=0.7）与该工程现场原值逐位一致，输出与原版相同
%   （可用 test_verify.py 以 numpy 等价移植验证，容差 1e-9）。
%
%   说明：原版 gpc_clac1.m 与 gpc_clac.m 仅函数名与时域不同
%   （N=50/Nu=15 vs N=80/Nu=20），其余算法逐行相同。本重构版复用
%   gpc_matrices_v2 统一构造预测矩阵，仅默认时域取本回路现场原值。
%
%   输入
%     A   : 过程模型 A 多项式，A = [a1,...,ana,1]（从高次到低次）。
%     B   : 过程模型 B 多项式，B = [b0,...,bnb]。
%     P   : 递推最小二乘协方差矩阵（保留参数仅为兼容原接口）。
%     y   : 输出历史，y(end) 为当前输出。
%     u   : 控制历史，u(end) 为当前控制量。
%     yr  : 设定值（参考轨迹目标）。
%     a   : 柔化因子（0<a<1）。
%     lmd : 控制加权基值（函数内部按原版策略自适应调节）。
%     opts: 可选 struct：
%           .N              (50)    预测时域（本回路现场原值）
%           .Nu             (15)    控制时域（本回路现场原值）
%           .control_gain   (0.7)   控制步进系数（原版硬编码 0.7）
%           .deltaU_history (1)     历史 Δu 元素数；1=原版单步近似
%           .use_cached     (false) 模型参数不变时缓存预测矩阵，显著提速
%           .use_rls_online (false) 是否执行在线递推辨识（原版为“死代码”，
%                                    不影响输出 u；默认关闭）
%
%   输出
%     u   : 当前时刻控制量。
%
%   注意：控制律、回路结构、柔化轨迹、自适应加权策略、现场时域参数
%         一律保持原版不变；默认行为与原版逐位一致。
%
%   参见 gpc_matrices_v2, gpc_clac_v2, test_verify

    % ---- 参数默认值（与原版 gpc_clac1.m 现场原值一致：N=50, Nu=15）----
    N      = 50;
    Nu     = 15;
    ctrl_g = 0.7;      % 原版硬编码 0.7
    dN     = 1;        % 历史 Δu 元素数（原版为单步 = 1）
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

    % 基本校验（仅作兜底，不改正常现场参数的行为）
    N  = max(round(N),  1);
    Nu = max(round(Nu), 1);
    Nu = min(Nu, N);
    if ~(a > 0 && a < 1), a = 0.8; end

    na = length(A) - 1;
    nb = length(B) - 1;

    % ---- 预测矩阵：模型参数（A/B/N/Nu）不变时缓存复用 ----
    if cache
        persistent keyA keyB keyN keyNu Mp
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

    % ---- 可选：在线递推辨识（默认关闭；原版死代码，不影响输出 u）----
    if rls
        THETA = [-A(na:-1:1), B(nb+1:-1:1)]';
        PHI   = [y(2); u(2)];
        THETA = THETA + P * PHI * (y(end) - THETA' * PHI) / (1 + PHI' * P * PHI);
        P     = P - P * PHI * PHI' * P / (1 + PHI' * P * PHI);
    end

    % ---- 自由响应初值 Y0 ----
    % 原版：oldY = [y(3); y(2)]（na=1），olddeltaU = u(2)-u(1)（单步差分）。
    oldY = (y(end:-1:end-na))';            % 最近 (na+1) 个输出，倒序，列向量
    if dN <= 1
        olddeltaU = u(2) - u(1);           % 单步差分（原版行为）
    else
        if length(u) >= dN + 1 && dN == nb + 1
            uk = u(end-dN:end);
            olddeltaU = diff(uk)';
        else
            olddeltaU = u(2) - u(1);
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

    % ---- 自适应控制加权 λ（保留原版策略 ye=abs(yr-当前输出)）----
    ye = abs(yr - y(end));                 % 当前偏差（原版为 yr-y(3)，y(3)即当前输出）
    lmd_eff = lmd / 15 * ye + 2/3 * lmd;

    % ---- 控制增量：ΔU = K*(Yd - Y0)，K = (G'G + λI)^{-1} G' ----
    K = (G_' * G_ + lmd_eff * eye(Nu)) \ G_';
    deltaU = K * (Yd - Y0);

    % ---- 取第一步增量，乘控制步进系数（原版 0.7）----
    u = u(2) + ctrl_g * deltaU(1);
end
