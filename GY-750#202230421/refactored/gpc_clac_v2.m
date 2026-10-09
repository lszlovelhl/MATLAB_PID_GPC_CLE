function u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1, opts)
%GPC_CLAC_V2  广义预测控制（GPC）——GY-750 工程重构版。
%
%   u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1)
%   u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1, opts)
%
%   函数签名与本工程原版 gpc_clac.m 完全兼容。不传 opts 时，默认参数取本
%   工程现场原值，输出与原版逐位一致（由 test_verify.py 以 numpy 等价移植验证）。
%
%   输入
%     A   : 过程模型 A 多项式，A = [a1,...,ana,1]（从高次到低次），行向量。
%     B   : 过程模型 B 多项式，B = [b0,...,bnb]，行向量。
%     P   : 递推最小二乘协方差矩阵（本工程原版在线辨识段已整段注释，P 不再被
%           使用，保留参数仅为兼容原调用接口 onTimer_io_4duan.m）。
%     y   : 输出历史（相对工作点的偏差），y(end) 为当前输出。
%     u   : 控制历史（相对工作点的偏差），u(end) 为当前控制量。
%     yr  : 设定值（相对工作点）。
%     a   : 柔化因子（0<a<1）。
%     lmd1: 控制加权基值（函数内部按偏差自适应调节）。
%     opts: 可选 struct：
%           .N            (120)   预测时域（现场原值）
%           .Nu           (20)    控制时域（现场原值）
%           .control_gain (1.0)   控制步进系数（作用于 Δu 第一步；现场为
%                                  u=u(2)+deltaU(1)，无 0.7 之类系数，故 =1.0）
%           .deltaU_lim   (3000)  Δu 第一步饱和限幅绝对值（现场 ±3000）
%           .use_cached   (false) 模型参数不变时缓存预测矩阵 G_/F_/H_，提速
%
%   输出
%     u   : 当前时刻控制量（相对工作点的偏差）。
%
%   现场行为（逐行保留，不得改动）
%     1. 无在线递推辨识（THETA/P 段在原版中已整段注释）——本版本不引入任何
%        在线辨识逻辑（也不设开关）。
%     2. Δu(1) 先做 ±deltaU_lim 饱和，再计算 u=u(2)+control_gain*deltaU(1)，
%        顺序不可颠倒。
%     3. 索引：ye=abs(yr-y(3))、yd(1)=y(length(y))、oldY=[y(3:-1:2)]'、
%        olddeltaU=u(2)-u(1)。
%     4. 预测矩阵由 gpc_matrices_v2 按原版内联逻辑逐行构造。
%     5. lmd 自适应：lmd=lmd1/15*ye+2/3*lmd1；K=(G_'*G_+lmd*eye(Nu))\G_'。
%
%   参见 gpc_matrices_v2, test_verify

    % ---- 参数默认值（= 本工程现场原值）----
    N        = 120;
    Nu       = 20;
    ctrl_g   = 1.0;     % 现场 u=u(2)+deltaU(1)，无额外输出系数
    dU_lim   = 3000;    % 现场 Δu 饱和 ±3000
    cache    = false;

    if nargin >= 9 && ~isempty(opts) && isstruct(opts)
        if isfield(opts, 'N'),            N      = opts.N;            end
        if isfield(opts, 'Nu'),           Nu     = opts.Nu;           end
        if isfield(opts, 'control_gain'), ctrl_g = opts.control_gain; end
        if isfield(opts, 'deltaU_lim'),   dU_lim = opts.deltaU_lim;   end
        if isfield(opts, 'use_cached'),   cache  = opts.use_cached;   end
    end

    % 基本校验（仅兜底，现场参数不受影响）
    N  = max(round(N),  1);
    Nu = max(round(Nu), 1);
    Nu = min(Nu, N);
    if ~(a > 0 && a < 1), a = 0.8; end

    % ---- 预测矩阵：仅依赖 A/B/N/Nu，模型不变时缓存复用 ----
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

    % ---- 自由响应初值 Y0（现场索引逐行保留）----
    % 注意：本工程原版 oldY=[y(3:-1:2)]'、olddeltaU=u(2)-u(1)，与 na=1、nb=0
    % 的现场模型匹配，此处不做泛化，以保证默认行为与原版逐位一致。
    olddeltaU = u(2) - u(1);
    oldY = [y(3:-1:2)]';
    Y0 = F_ * oldY + H_ * olddeltaU;

    % ---- 参考轨迹（柔化轨迹）----
    yd(1) = y(length(y));
    for j = 2:N
        yd(j) = a * yd(j-1) + (1 - a) * yr;
    end
    Yd = yd';

    % ---- 自适应控制加权 λ（保留现场策略：ye=abs(yr-y(3))）----
    ye = abs(yr - y(3));
    lmd = lmd1 / 15 * ye + 2 / 3 * lmd1;

    % ---- 控制增量：ΔU = K*(Yd - Y0)，K = (G'G + λI)^{-1} G' ----
    K = (G_' * G_ + lmd * eye(Nu)) \ G_';
    deltaU = K * (Yd - Y0);

    % ---- 先限幅（±deltaU_lim），后计算 u——现场顺序不可颠倒 ----
    if deltaU(1) >=  dU_lim, deltaU(1) =  dU_lim; end
    if deltaU(1) <= -dU_lim, deltaU(1) = -dU_lim; end

    u = u(2) + ctrl_g * deltaU(1);
end
