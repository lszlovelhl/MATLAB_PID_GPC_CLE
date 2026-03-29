function on_timer(obj,event,handles)
global  tempdata1 group1 data1 tempdatavalue1 itemset1 pidloop1 upid1
global  lastsave  daobj1
global  processtime 
global  first c b
global  pidloop hz yfj_max_value yfj_min_value buchang_value value
%% 获取Wincc中各变量的值

tic
try
    tempdata1 = read(group1);  % length(tempdata) = 68
    [~, c] = size(data1);
    for k = 1 : length(tempdata1)         % Wincc中的各变量值
        data1(k,c + 1) = tempdata1(k).Value;
        tempdatavalue1(k) = tempdata1(k).Value;
    end
    a = length(itemset1);
    %% 每小时data数据更新
    if c >= 3900
        first=0;
        datetime = datestr(now,30);
        s = ['save(''data1',datetime(1:8),datetime(10:11),'.mat'',''data1'');'];
        eval(s);
        lastsave = ['data1',datetime(1:8),datetime(10:11),'.mat'];
        data1(1 : 6,1) = fix(clock);
        data1( : ,2 : 301) = data1( : ,3602 : 3901);
        data1( : ,302 : 3901) = [];
        c = 300;
    end
    set(handles.ky_value,'String',num2str(data1(1,c+1),'%.2f'));    
    set(handles.my_value,'String',num2str(data1(3,c+1),'%.2f'));    
    yfj_max_value = str2double(get(handles.yfj_max_value,'String'));
    yfj_min_value = str2double(get(handles.yfj_min_value,'String'));
    buchang_value = str2double(get(handles.buchang_value,'String'));
    hz = pidloop(3,13);
    value = hz+buchang_value;
    
    if value >= yfj_max_value
        value = yfj_max_value;
    end
    if value <= yfj_min_value
        value = yfj_min_value;
    end
    %无扰切换
    %煤烟
    if data1(6,c+1) == 0
        write(itemset1(3),data1(8,c+1));
    end
    %空烟
    if data1(7,c+1) == 0
        write(itemset1(1),data1(9,c+1));
    end


    % 只有引风机切成自动时才会进行控制 引风机下限36  上限42
    if mod(c+1,10) == 0
    %煤烟
        if data1(6,c+1) == 1
             write(itemset1(3),value);    
        end
        if data1(7,c+1) == 1
            write(itemset1(1),value);
        end
    end
catch
    set(handles.alarm,'String','引风机连接已经中断，请切回手动');   
    set(handles.alarm,'BackgroundColor',[1 0 0]);
%  
end
processtime=toc;
end

                  


