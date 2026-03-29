function his_data(tempdata,ifdisconnect,days,title)
    %tempdata opc读取的数据
    %ifdisconnect 判断是否断开中控连接
    %days 数据存储天数
    global his_file_path his_file_row his_data last_path
    if ~isempty(tempdata)
        curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
%         path = strcat(his_file_path,curT(1,1:4),'年报表数据\',curT(1,6:7),'月报表数据\');
        if ~exist(his_file_path) 
            mkdir(his_file_path);
        end
        
        path = strcat(his_file_path,curT(1,1:10),'_hisdt.csv');

        %将读取的所需数据存储内存
        [his_data_row,his_data_col] = size(his_data);
        
        his_data(his_data_row+1,1) = {curT};  %字符串矩阵中，需要使用cell
        for i = 2:length(title)
            his_data(his_data_row+1,i) = {tempdata(i-1).Value};
        end
%         his_data(his_data_dow+1,i+1) = {flag_radio};
        if strcmp(curT(1,12:19),'00:00:00') || his_file_row >= 86400
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
            fid = fopen(last_path,'a');
            if(his_file_row == 1)
                for i = 1:length(title)
                    fprintf(fid,'%s,',char(title(i)));
                end
                fprintf(fid,'\n');
            end
            for i = 1:his_data_row
                fprintf(fid,'%s,',char(his_data(i,1)));
                for j = 2:his_data_col
                    fprintf(fid,'%f,',cell2mat(his_data(i,j)));
                end
                fprintf(fid,'\n');
            end
            fclose(fid);
            his_data = {};
            his_file_row = 1;
        elseif (his_data_row + 1) >= 120 || ifdisconnect      %一个小时存储一次或者ifdisconnect断开中控时直接存储已有数据
            %todo 将his_data写入当前日期文件
            if isempty(last_path)
                last_path = path;
            end
            fid = fopen(last_path,'a');
            if(his_file_row == 1)
                for i = 1:length(title)
                    fprintf(fid,'%s,',char(title(i)));
                end
                fprintf(fid,'\n');
            end
            for i = 1:his_data_row
                fprintf(fid,'%s,',char(his_data(i,1)));
                for j = 2:his_data_col
                    fprintf(fid,'%f,',cell2mat(his_data(i,j)));
                end
                fprintf(fid,'\n');
            end
            fclose(fid);
            his_data = {};
            his_file_row = his_file_row + (his_data_row + 1);
            last_path = path;
        end
    end
end