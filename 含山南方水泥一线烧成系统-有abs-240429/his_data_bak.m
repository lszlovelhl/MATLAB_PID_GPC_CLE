function his_data(tempdata,ifdisconnect,days,title)
    %tempdata opc读取的数据
    %ifdisconnect 判断是否断开中控连接
    %days 数据存储天数
    global his_file_path his_file_row his_data last_path
    if ~isempty(tempdata)
        %%算上“日期时间”共60个标签，59个变量
% %         title = {'日期时间','一室篦床压力','一段篦冷机转速给定值','一段篦冷机转速测量值','二室篦床压力','一室风机电流左一',...
% %             '一室风机电流右一','一室风机电流左二','一室风机电流','高温风机出口负压','氨逃逸量','分解炉出口温度1',...
% %             '五级下料管出料口温度1','分解炉喂煤量给定值','分解炉喂煤量测量值','三次风温','窑头温度(二次风温)','窑尾温度',...
% %             '窑头喂煤量给定值','窑头喂煤量测量值','窑头负压','窑尾负压','回转窑轴电流','回转窑转速测量值','回转窑转速给定值',...
% %             '斗提电流1','阀门开度测量值','阀门开度给定值','喂料量测量值','喂料量给定值（冲板计流量）','头煤压力',...
% %             '高温风机转速给定','高温风机转速测量','系统负压','残氧(窑尾02)','煤仓重反馈','生料仓重设定','生料仓重反馈',...
% %             '氮氧化物含量','氨水调节阀','MDU工艺柜内氨水流量','喂料机速度给定','板喂（喂料）板喂机频率反馈',...
% %             '生料磨出口气体温度','生料磨进出口气体压差','提升机电流','生料磨入口气体压力右','生料磨入口气体压力左',...
% %             '生料磨磨机电流','带式输送机电流','板喂机清扫电机电流','宝马进出口压差测量','选粉机转速给定','选粉机转速测量',...
% %             '循环风机转速给定','循环风机转速测量','循环风机电流测量值','入窑生料累计','尾煤累计','头煤累计','二氧化硫含量'};
        sheet = 1;
        curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
%         path = strcat(his_file_path,curT(1,1:4),'年报表数据\',curT(1,6:7),'月报表数据\');
        if ~exist(his_file_path) 
            mkdir(his_file_path);
        end
        
        %!!!!这里注意要使用office2007以上版本的xlsx格式，因为xls只支持65536行，2007xlsx格式可以支持1048576行!!!
        path = strcat(his_file_path,curT(1,1:10),'_hisdt.xlsx'); %存储数据文件名路径，格式.xlsx注意

        %将读取的所需数据存储内存
        [r,~] = size(his_data);
        
        his_data(r+1,1) = {curT};  %字符串矩阵中，需要使用cell
        for i = 2:length(title)
            his_data(r+1,i) = {tempdata(i-1).Value};
        end
        
        if strcmp(curT(1,12:19),'00:00:00')
            %todo 只保存一个月数据
            list=dir(his_file_path); %因为list包含了. 和 .. 路径
            len = length(list);
            if len >= 3
                dmin = strsplit(list(3).name,'_');%前两个文件名为.和..所以去掉从3开始
                dmax = strsplit(list(len).name,'_');
                dminprefix = dmin(1);
                dmaxprefix = dmax(1);
                if abs(datenum(dmaxprefix)-datenum(dminprefix)) >= days
                    delete([his_file_path,list(3).name]); %前两个文件名为.和..所以去掉从3开始
                end
            end
            
            
            %todo 将his_data写入上个日期文件
            if isempty(last_path)
                last_path = path;
            end
            if(his_file_row == 1)
                xlRange = ['A',num2str(his_file_row)];
                xlswrite(last_path,title,sheet,xlRange);
            end
            xlRange = ['A',num2str(his_file_row+1)];
            xlswrite(last_path,his_data,sheet,xlRange);
            his_data = {};
            his_file_row = 1;
        elseif (r + 1) >= 120 || ifdisconnect      %一个小时存储一次或者ifdisconnect断开中控时直接存储已有数据
            %todo 将his_data写入当前日期文件
            if(his_file_row == 1)
                xlRange = ['A',num2str(his_file_row)];
                xlswrite(path,title,sheet,xlRange);
            end
            xlRange = ['A',num2str(his_file_row+1)];
            xlswrite(path,his_data,sheet,xlRange);
            his_data = {};
            his_file_row = his_file_row + (r + 1);
            last_path = path;
        end
    end
end