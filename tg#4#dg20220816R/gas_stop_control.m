function [ output_args ] = gas_stop_control( ky_sp,gas,gas_write,tmep_location,temp1_location )
% ky_sp 补偿的阀位
% gas 第几个煤烟
% gas_write 写入的变量位置
% tmep_location  传入实际空烟温度的位置
% temp1_location 出入设定空烟温度的位置
global gas_temp gas_stop upid pidloop itemset gas_value data b
    value = 9;
    if gas_temp(gas) >= 140 && gas_stop(gas) == 0 && pidloop(10,gas+value) == 0
        if b > 8
            if data(tmep_location,b+1) - data(tmep_location,b) < 0 &&...
               data(tmep_location,b) - data(tmep_location,b-1) < 0 &&...
               data(tmep_location,b-1) - data(tmep_location,b-2) < 0 &&...
               data(tmep_location,b-2) - data(tmep_location,b-3) < 0
                    gas_stop(gas) = 1;
                    gas_value(gas) = data(gas_write,b+1); %停止pid控制前的阀位
                    pidloop(10,gas+value) = 1;
            end
        end
       
    end
    if gas_stop(gas) == 1
        if pidloop(2,gas+value) >= 140 %data(temp1_location)
            write(itemset(gas_write),round(gas_value(gas) + ky_sp)); 
        else
            pidloop(10,gas+value) = 0;
            gas_stop(gas) = 0;
        end
    end

end

