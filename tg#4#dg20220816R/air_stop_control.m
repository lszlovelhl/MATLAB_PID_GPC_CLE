function [ output_args ] = air_stop_control(ky_sp,air,air_write,tmep_location,temp1_location)
% 解决换向扰动大问题
% ky_sp 补偿的阀位
% air 第几个空烟
% air_write 写入的变量位置
% tmep_location  传入实际空烟温度的位置
% temp1_location 出入设定空烟温度的位置
global air_temp air_stop upid pidloop itemset air_value data b
    value = 6;
    
    if air_temp(air) >= 140 && air_stop(air) == 0 && pidloop(10,air+value) == 0
        %温度超过140 判断是否有下降趋势
        if b > 8
            if data(tmep_location,b+1) - data(tmep_location,b) < 0 &&...
               data(tmep_location,b) - data(tmep_location,b-1) < 0 &&...
               data(tmep_location,b-1) - data(tmep_location,b-2) < 0 &&...
               data(tmep_location,b-2) - data(tmep_location,b-3) < 0
                    air_stop(air) = 1;
                    air_value(air) = data(air_write,b+1); %停止pid控制前的阀位
                    pidloop(10,air+value) = 1;
            end
        end
    end
    if air_stop(air) == 1
        if pidloop(2,air+value) >= 140%data(temp1_location)
            write(itemset(air_write),round(air_value(air)+ky_sp));
        else
            pidloop(10,air+value) = 0;
            air_stop(air) = 0;
        end
    end
end

