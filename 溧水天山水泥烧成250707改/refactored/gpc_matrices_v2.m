function M = gpc_matrices_v2(A, B, N, Nu)
%GPC_MATRICES_V2  构造 GPC 的预测矩阵（Diophantine 求解 + G/F/H 矩阵）。
%
%   M = gpc_matrices_v2(A, B, N, Nu)
%
%   溧水天山水泥烧成工程重构版。数值逻辑与原版 gpc_clac.m 内联矩阵段
%   逐行一致（溧水原版与宝马原版逐行相同，故直接复用该实现）。
%
%   输入
%     A   : 过程模型 A 多项式系数，A = [a1, ..., ana, 1]，从高次到低次。
%           例：一阶模型 A = [-0.9769, 1]（即 1 - 0.9769*z^{-1}）。
%     B   : 过程模型 B 多项式系数，B = [b0, ..., bnb]。
%           例：B = [0.8642]。
%     N   : 预测时域（prediction horizon）。
%     Nu  : 控制时域（control horizon）。
%
%   输出
%     M   : struct，含以下字段（均为“从低次到高次”排列后的结果）：
%           .F_ : N x (na+1) 矩阵，自由响应系数（Diophantine 解 F_j）。
%           .H_ : N x (nb+1) 矩阵，历史控制项系数（Diophantine 解 H_j）。
%           .G_ : N x Nu 矩阵，阶跃响应矩阵（下三角 Toeplitz 结构）。
%
%   说明
%     该函数只依赖模型参数 A、B 与时域 N、Nu。在控制回路中模型参数
%     固定不变时，本函数只需在初始化时调用一次，之后每个控制周期复用
%     返回的 M（gpc_clac_v2 的 use_cached=true 即自动完成），避免重复
%     求解 Diophantine 方程（原版 GPC 的主要在线开销）。
%
%   参见 gpc_clac_v2

    na = length(A) - 1;                 % A 多项式阶次
    nb = length(B) - 1;                 % B 多项式阶次

    delta = [-1, 1];                    % 差分算子 Δ = 1 - z^{-1} 的系数（高次在前）
    Z = [1, 0];                         % 表示 z^{-1} 的单位延迟（多项式除法的除数）
    Adelta = conv(A, delta);            % A * Δ

    % Zj{j} 表示 z^{-j}，长度 j+1：首项为 1，其余补 0
    Zj = cell(1, N-1);
    for j = 1:N-1
        Zj{j}(1) = 1;
        Zj{j}(2:j+1) = 0;
    end

    % ---- 第一步：递推求解 Diophantine 方程得到 E_j、F_j ----
    E = cell(1, N);
    F = cell(1, N);
    E{1} = [1];
    F{1} = deconv(polyadd_loc(1, -Adelta), Z);      % 商多项式（取 deconv 的第一个输出）
    for j = 1:N-1
        E{j+1} = polyadd_loc(E{j}, F{j}(na+1) * Zj{j});
        F{j+1} = deconv(polyadd_loc(F{j}, -(F{j}(na+1) * Adelta)), Z);
    end

    % ---- 第二步：由 E_j、B 构造 G_j、H_j ----
    G = cell(1, N);
    H = cell(1, N);
    for j = 1:N
        EB = conv(E{j}, B);
        H{j} = EB(1:length(EB)-j+1);
        G{j} = EB(length(EB)-j+1:length(EB));
    end

    % ---- 第三步：翻转所有多项式为“从低次到高次”，便于矩阵构造 ----
    for j = 1:N
        E{j} = fliplr(E{j});
        F{j} = fliplr(F{j});
        G{j} = fliplr(G{j});
        H{j} = fliplr(H{j});
    end

    % ---- 第四步：组装 F_、H_、G_ ----
    F_ = zeros(N, na+1);
    H_ = zeros(N, nb+1);
    for j = 1:N
        F_(j, 1:na+1) = F{j};
        H_(j, 1:nb+1) = H{j};
    end
    G_ = zeros(N, Nu);
    for i = 1:Nu
        G_(1:N, i) = [zeros(1, i-1), G{N}(1:N+1-i)]';
    end

    M = struct('F_', F_, 'H_', H_, 'G_', G_);
end

function y = polyadd_loc(x1, x2)
%POLYADD_LOC  两个多项式（系数向量）按“低次对齐”相加。
%   与溧水工程 polyadd.m 行为一致，内联以保证本目录自包含。
    n1 = length(x1);
    n2 = length(x2);
    if n1 > n2
        x2 = [zeros(1, n1-n2), x2];
    elseif n1 < n2
        x1 = [zeros(1, n2-n1), x1];
    end
    y = x1 + x2;
end
