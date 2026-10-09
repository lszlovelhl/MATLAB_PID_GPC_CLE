function u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1, opts)
%GPC_CLAC_V2  广义预测控制（GPC）——JL-2#20230902 工程重构版。
%
%   u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1)
%   u = gpc_clac_v2(A, B, P, y, u, yr, a, lmd1, opts)
%
%   接口与原版 gpc_clac.m 完全兼容（8 个位置参数不变）。不传 opts 时，
%   默认参数与该工程现场原版逐位一致（输出逐位相同，容差 1e-9）。
%
%   输入
%     A    : 过程模型 A 多项式，A = [a1,...,ana,1]（从高次到低次）。
%     B    : 过程模型 B 多项式，B = [b0,...,bnb]。
%     P    : 协方差矩阵（本工程原版 RLS 递推辨识段已整段注释，P 不参与
%            计算；保留该参数仅为兼容原函数签名，请勿删除）。
%     y    : 输出历史（行/列向量），y(end) 为当前输出；原版索引 y(3:-1:2)。
%     u    : 控制历史（行/列向量），u(end) 为当前控制量；olddeltaU=u(2)-u(1)。
%     yr   : 设定值（参考轨迹目标）。
%     a    : 柔化因子（0<a<1）。
%     lmd1 : 控制加权基值（函数内部按 ye 自适应调节）。
%     opts : 可选 struct：
%            .N            (120)  预测时域（原版硬编码 N=120）
%            .Nu           (20)   控制时域（原版硬编码 Nu=20）
%            .control_gain (1.0)  输出系数，作用于 ΔU(1)（原版无 0.7 系数，
%                                 直接 u=u(2)+deltaU(1)，故默认 1.0）
%            .deltaU_lim   (3000) ΔU(1) 饱和限值（原版 ±3000；先限幅后叠加）
%            .use_cached   (false) 模型参数(A/B/N/Nu)不变时缓存预测矩阵
%
%   输出
%     u   : 当前时刻控制量（标量）。
%
%   【现场行为逐位保留声明】（重构不允许改变任何一条）
%     1. 本工程原版无任何在线递推辨识段（THETA/P 整段被注释），v2 同样
%        不引入任何在线辨识逻辑（连开关都不提供）；P 参数仅为占位兼容。
%     2. ΔU(1) 有 ±3000 饱和：先限幅，后计算 u=u(2)+control_gain*ΔU(1)，
%        顺序与原版一致。
%     3. 索引细节与原版一致：ye=abs(yr-y(end))（原版 y(3)）、
%        yd(1)=y(end)（原版 y(length(y))）、oldY=[y(end:-1:end-na)]'
%        （na=1 时即 [y(3);y(2)]，与原版 y(3:-1:2)' 一致）、
%        olddeltaU=u(2)-u(1)。
%     4. 预测矩阵 G_/F_/H_ 的 Diophantine 内联逻辑抽为 gpc_matrices_v2.m，
%        数值逐行移植自原版函数体。
%     5. lmd 自适应：lmd=lmd1/15*ye+2/3*lmd1；
%        K=(G_'*G_+lmd*eye(Nu))\G_'。
%
%   改进点（相对原版，仅限参数化/健壮性/可复用，不改控制律）
%     1. N、Nu、control_gain、deltaU_lim 全部参数化，默认值=现场原值。
%     2. 模型参数不变时可缓存预测矩阵（use_cached），避免每个周期重算
%        120 阶 Diophantine 递推（原版主要在线开销）。
%     3. 补输入校验（时域为正整数、Nu<=N、柔化因子兜底），命名清晰、
%        去除 GBK 乱码注释。
%
%   参见 gpc_matrices_v2, test_verify

    % ---- 参数默认值（= 本工程现场原版硬编码值）----
    N      = 120;      % 原版 N=120
    Nu     = 20;       % 原版 Nu=20
    ctrl_g = 1.0;      % 原版 u=u(2)+deltaU(1)，无输出系数 → 1.0
    dUlim  = 3000;     % 原版 ΔU(1) ±3000 饱和
    cache  = false;

    if nargin >= 9 && ~isempty(opts) && isstruct(opts)
        if isfield(opts, 'N'),            N      = opts.N;            end
        if isfield(opts, 'Nu'),           Nu     = opts.Nu;           end
        if isfield(opts, 'control_gain'), ctrl_g = opts.control_gain; end
        if isfield(opts, 'deltaU_lim'),   dUlim  = opts.deltaU_lim;   end
        if isfield(opts, 'use_cached'),   cache  = opts.use_cached;   end
    end

    % 基本校验（不改变正常参数下的行为）
    N  = max(round(N),  1);
    Nu = max(round(Nu), 1);
    Nu = min(Nu, N);
    if ~(a > 0 && a < 1), a = 0.8; end

    na = length(A) - 1;
    nb = length(B) - 1;   %#ok<NASGU> （保留以与原版结构对应）

    % ---- 预测矩阵：仅依赖模型参数 A/B/N/Nu，可缓存复用 ----
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

    % 注：本工程原版 RLS 在线辨识段（THETA/P 递推）已整段注释，
    % v2 不引入任何在线辨识逻辑；P 参数仅为接口兼容，不参与计算。

    % ---- 自由响应初值 Y0 ----
    % 原版：olddeltaU=u(2)-u(1)；oldY=[y(3:-1:2)]'（na=1 → [y(3);y(2)]）。
    olddeltaU = u(2) - u(1);
    oldY = (y(end:-1:end-na))';          % 最近 (na+1) 个输出倒序，列向量
    Y0 = F_ * oldY + H_ * olddeltaU;

    % ---- 参考轨迹（柔化轨迹）----
    % 原版：yd(1)=y(length(y))；yd(j)=a*yd(j-1)+(1-a)*yr；Yd=yd'。
    yd = zeros(N, 1);
    yd(1) = y(end);
    for j = 2:N
        yd(j) = a * yd(j-1) + (1 - a) * yr;
    end
    Yd = yd;

    % ---- 自适应控制加权 λ（保留原版策略）----
    ye = abs(yr - y(end));               % 原版 ye=abs(yr-y(3))（当前输出）
    lmd = lmd1 / 15 * ye + 2/3 * lmd1;

    % ---- 控制增量：ΔU = K*(Yd - Y0) ----
    K = (G_' * G_ + lmd * eye(Nu)) \ G_';
    deltaU = K * (Yd - Y0);

    % ---- ΔU(1) 饱和限幅（原版 ±3000，先限幅后叠加，顺序不可颠倒）----
    if deltaU(1) >= dUlim
        deltaU(1) = dUlim;
    end
    if deltaU(1) <= -dUlim
        deltaU(1) = -dUlim;
    end

    % ---- 输出：原版 u=u(2)+deltaU(1)（无系数），v2 乘 control_gain（默认 1.0）----
    u = u(2) + ctrl_g * deltaU(1);
end
