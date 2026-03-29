function [Flow_gas_Compute] = FuzzyCompute1(T_SV,TTT_real,ECT_real_C,Flow_gas_zero_Set,Flow_air_zero_Set)
% 参数说明
% T_SV 温度设定值  
% TTT_real 温度实际值
% ECT_real_C 温度变化率的实际值
% Falve_gas_zero_Set 煤气流量当前值
% Falve_air_zero_Set 空气流量当前值
% Falve_gas_Compute 煤气流量计算值


%师兄原程序每6秒执行一次模糊控制算法

Flow_gas_HHLimit = 15000;        %煤气流量的上限
Flow_gas_LLlimit = 2000;          %煤气流量的下限

et_temp = TTT_real - T_SV;							%实际et值，get T from wincc by opc      负值需要升温，正值需要降温


%为了温度调节的较快
%当温度的偏差大于5度时，设置温度偏差的最大值为+-50度，温度偏差的变化率为+-1，Flow_gas变化最大为1.4
%为了温度调节的较准
%当温度的偏差小于5度时，设置温度偏差的最大值为+-5度，温度偏差的变化率为+-0.4，Flow_gas变化最大为0.6
if(abs(et_temp) >= 8)                                       % 调整et 和 ect的权值，使其能精确化控制
    et_weight = 30;
    ect_weight = 1.1;

    Flow_gas_weight = 2500;                             % 温度偏差大于6度时煤气流量调节的速度
    
 else if(abs(et_temp) >= 5&&abs(et_temp)<8)                                       % 调整et 和 ect的权值，使其能精确化控制
    et_weight = 20;
    ect_weight = 0.92;

    Flow_gas_weight = 2000;
else
    et_weight = 12;
    ect_weight = 0.68;
    
    Flow_gas_weight =1800;                           % 温度偏差小于6度时煤气流量的调节速度
    
     end
end


%t_max = T_SV + et_weight;
%t_min = T_SV - et_weight;

et_max = 1 * et_weight;
et_min = -1 * et_weight;							  % et的范围[et_min,et_max]
	
if et_temp > et_max
    et_temp = et_max;
end
if et_temp < et_min
    et_temp = et_min;                                  % 设置et_temp的上下限
end

E_MIN = -5;
E_MAX = 5;

k_et =  (E_MAX - E_MIN) / (et_max - et_min);	% k
et_convert = (E_MAX + E_MIN) / 2 + k_et * (et_temp - (et_max + et_min) / 2);               % 将温度的范围映射到[-5,5] 尺度变换

% ECT_real_C = 2;                                             
% ec的实际变化范围基本上自己确定
ect_min = -1 * ect_weight;
ect_max = 1 * ect_weight;
EC_MIN = -5;
EC_MAX = 5;

if ECT_real_C > ect_max
    ECT_real_C = ect_max;
end
if ECT_real_C < ect_min
    ECT_real_C = ect_min;
end

k_ect_y = (EC_MAX - EC_MIN)/(ect_max - ect_min);                                    % k_ect_y
ect_convert = (EC_MAX + EC_MIN)/2 + k_ect_y * (ECT_real_C - (ect_max + ect_min)/2); % 将温度变化率的范围映射到[-5,5]


% 直接将Flow的值映射到[-5 5]区间内，也即最后算得的f值直接利用k转换回来就ok啦
Flow_gas_zero =Flow_gas_zero_Set;                               % 煤气流量当前值
Flow_gas_min = Flow_gas_zero - 1 * Flow_gas_weight;             % 煤气流量变化最小值                                
Flow_gas_max = Flow_gas_zero + 1 * Flow_gas_weight;             % 煤气流量变化最大值

Flow_gas_MIN = -5;
Flow_gas_MAX = 5;
k_Flow_gas = (Flow_gas_MAX - Flow_gas_MIN)/(Flow_gas_max - Flow_gas_min);		% 根据这个将算得的Flow_gas值输出控制值就好啦

                  
 % 从磁盘读出保存的模糊系统
ylf = readfis('QinyouFuzzy');                         

% 此处算得的为Flow_gas_convert，需要根据k_Flow_gas计算得实际输出值
Flow_gas_convert = evalfis([double(et_convert),ect_convert],ylf);             % et_convert、ect_convert为et和ect转换后的值
% 至此模糊计算完毕

% 将Flow_gas_convert转换为Flow实际论域中的值，利用k_Flow_gas
Flow_gas_Compute = (Flow_gas_convert - (Flow_gas_MAX + Flow_gas_MIN) / 2) / k_Flow_gas + (Flow_gas_max + Flow_gas_min) / 2 ; 

Flow_gas_Compute = round(Flow_gas_Compute);
if Flow_gas_Compute > Flow_gas_HHLimit            % 煤气流量位上限     
    Flow_gas_Compute = Flow_gas_HHLimit;
end
if Flow_gas_Compute < Flow_gas_LLlimit            % 煤气流量位下限
    Flow_gas_Compute = Flow_gas_LLlimit;
end


end