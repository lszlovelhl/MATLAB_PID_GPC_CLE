function newpara = pid_calc_v2(para)
%PID_CALC_V2  增量式 PID——重构版（高义热风炉工程）。
%
%   newpara = pid_calc_v2(para)
%
%   接口与本工程原版 pid_calc.m（函数名 pid）完全兼容：入参、出参均为 13
%   元素列向量。正常参数下输出与原版逐位一致；相对原版仅修复 ti<=0 时
%   除零导致的 Inf/NaN 问题。
%
%   参数向量 para（13 元素，按行号语义）：
%     1  sp       设定值
%     2  pv       过程值
%     3  mv       输出（上一时刻）
%     4  e0       当前误差 e0 = sp - pv（原版不读此项，由 1-2 现算，保留占位）
%     5  e1       上一次误差
%     6  e2       上上次误差
%     7  kp       比例增益
%     8  ti       积分时间（原版此处除零风险：ti=0 → 1/ti=Inf）
%     9  td       微分时间
%     10 man_on   手动/自动标志（原版未使用，保留占位）
%     11 ulim     输出上限
%     12 llim     输出下限
%     13 deadzone 死区（|pv-sp| 小于等于此值时输出不变）
%
%   控制律（增量式，与原版逐行一致）：
%     du = kp * [ (e0-e1) + e0/ti + td*(e0-2*e1+e2) ]
%     死区：if abs(pv-sp) <= deadzone → du = 0   （注意是 <=，本现场边界行为）
%     mv = mv + du，随后限幅到 [llim, ulim]
%     误差滚动：e2 = e1; e1 = e0
%
%   与原版的差异（仅以下两点，其余逐行保持）
%     1. 修复 ti<=0 除零：积分项在 ti<=0 时置零并告警，避免输出冲成 Inf/NaN；
%        ti>0 时积分项 e0/ti 的计算与原版逐位一致。
%     2. 增加输入长度校验（不足 13 元素报错）、变量命名清晰、补充每行语义注释。
%
%   注意：原版函数名为 pid，本重构版函数名为 pid_calc_v2，接入时调用处需改名。

    % ---- 输入校验 ----
    if ~isnumeric(para) || numel(para) < 13
        error('pid_calc_v2:badInput', 'para 必须为至少 13 元素的数值向量。');
    end
    para = para(:);                       % 统一为列向量

    % ---- 解析参数（与原版行号一一对应）----
    sp    = para(1);
    pv    = para(2);
    mv    = para(3);
    e0    = para(1) - para(2);            % 当前误差 e0 = sp - pv（现算，与原版一致）
    e1    = para(5);                      % 上一次误差
    e2    = para(6);                      % 上上次误差
    kp    = para(7);                      % 比例增益
    ti    = para(8);                      % 积分时间
    td    = para(9);                      % 微分时间
    man_on = para(10);                    % 手动/自动标志（原版未使用，保留）
    ulim  = para(11);                    % 输出上限
    llim  = para(12);                    % 输出下限
    deadzone = para(13);                  % 死区宽度

    % ---- 增量式 PID 控制律 ----
    if ti > 0
        integral_term = e0 / ti;          % 积分项（ti>0 时与原版逐位一致）
    else
        integral_term = 0;                % 修复除零：ti<=0 时禁用积分项
        warning('pid_calc_v2:tiNonPositive', 'ti=%g 非法，积分项已禁用。', ti);
    end
    du = kp * ((e0 - e1) + integral_term + td * (e0 - 2*e1 + e2));

    % ---- 死区：误差足够小时输出不变 ----
    % 【现场边界行为，必须保留 <=】|pv-sp| 恰好等于 deadzone 时也冻结输出
    if abs(pv - sp) <= deadzone
        du = 0;
    end

    % ---- 输出更新与限幅 ----
    mv = mv + du;
    if mv >= ulim, mv = ulim; end
    if mv <= llim, mv = llim; end

    % ---- 误差历史滚动 ----
    e2 = e1;
    e1 = e0;

    % ---- 组装返回向量（保持与原版一致的结构与顺序）----
    newpara = [sp pv mv e0 e1 e2 kp ti td man_on ulim llim deadzone]';
end
