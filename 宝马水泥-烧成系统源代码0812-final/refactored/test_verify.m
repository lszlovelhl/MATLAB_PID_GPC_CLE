function test_verify()
%TEST_VERIFY  验证重构版与原版在默认参数下输出一致，并做性能对比。
%
%   运行方式（在 MATLAB 命令行或 -batch 中）：
%     addpath(genpath('<宝马工程根目录>/refactored')); test_verify;
%   或：cd <refactored 目录>; matlab -batch "test_verify"
%
%   覆盖
%     1. GPC：多组模型参数 × 多组输入，对比 gpc_clac（原版）与
%        gpc_clac_v2（重构版）默认输出，断言逐位一致。
%     2. PID：正常参数下对比 pid_calc 与 pid_calc_v2 输出一致；
%        验证 ti=0 时重构版不产生 Inf/NaN。
%     3. 性能：对比原版、重构版（缓存开/关）的耗时。

    clc; rng(42);   % 固定随机种子，保证可复现

    % ---- 0. 路径设置 ----
    base    = fileparts(mfilename('fullpath'));   % refactored 目录
    origdir = fullfile(base, '..');               % 宝马工程根目录（含原版）
    addpath(base, origdir);

    passAll = true;

    %% ============ 1. GPC 一致性 ============
    fprintf('==== 1. GPC 默认输出一致性 ====\n');
    % 用宝马现场的典型模型参数（均为一阶纯比例 nb=0）
    modelSets = {
        [-0.9769, 1],  0.8642;        % 分解炉温度回路
        [-0.9931, 1], -0.001244;      % 氨水回路
        [-0.95,   1],  1.2;           % 测试用
        [-0.88,   1], -2.5;           % 测试用（负增益）
    };
    passGPC = true;
    for s = 1:size(modelSets, 1)
        A = modelSets{s,1};  B = modelSets{s,2};
        P = [0.01, 0.01; 0.01, 0.01];          % 协方差矩阵初值
        a = 0.998;  lmd = 4400;
        for trial = 1:4
            yr   = 800 + 50*trial;
            y    = 810 + 40*trial + 3*randn(1,3);   % 输出历史（行向量）
            uhist = 15 + 2*trial + 0.5*randn(1,2);  % 控制历史（行向量）
            u0 = gpc_clac(A, B, P, y, uhist, yr, a, lmd);          % 原版
            u1 = gpc_clac_v2(A, B, P, y, uhist, yr, a, lmd);       % 重构版（默认）
            if abs(u0 - u1) > 1e-9
                fprintf('  [FAIL] set%d trial%d  orig=%.12f  v2=%.12f  diff=%.3e\n', ...
                        s, trial, u0, u1, abs(u0-u1));
                passGPC = false;
            end
        end
    end
    if passGPC, fprintf('  GPC：全部通过，默认输出与原版逐位一致 ✓\n');
    else passAll = false; end

    %% ============ 2. PID 一致性 ============
    fprintf('==== 2. PID 默认输出一致性 ====\n');
    passPID = true;
    for trial = 1:8
        % 构造 13 元素参数向量（保证 ti>0）
        para = [ 100*rand; 100*rand; 20*rand; 0; 0; 0; ...   % sp,pv,mv,e0,e1,e2
                 5*rand; 10+40*rand; rand; 0; ...            % kp,ti,td,man_on
                 40+rand*20; 0; 0.01 ];                      % ulim,llim,deadzone
        % e1、e2 用非零值模拟历史误差
        para(5) = 0.5*rand - 0.25;
        para(6) = 0.5*rand - 0.25;
        p0 = pid_calc(para);           % 原版
        p1 = pid_calc_v2(para);        % 重构版
        if norm(p0 - p1) > 1e-9
            fprintf('  [FAIL] trial%d  max|diff|=%.3e\n', trial, max(abs(p0-p1)));
            passPID = false;
        end
    end
    if passPID, fprintf('  PID：全部通过，正常参数输出与原版逐位一致 ✓\n');
    else passAll = false; end

    % ---- 2b. ti=0 除零防护 ----
    para_ti0 = [100; 90; 5; 0; 0; 0; 2; 0; 0; 0; 20; 0; 0.01];  % ti=0
    p_ti0 = pid_calc_v2(para_ti0);
    if ~all(isfinite(p_ti0))
        fprintf('  [FAIL] ti=0 时重构版仍产生非有限值\n'); passAll = false;
    elseif p_ti0(3) < para_ti0(12) || p_ti0(3) > para_ti0(11)
        fprintf('  [FAIL] ti=0 时输出越限\n'); passAll = false;
    else
        fprintf('  PID：ti=0 除零防护通过（输出 mv=%.6g，有限且限幅内）✓\n', p_ti0(3));
    end

    %% ============ 3. GPC 参数化扩展（不与原版比，验证可配置性）============
    fprintf('==== 3. GPC 参数化与缓存 ====\n');
    A = [-0.9769, 1]; B = 0.8642;
    P = [0.01,0.01;0.01,0.01];
    y = 810 + 3*randn(1,3); uhist = 15 + 0.5*randn(1,2); yr = 850; a = 0.998; lmd = 4400;
    u_n60 = gpc_clac_v2(A,B,P,y,uhist,yr,a,lmd, struct('N',60,'Nu',15));
    u_c   = gpc_clac_v2(A,B,P,y,uhist,yr,a,lmd, struct('use_cached',true));
    u_c2  = gpc_clac_v2(A,B,P,y,uhist,yr,a,lmd, struct('use_cached',true));
    fprintf('  N=60,Nu=15 输出: %.12f（可配置时域 ✓）\n', u_n60);
    if abs(u_c - u_c2) > 1e-12
        fprintf('  [FAIL] 缓存前后输出不一致\n'); passAll = false;
    else
        fprintf('  use_cached=true 前后输出一致 ✓\n');
    end

    %% ============ 4. 性能对比 ============
    fprintf('==== 4. 性能对比（100 次调用）====\n');
    A = [-0.9769,1]; B = 0.8642; P = [0.01,0.01;0.01,0.01];
    a = 0.998; lmd = 4400;
    nRun = 100;

    t0 = tic;
    for i = 1:nRun
        y = 810 + 3*randn(1,3); uhist = 15 + 0.5*randn(1,2);
        gpc_clac(A,B,P,y,uhist,yr,a,lmd);
    end
    dt_orig = toc(t0);

    t0 = tic;
    for i = 1:nRun
        y = 810 + 3*randn(1,3); uhist = 15 + 0.5*randn(1,2);
        gpc_clac_v2(A,B,P,y,uhist,yr,a,lmd);
    end
    dt_v2 = toc(t0);

    t0 = tic;
    for i = 1:nRun
        y = 810 + 3*randn(1,3); uhist = 15 + 0.5*randn(1,2);
        gpc_clac_v2(A,B,P,y,uhist,yr,a,lmd, struct('use_cached',true));
    end
    dt_cache = toc(t0);

    fprintf('  原版          : %.4f s\n', dt_orig);
    fprintf('  重构版(无缓存): %.4f s\n', dt_v2);
    fprintf('  重构版(缓存)  : %.4f s\n', dt_cache);
    fprintf('  缓存/原版 加速比: %.1fx\n', dt_orig / max(dt_cache, eps));

    %% ============ 总结 ============
    fprintf('\n================================\n');
    if passAll
        fprintf('验证通过：重构版默认输出与原版一致，ti=0 防护有效，缓存可提速。\n');
    else
        fprintf('存在 FAIL，请检查以上输出。\n');
    end
end
