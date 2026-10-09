function [ u ] = gpc_clac_v2( A,B,P,y,u,yr,a,lmd1,opts )
%GPC_CLAC_V2  广义预测控制（GPC）——天钢4#加热炉工程重构版。
%
%   [u] = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1)
%   [u] = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1, opts)
%
%   接口与原版 gpc_clac.m 完全兼容（8 参数调用，不传 opts 时行为与原版
%   逐位一致，可用 test_verify.py 做 numpy 等价验证）。
%
%   输入（语义与原版相同）
%     A   : 过程模型 A 多项式，A = [a1,...,ana,1]（高次到低次）。
%     B   : 过程模型 B 多项式，B = [b0,...,bnb]。
%     P   : 递推最小二乘协方差矩阵（原版 THETA/P 在线辨识段为死代码，
%           见下方 use_rls_online 说明；保留该参数仅为兼容原接口）。
%     y   : 输出历史行向量，现场为 3 元素，y(3)=当前输出。
%     u   : 控制历史行向量，现场为 2 元素，u(2)=当前控制量。
%     yr  : 设定值（参考轨迹目标）。
%     a   : 柔化因子（0<a<1）。
%     lmd1: 控制加权基值（函数内部按偏差自适应调节）。
%     opts: 可选 struct（不传或字段缺省 = 现场原值）：
%           .N              (120)   预测时域（原版硬编码 N=120）
%           .Nu             (20)    控制时域（原版硬编码 Nu=20）
%           .control_gain   (1.0)   输出步进系数；原版末尾为
%                                    u=u(2)+deltaU(1)，无 0.7 系数，
%                                    故默认 1.0
%           .deltaU_lim     (3000)  deltaU(1) 饱和限幅（原版 ±3000）
%           .use_cached     (false) 模型参数不变时缓存预测矩阵 G_/F_/H_
%           .use_rls_online (false) 是否执行在线递推辨识（THETA/P 段）
%
%   输出
%     u   : 当前时刻控制量（标量）。
%
%   与原版 gpc_clac.m 的关系（现场行为逐行保持，仅做参数化）
%     1. N=120、Nu=20、输出系数、±3000 限幅 → 全部参数化，默认取现场原值。
%     2. 预测矩阵构造（Diophantine 递推 → G_/F_/H_）抽为 gpc_matrices_v2.m，
%        逐行移植原版内联逻辑；模型参数不变时可缓存（use_cached=true）。
%     3. 在线递推辨识段（THETA/P）经逐行确认是死代码：更新后从未反馈回
%        A、B（原版反馈行被注释掉），输出 u 不依赖 THETA/P。故默认关闭
%        （use_rls_online=false），输出与原版完全一致；开启时执行与原版
%        逐字相同的递推更新。
%     4. 以下现场细节原样保留：
%          - olddeltaU = u(2)-u(1)；
%          - oldY      = [y(3:-1:2)]'（na=1 现场，即 [y(3); y(2)]）；
%          - yd(1)     = y(length(y))，柔化轨迹 Yd = yd'；
%          - ye        = abs(yr-y(3))，lmd = lmd1/15*ye + 2/3*lmd1；
%          - K = (G_'*G_+lmd*eye(Nu))\G_'，deltaU = K*(Yd-Y0)；
%          - 先对 deltaU(1) 做 ±deltaU_lim 限幅，再算 u = u(2)+deltaU(1)，
%            顺序与原版一致（先限幅后输出）。
%
%   参见 gpc_matrices_v2, test_verify

    % ---- 参数默认值（= 本工程现场原值，与原版逐位一致）----
    N       = 120;      % 原版硬编码 N=120
    Nu      = 20;       % 原版硬编码 Nu=20
    ctrl_g  = 1.0;      % 原版 u=u(2)+deltaU(1)，无输出系数（=1.0）
    dU_lim  = 3000;     % 原版 deltaU(1) 饱和限幅 ±3000
    cache   = false;
    rls     = false;

    if nargin >= 9 && ~isempty(opts) && isstruct(opts)
        if isfield(opts, 'N'),              N      = opts.N;              end
        if isfield(opts, 'Nu'),             Nu     = opts.Nu;             end
        if isfield(opts, 'control_gain'),   ctrl_g = opts.control_gain;   end
        if isfield(opts, 'deltaU_lim'),     dU_lim = opts.deltaU_lim;     end
        if isfield(opts, 'use_cached'),     cache  = opts.use_cached;     end
        if isfield(opts, 'use_rls_online'), rls    = opts.use_rls_online; end
    end

    % 基本校验（不改变现场行为，仅防误用）
    N  = max(round(N),  1);
    Nu = max(round(Nu), 1);
    Nu = min(Nu, N);
    dU_lim = abs(dU_lim);
    if ~(a > 0 && a < 1), a = 0.8; end

    na = length(A) - 1;
    nb = length(B) - 1;

    % ---- 预测矩阵：仅依赖模型参数 A/B/N/Nu，不变时可缓存复用 ----
    % （原版每次调用都从 Adelta=conv(A,delta) 开始内联重算，是主要在线开销）
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

    % ---- 可选：在线递推辨识（默认关闭）----
    % 原版逐字执行 THETA/P 更新，但辨识结果从未反馈回 A、B（反馈行
    % A(na:-1:1)=-THETA(...) 在原版中被注释），且输出 u 不依赖 THETA/P，
    % 对控制结果无任何影响（死代码）。默认关闭以避免每周期无效计算；
    % 开启时与原版递推式完全一致。
    if rls
        THETA = [-A(na:-1:1), B(nb+1:-1:1)]';
        PHI   = [y(2), u(2)]';
        THETA = THETA + P * PHI * (y(length(y)) - THETA' * PHI) / (1 + PHI' * P * PHI);
        P     = P - P * PHI * PHI' * P / (1 + PHI' * P * PHI);
    end

    % ---- 自由响应初值 Y0（索引细节与原版一致）----
    olddeltaU = u(2) - u(1);                 % 单步差分（原版行为）
    oldY      = [y(3:-1:2)]';                % 现场 na=1：[y(3); y(2)] 列向量
    Y0 = F_ * oldY + H_ * olddeltaU;

    % ---- 参考轨迹（柔化轨迹，行向量后转置，与原版 Yd=yd' 一致）----
    yd(1) = y(length(y));
    for j = 2:N
        yd(j) = a * yd(j-1) + (1 - a) * yr;
    end
    Yd = yd';

    % ---- 自适应控制加权 λ（原版策略：ye=abs(yr-y(3))）----
    ye      = abs(yr - y(3));
    lmd     = lmd1 / 15 * ye + 2 / 3 * lmd1;

    % ---- 控制增量：ΔU = K*(Yd-Y0) ----
    K      = (G_' * G_ + lmd * eye(Nu)) \ G_';
    deltaU = K * (Yd - Y0);

    % ---- 先限幅、后输出（顺序与原版严格一致）----
    if deltaU(1) >= dU_lim
        deltaU(1) = dU_lim;
    end
    if deltaU(1) <= -dU_lim
        deltaU(1) = -dU_lim;
    end

    u = u(2) + ctrl_g * deltaU(1);          % 现场 ctrl_g=1.0：u=u(2)+deltaU(1)
end
