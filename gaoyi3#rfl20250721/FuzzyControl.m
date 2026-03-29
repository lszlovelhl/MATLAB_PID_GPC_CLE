%模糊控制器设计，放在主程序的“连接中控”部分，用于程序初始化的时候执行

% et_time用于统计降温所用的时间,如果时间超过90秒，et_Junre的值还是很大的话
% 此时煤气阀已经调节到下限了，程序开始将空气阀调节到零来迅速降低温度
% et_time的值在初始化的时候为零
global et_time ;
et_time = 0;

dlf = newfis('mod_cfgControl');

dlf = addvar(dlf,'input','Et',[-5,5]);                          %输入变量 Et
dlf = addmf(dlf,'input',1,'NB','zmf',[-5,-3]);				
dlf = addmf(dlf,'input',1,'NM','trimf',[-5,-3,-2]);
dlf = addmf(dlf,'input',1,'NS','trimf',[-3,-1,0]);
dlf = addmf(dlf,'input',1,'Z','trimf',[-0.5,0,0.5]);
dlf = addmf(dlf,'input',1,'PS','trimf',[0,1,3]);
dlf = addmf(dlf,'input',1,'PM','trimf',[2,3,5]);
dlf = addmf(dlf,'input',1,'PB','smf',[3,5]);

dlf=addvar(dlf,'input','ECt',[-5,5]);                           %输入变量 ECt
dlf = addmf(dlf,'input',2,'NB','zmf',[-5,-3]);
dlf = addmf(dlf,'input',2,'NM','trimf',[-5,-3,-2]);
dlf = addmf(dlf,'input',2,'NS','trimf',[-3,-1,0]);
dlf = addmf(dlf,'input',2,'Z','trimf',[-1,0,1]);
dlf = addmf(dlf,'input',2,'PS','trimf',[0,1,3]);
dlf = addmf(dlf,'input',2,'PM','trimf',[2,3,5]);
dlf = addmf(dlf,'input',2,'PB','smf',[3,5]);

dlf=addvar(dlf,'output','DeltaF1',[-5,5]);                     %输出变量 DeltaF1
dlf = addmf(dlf,'output',1,'NB','zmf',[-5,-3]);
dlf = addmf(dlf,'output',1,'NM','trimf',[-5,-3,-2]);
dlf = addmf(dlf,'output',1,'NS','trimf',[-3,-1,0]);
dlf = addmf(dlf,'output',1,'Z','trimf',[-1,0,1]);
dlf = addmf(dlf,'output',1,'PS','trimf',[0,1,3]);
dlf = addmf(dlf,'output',1,'PM','trimf',[2,3,5]);
dlf = addmf(dlf,'output',1,'PB','smf',[3,5]);


%模糊控制规则表   Et    ECt    output     weight    connection
dlRuleList = [        1 1 7 1 1;
                      1 2 7 1 1;
                      1 3 7 1 1;
                      1 4 6 1 1;
                      1 5 6 1 1;
                      1 6 5 1 1;
                      1 7 4 1 1;

                      2 1 7 1 1;
                      2 2 7 1 1;
                      2 3 6 1 1;
                      2 4 5 1 1;
                      2 5 5 1 1;
                      2 6 4 1 1;
                      2 7 3 1 1;

                      3 1 6 1 1;
                      3 2 6 1 1;
                      3 3 6 1 1;
                      3 4 5 1 1;
                      3 5 4 1 1;
                      3 6 3 1 1;
                      3 7 3 1 1;

                      4 1 6 1 1;
                      4 2 6 1 1;
                      4 3 5 1 1;
                      4 4 4 1 1;
                      4 5 3 1 1;
                      4 6 2 1 1;
                      4 7 2 1 1;

                      5 1 5 1 1;
                      5 2 5 1 1;
                      5 3 4 1 1;
                      5 4 3 1 1;
                      5 5 3 1 1;
                      5 6 2 1 1;
                      5 7 2 1 1;

                      6 1 5 1 1;
                      6 2 4 1 1;
                      6 3 3 1 1;
                      6 4 2 1 1;
                      6 5 2 1 1;
                      6 6 2 1 1;
                      6 7 1 1 1;

                      7 1 4 1 1;
                      7 2 4 1 1;
                      7 3 2 1 1;
                      7 4 2 1 1;
                      7 5 2 1 1;
                      7 6 1 1 1;
                      7 7 1 1 1;
 ];                                                     %-------------------------------------solved-------------------

dlf = addrule(dlf,dlRuleList);
% showrule(dlf)                                         %---------------------------------测试用-----------------------
dlf = setfis(dlf,'DefuzzMethod','centroid');            %设置模糊系统特性
writefis(dlf,'mod_cfg');                           %保存模糊系统