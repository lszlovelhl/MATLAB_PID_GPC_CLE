clear all



global group data tempdata itemset tempdatavalue daobj lastsave b temp_open time_count processtime upid_old apc_on upid feiqitemp_select  cxcx  max_airgaspotial min_airgaspotial feiqi_temp_set se_op_time max_min_timeFlag
global mv pressure pidloop A B workpoint P gpc_a gpc_lmd   tempu  airgaspotial loopnum deadzone time_airgaspotial time1_s time2_s time3_s good_airgaspotial  gas_lower max_burning min_burning  gdwendu   wendu_max1 wendu_max2 wendu_max3  wendu_middle1 wendu_middle2 wendu_middle3
global gap_on default_airgaspotial  left_time temp_set1 temp_set2 temp_set3  gas_limit   gdtemp  gdtemp_average1_1  gdtemp_average1_2  gdtemp_average2_1  gdtemp_average2_2  gdtemp_average3_1  gdtemp_average3_2 tem_dec_flag  sumOfFlow a_write p_write ff1 ff2 ff3 ff1_max ff2_max ff3_max
global default_airgaspotial_set time1_set time2_set time3_set ts1 ts2 ts3 gas_lower1 gas_lower2 gas_lower3 air_pressure
global pophandles identifier pophandles2 alarm_sound_flag FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS alarm_button_clicked 
global ifalarmsound airpressupperlimit airpresslowerlimit alarm_timer autoswitch autoshaolu burning gas_pressure gaspressupperlimit gaspresslowerlimit
global test1129 now_potial popmenuswitchorder selectedOrder airsp test1201 paramdata 





global older_default_airgaspotial old_default_airgaspotial side older_gdwendu old_gdwendu jiangwentime
global jiangwenmax jiangwenmin final_side his_side sidecount
%clear all
load('data2019113011.mat')

apc
default_airgaspotial(1)=0.55;
good_airgaspotial(1)=0.55;
default_airgaspotial(3)=0.7;
good_airgaspotial(3)=0.7;
clc

[~,lll]=size(data);
temp_open=[1,1,1];
se_op_time=31;
a=71;
for b=1:lll-1
    tp1 = data(5,b+1);
tp2 = data(24,b+1);
tp3 = data(43,b+1);
tp_1 = data(6,b+1);
tp_2 = data(25,b+1);
tp_3 = data(44,b+1);
tp_real1=tp1;
tp_real2=tp2;
tp_real3=tp3;
tp_real=[tp_real1 tp_real2 tp_real3];%三段拱顶温度实际值
t_real1=tp_1;
t_real2=tp_2;
t_real3=tp_3;
t_real=[t_real1;t_real2;t_real3];%%%三段废气温度实际值
ts1=1310;
ts2=1320;
ts3=1330;
burning1=1;
burning2=1;
burning3=1;
tsp=[ts1;ts2;ts3];




    if b>32
            gdtemp_sum1_1=sum(data(5,b-3:b+1)); %连续5s的拱顶温度
            gdtemp_sum1_2=sum(data(5,b-8:b-4));
            gdtemp_average1_1=gdtemp_sum1_1/5;
            gdtemp_average1_2=gdtemp_sum1_2/5;

            gdtemp_sum2_1=sum(data(24,b-3:b+1)); %连续5s的拱顶温度
            gdtemp_sum2_2=sum(data(24,b-8:b-4));
            gdtemp_average2_1=gdtemp_sum2_1/5;
            gdtemp_average2_2=gdtemp_sum2_2/5;

            gdtemp_sum3_1=sum(data(43,b-3:b+1)); %连续5s的拱顶温度
            gdtemp_sum3_2=sum(data(43,b-8:b-4));
            gdtemp_average3_1=gdtemp_sum3_1/5;
            gdtemp_average3_2=gdtemp_sum3_2/5;

            gdtemp1=[gdtemp_average1_1 gdtemp_average1_2];
            gdtemp2=[gdtemp_average2_1 gdtemp_average2_2];
            gdtemp3=[gdtemp_average3_1 gdtemp_average3_2];
            gdtemp=[gdtemp1;gdtemp2;gdtemp3];
            gdwendu(1)=(sum(data(5,b-13:b+1)))/15;
            gdwendu(2)=(sum(data(24,b-13:b+1)))/15;
            gdwendu(3)=(sum(data(43,b-13:b+1)))/15;
            a_gdwendu=gdwendu;
    else
        gdwendu(1)=data(5,b+1);
        gdwendu(2)=data(24,b+1);
        gdwendu(3)=data(43,b+1);
        old_gdwendu=gdwendu;
        older_gdwendu=old_gdwendu;
    end 
    

    
    
    
    
if b>=16
    airpv(1,1:16)=data(13,b-14:b+1);               % 一炉空气流量测量值==
    airpv(2,1:16)=data(32,b-14:b+1);               % 二炉空气流量测量值==
    airpv(3,1:16)=data(51,b-14:b+1);               % 三炉空气流量测量值==
    gaspv(1,1:16)=data(12,b-14:b+1);               % 一炉煤气流量测量值==
    gaspv(2,1:16)=data(31,b-14:b+1);               % 二炉煤气流量测量值==
    gaspv(3,1:16)=data(50,b-14:b+1);               % 三炉煤气流量测量值==   
    airmean=mean(airpv');
    gasmean=mean(gaspv');
    for i=1:16
        if abs(gaspv(1,i)-gasmean(1))>=30
            gaspv(1,i)=gasmean(1);
        end
        if abs(airpv(1,i)-airmean(1))>=30
            airpv(1,i)=airmean(1);
        end

        if abs(gaspv(2,i)-gasmean(2))>= 30              
            gaspv(2,i)=gasmean(2);
        end
        if abs(airpv(2,i)-airmean(2)) >= 30            
            airpv(2,i)=airmean(2);
        end

        if abs(gaspv(3,i)-gasmean(3))>= 30           
            gaspv(3,i)=gasmean(3);
        end
        if abs(airpv(3,i)-airmean(3)) >= 30            
            airpv(3,i)=airmean(3);
        end
    end
    gasmean=mean(gaspv');
    airmean=mean(airpv');
   elseif b>=10
        airpv(1,1:10)=data(13,b-8:b+1);               % 一炉空气流量测量值==
        airpv(2,1:10)=data(32,b-8:b+1);               % 二炉空气流量测量值==
        airpv(3,1:10)=data(51,b-8:b+1);               % 三炉空气流量测量值==
        gaspv(1,1:10)=data(12,b-8:b+1);               % 一炉煤气流量测量值==
        gaspv(2,1:10)=data(31,b-8:b+1);               % 二炉煤气流量测量值==
        gaspv(3,1:10)=data(50,b-8:b+1);               % 三炉煤气流量测量值==   
        airmean=mean(airpv');
        gasmean=mean(gaspv');
        for i=1:10
            if abs(gaspv(1,i)-gasmean(1))>=30
                gaspv(1,i)=gasmean(1);
            end
            if abs(airpv(1,i)-airmean(1))>=30
                airpv(1,i)=airmean(1);
            end

            if abs(gaspv(2,i)-gasmean(2))>= 30              
                gaspv(2,i)=gasmean(2);
            end
            if abs(airpv(2,i)-airmean(2)) >= 30              
                airpv(2,i)=airmean(2);
            end

            if abs(gaspv(3,i)-gasmean(3))>= 30            
                gaspv(3,i)=gasmean(3);
            end
            if abs(airpv(3,i)-airmean(3)) >= 30            
                airpv(3,i)=airmean(3);
            end
        end
        gasmean=mean(gaspv');
        airmean=mean(airpv');   
    else
        airmean(1)=data(13,b+1);
        airmean(2)=data(32,b+1);
        airmean(3)=data(51,b+1);
        gasmean(1)=data(12,b+1);
        gasmean(2)=data(31,b+1); 
        gasmean(3)=data(50,b+1);
end
if b>30
    if ((burning1==1)&&(tp_1<252))||((burning2==1)&&(tp_2<252))||((burning3==1)&&(tp_3<252))
        airpv(1,1:28)=data(13,b-26:b+1);               % 一炉空气流量测量值==
        airpv(2,1:28)=data(32,b-26:b+1);               % 二炉空气流量测量值==
        airpv(3,1:28)=data(51,b-26:b+1);               % 三炉空气流量测量值==
        gaspv(1,1:28)=data(12,b-26:b+1);               % 一炉煤气流量测量值==
        gaspv(2,1:28)=data(31,b-26:b+1);               % 二炉煤气流量测量值==
        gaspv(3,1:28)=data(50,b-26:b+1);               % 三炉煤气流量测量值==   
        airmean=mean(airpv');
        gasmean=mean(gaspv');
        for i=1:28
            if abs(gaspv(1,i)-gasmean(1))>=30
                gaspv(1,i)=gasmean(1);
            end
            if abs(airpv(1,i)-airmean(1))>=30
                airpv(1,i)=airmean(1);
            end

            if abs(gaspv(2,i)-gasmean(2))>= 30              
                gaspv(2,i)=gasmean(2);
            end
            if abs(airpv(2,i)-airmean(2)) >= 30              
                airpv(2,i)=airmean(2);
            end

            if abs(gaspv(3,i)-gasmean(3))>= 30            
                gaspv(3,i)=gasmean(3);
            end
            if abs(airpv(3,i)-airmean(3)) >= 30            
                airpv(3,i)=airmean(3);
            end
        end
        gasmean=mean(gaspv');
        airmean=mean(airpv');
    end
end
if b>10
    for i=1:3
        switch i
            case 1
                if max_min_timeFlag(i)>=0
                    airpv1(1:10)=data(13,b-8:b+1);               % 一炉空气流量测量值==
                    gaspv1(1:10)=data(12,b-8:b+1);               % 一炉煤气流量测量值==
                    airmean(i)=mean(airpv1);
                    gasmean(i)=mean(gaspv1);
                    for j=1:10
                        if abs(airpv1(j)-airmean(i)) >= 30            
                            airpv1(j)=airmean(i);
                        end
                        if abs(gaspv1(j)-gasmean(i))>= 30            
                            gaspv1(j)=gasmean(i);
                        end
                    end
                    airmean(i)=mean(airpv1);
                    gasmean(i)=mean(gaspv1);
                    max_min_timeFlag(i)=max_min_timeFlag(i)-1;
                end
            case 2
                if max_min_timeFlag(i)>=0
                    airpv2(1:10)=data(32,b-8:b+1);               % 二炉空气流量测量值==
                    gaspv2(1:10)=data(31,b-8:b+1);               % 二炉煤气流量测量值==
                    airmean(i)=mean(airpv2);
                    gasmean(i)=mean(gaspv2);
                    for j=1:10
                        if abs(airpv2(j)-airmean(i)) >= 30            
                            airpv2(j)=airmean(i);
                        end
                        if abs(gaspv2(j)-gasmean(i))>= 30            
                            gaspv2(j)=gasmean(i);
                        end
                    end
                    airmean(i)=mean(airpv2);
                    gasmean(i)=mean(gaspv2);
                    max_min_timeFlag(i)=max_min_timeFlag(i)-1;
                end
            case 3
                if max_min_timeFlag(i)>=0
                    airpv3(1:10)=data(51,b-8:b+1);               % 三炉空气流量测量值==
                    gaspv3(1:10)=data(50,b-8:b+1);               % 三炉煤气流量测量值==
                    airmean(i)=mean(airpv3);
                    gasmean(i)=mean(gaspv3);
                    for j=1:10
                        if abs(airpv3(j)-airmean(i)) >= 30            
                            airpv3(j)=airmean(i);
                        end
                        if abs(gaspv3(j)-gasmean(i))>= 30            
                            gaspv3(j)=gasmean(i);
                        end
                    end
                    airmean(i)=mean(airpv3);
                    gasmean(i)=mean(gaspv3);
                    max_min_timeFlag(i)=max_min_timeFlag(i)-1;
                end
        end
    end
end
%% 获取煤气空气流量
gas_f1=gasmean(1);
gas_f2=gasmean(2);
gas_f3=gasmean(3);
gas_f=[gas_f1;gas_f2;gas_f3];%此刻的煤气流量

air_f1=airmean(1);
air_f2=airmean(2);
air_f3=airmean(3);
air_f=[air_f1;air_f2;air_f3];

now_potial(1)=airmean(1)/(gasmean(1)+0.0001);
now_potial(2)=airmean(2)/(gasmean(2)+0.0001);
now_potial(3)=airmean(3)/(gasmean(3)+0.0001);



   

for i=1:3
    time_airgaspotial(i)=time_airgaspotial(i)-1;
    if time_airgaspotial(i)<-100
        time_airgaspotial(i)=-100;
    end
    jiangwentime(i)=jiangwentime(i)-1;
    if jiangwentime(i)<=-1
        jiangwentime(i)=-1;
        jiangwenmax(i)=0;
        jiangwenmin(i)=0;
    end
      sidecount(i)=sidecount(i)-1;
    if sidecount(i)<-100
        sidecount(i)=-100;
    end
end


if b>50
    if(mod(b,se_op_time)==0)
         for i=1:3
             switch i
                case 1
                     if((tp_real(i)<tsp(i)-3)&&(gdtemp(i,1)-gdtemp(i,2)<=-0.15)&&time_airgaspotial(i)~=0)
                         time_airgaspotial(i)=se_op_time; %如果改动29，总共需改动7处
                         default_airgaspotial(i)=default_airgaspotial(i)-0.05*final_side(i);
                          tem_dec_flag(i)=1;
                     elseif ((tp_real(i)<tsp(i)-3)&&(tem_dec_flag(i)==1)&&(time_airgaspotial(i)==0))
                              default_airgaspotial(i)=default_airgaspotial(i)+0.1*final_side(i);
                     end
                 case 2
                    if((tp_real(i)<tsp(i)-3)&&(gdtemp(i,1)-gdtemp(i,2)<=-0.15)&&time_airgaspotial(i)~=0)
                         time_airgaspotial(i)=se_op_time;
                         default_airgaspotial(i)=default_airgaspotial(i)-0.05*final_side(i);
                         tem_dec_flag(i)=1;
                    elseif ((tp_real(i)<tsp(i)-3)&&(tem_dec_flag(i)==1)&&(time_airgaspotial(i)==0))
                          default_airgaspotial(i)=default_airgaspotial(i)+0.1*final_side(i);
                    end 
                 case 3
                    if((tp_real(i)<tsp(i)-3)&&(gdtemp(i,1)-gdtemp(i,2)<=-0.15)&&time_airgaspotial(i)~=0)
                         time_airgaspotial(i)=se_op_time;
                         default_airgaspotial(i)=default_airgaspotial(i)-0.05*final_side(i);
                         tem_dec_flag(i)=1;
                    elseif ((tp_real(i)<tsp(i)-3)&&(tem_dec_flag(i)==1)&&(time_airgaspotial(i)==0))
                          default_airgaspotial(i)=default_airgaspotial(i)+0.1*final_side(i);
                    end 
             end
         end
    end
    
    %% 升温再寻优
    for i=1:3
         switch i
            case 1
                 if((gdwendu(i)<tsp(i)-7)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)>=max_airgaspotial(1))&&(mod(b,199)==0))                             
                     default_airgaspotial(i)=default_airgaspotial(i)-0.05;
                 end

                 if((gdwendu(i)<tsp(i)-7)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)<=min_airgaspotial(1))&&(mod(b,199)==0))
                          default_airgaspotial(i)=default_airgaspotial(i)+0.05;
                 end
             case 2
                if ((gdwendu(i)<tsp(i)-7)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)>=max_airgaspotial(2))&&(mod(b,199)==0))                   
                     default_airgaspotial(i)=default_airgaspotial(i)-0.05;
                end    
                if ((gdwendu(i)<tsp(i)-7)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)<=min_airgaspotial(2))&&(mod(b,199)==0))
                      default_airgaspotial(i)=default_airgaspotial(i)+0.05;
                end 
             case 3
                if ((gdwendu(i)<tsp(i)-7)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)>=max_airgaspotial(3))&&(mod(b,199)==0))                            
                     default_airgaspotial(i)=default_airgaspotial(i)-0.05;
                end   
                if (((gdwendu(i)<tsp(i)-7)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)<=min_airgaspotial(3))&&(mod(b,199)==0)))
                      default_airgaspotial(i)=default_airgaspotial(i)+0.05;
                end 
         end
    end
   
    
    
    for i=1:3
        switch i
            case 1
                if time_airgaspotial(i)<=se_op_time-2
                    tem1=data(5,b+1);
                    tem2=data(5,b-1);
                    if (tem1-tem2)<=0
                        flag=1;
                    else
                        flag=0;
                    end
                    tem_dec_flag(i)=tem_dec_flag(i)*flag;
                end
            case 2
                if time_airgaspotial(i)<=se_op_time-2
                    tem1=data(24,b+1);
                    tem2=data(24,b-1);
                    if (tem1-tem2)<=0
                        flag=1;
                    else
                        flag=0;
                    end
                    tem_dec_flag(i)=tem_dec_flag(i)*flag;
                end
            case 3
                if time_airgaspotial(i)<=se_op_time-2
                    tem1=data(43,b+1);
                    tem2=data(43,b-1);
                    if (tem1-tem2)<=0
                        flag=1;
                    else
                        flag=0;
                    end
                    tem_dec_flag(i)=tem_dec_flag(i)*flag;
                end
        end
    end
end    
for i=1:3
    if default_airgaspotial(i)<min_airgaspotial(i)
       default_airgaspotial(i)=min_airgaspotial(i);
       good_airgaspotial(i)=default_airgaspotial(i);
    end 
    if default_airgaspotial(i)>max_airgaspotial(i)
       default_airgaspotial(i)=max_airgaspotial(i);
       good_airgaspotial(i)=default_airgaspotial(i);
    end
       
end

 for i=1:3      %根据空燃比配空气流量
     %         airsp(i)=tempu(i).*airgaspotial(i);
     %温度回路输出空气流量设定值上下限
     switch i
         case 1                              % 1#
             if(gdwendu(i)>ts1+3&&gdwendu(i)<ts1+6)
                 default_airgaspotial(1)=good_airgaspotial(1)+0.04*final_side(i);
             else if(gdwendu(i)>=ts1+7&&gdwendu(i)<ts1+9)
                     default_airgaspotial(1)=good_airgaspotial(1)+0.08*final_side(i);
                 else if(gdwendu(i)>=ts1+9&&gdwendu(i)<ts1+12)
                         default_airgaspotial(1)=good_airgaspotial(1)+0.12*final_side(i);
                     else if(gdwendu(i)>=ts1+12)
                             default_airgaspotial(1)=good_airgaspotial(1)+0.15*final_side(i);
                             
                         else
                             default_airgaspotial(1)=good_airgaspotial(1);
                         end
                     end
                 end
             end
             
             
            
             
               if(temp_open(i) ==0)
%                 default_airgaspotial(i)=min_airgaspotial(i);
                  default_airgaspotial(i)=roundn(data(7+19*(i-1)),-2);
                if default_airgaspotial(i)<min_airgaspotial(i)
                   default_airgaspotial(i)=min_airgaspotial(i);
                end 
                if default_airgaspotial(i)>max_airgaspotial(i)
                   default_airgaspotial(i)=max_airgaspotial(i);
                end
                good_airgaspotial(i)=default_airgaspotial(i); 
              end
             
             if(gap_on(1)==1)
                 airsp(i)=tempu(i).*default_airgaspotial(1);
             else
                 airsp(i)=tempu(i).*default_airgaspotial(i);
             end
             if airsp(i)>=ff1_max
                 airsp(i)=ff1_max;
             end
             if airsp(i)<=120
                 airsp(i)=120;
             end
         case 2                                  % 2#
             if(gdwendu(i)>ts2+3&&gdwendu(i)<ts2+6)
                 default_airgaspotial(2)=good_airgaspotial(2)+0.03*final_side(i);
             else if(gdwendu(i)>=ts2+6&&gdwendu(i)<ts2+9)
                     default_airgaspotial(2)=good_airgaspotial(2)+0.06*final_side(i);
                 else if(gdwendu(i)>=ts2+9&&gdwendu(i)<ts2+12)
                         default_airgaspotial(2)=good_airgaspotial(2)+0.09*final_side(i);
                     else if(gdwendu(i)>=ts2+12)
                             default_airgaspotial(2)=good_airgaspotial(2)+0.12*final_side(i);
                         else
                             default_airgaspotial(2)=good_airgaspotial(2);
                         end
                     end
                 end
             end
               if(temp_open(i) ==0)
%                 default_airgaspotial(i)=min_airgaspotial(i);
                  default_airgaspotial(i)=roundn(data(7+19*(i-1)),-2);
                if default_airgaspotial(i)<min_airgaspotial(i)
                   default_airgaspotial(i)=min_airgaspotial(i);
                end 
                if default_airgaspotial(i)>max_airgaspotial(i)
                   default_airgaspotial(i)=max_airgaspotial(i);
                end
                good_airgaspotial(i)=default_airgaspotial(i);
              end
             
             if(gap_on(2)==1)
                 airsp(i)=tempu(i).*default_airgaspotial(2);
             else
                 airsp(i)=tempu(i).*default_airgaspotial(i);
             end
             if airsp(i) >= ff2_max
                 airsp(i) = ff2_max;
             end
             if airsp(i) <= 120
                 airsp(i) = 120;
             end
         case 3                                  % 3#
             if(gdwendu(i)>ts3+3&&gdwendu(i)<ts3+6)
                 default_airgaspotial(3)=good_airgaspotial(3)+0.04*final_side(i);
             else if(gdwendu(i)>=ts3+6&&gdwendu(i)<ts3+9)
                     default_airgaspotial(3)=good_airgaspotial(3)+0.08*final_side(i);
                 else if(gdwendu(i)>=ts3+9&&gdwendu(i)<ts3+12)
                         default_airgaspotial(3)=good_airgaspotial(3)+0.12*final_side(i);
                     else if(gdwendu(i)>=ts3+12)
                             default_airgaspotial(3)=good_airgaspotial(3)+0.15*final_side(i);
                         else
                             default_airgaspotial(3)=good_airgaspotial(3);
                         end
                     end
                 end
             end
             if(temp_open(i) ==0)
%                 default_airgaspotial(i)=min_airgaspotial(i);
                  default_airgaspotial(i)=roundn(data(7+19*(i-1)),-2);
                if default_airgaspotial(i)<min_airgaspotial(i)
                   default_airgaspotial(i)=min_airgaspotial(i);
                end 
                if default_airgaspotial(i)>max_airgaspotial(i)
                   default_airgaspotial(i)=max_airgaspotial(i);
                end
                good_airgaspotial(i)=default_airgaspotial(i); 
              end
             
             if(gap_on(3)==1)
                 airsp(i)=tempu(i).*default_airgaspotial(3);
             else
                 airsp(i)=tempu(i).*default_airgaspotial(i);
             end
             if airsp(i) >= ff3_max
                 airsp(i) = ff3_max;
             end
             if airsp(i) <= 120
                 airsp(i) = 120;
             end
     end
 end
 
   %% 降温再寻优
     for i=1:3
         switch i
            case 1
                 if (((gdwendu(i)>tsp(i)+15)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)>=max_airgaspotial(i))&&(mod(b,199)==0&&jiangwentime(i)<0))||(jiangwentime(i)>=0&&jiangwenmax(i)))                           
%                      default_airgaspotial(i)=max_airgaspotial(i)-0.05;
                        jiangwenmax(i)=1;
                        jiangwenmin(i)=0;
                     side(i)=-1;
                     if jiangwentime(i)<0
                         jiangwentime(i)=37;
                     end
                 end

                if (((gdwendu(i)>tsp(i)+15)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)<=min_airgaspotial(i))&&(mod(b,199)==0&&jiangwentime(i)<0))||(jiangwentime(i)>=0&&jiangwenmin(i)))  
                     
%                      default_airgaspotial(i)=min_airgaspotial(i)+0.05; 
                        jiangwenmax(i)=0;
                        jiangwenmin(i)=1;
                     side(i)=1;
                     if jiangwentime(i)<0
                         jiangwentime(i)=37;
                     end
                 end
             case 2
              if (((gdwendu(i)>tsp(i)+15)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)>=max_airgaspotial(i))&&(mod(b,199)==0&&jiangwentime(i)<0))||(jiangwentime(i)>=0&&jiangwenmax(i)))   
%                      default_airgaspotial(i)=max_airgaspotial(i)-0.05;
                        jiangwenmax(i)=1;
                        jiangwenmin(i)=0;
                     side(i)=-1;
                     if jiangwentime(i)<0
                         jiangwentime(i)=37;
                     end
                end    
                if (((gdwendu(i)>tsp(i)+15)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)<=min_airgaspotial(i))&&(mod(b,199)==0&&jiangwentime(i)<0))||(jiangwentime(i)>=0&&jiangwenmin(i)))  
%                       default_airgaspotial(i)=min_airgaspotial(i)+0.05;
                        jiangwenmax(i)=0;
                        jiangwenmin(i)=1;
                      side(i)=1;
                      if jiangwentime(i)<0
                         jiangwentime(i)=37;
                     end
                end 
             case 3
            if (((gdwendu(i)>tsp(i)+15)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)>=max_airgaspotial(i))&&(mod(b,199)==0&&jiangwentime(i)<0))||(jiangwentime(i)>=0&&jiangwenmax(i)))                       
%                      default_airgaspotial(i)=max_airgaspotial(i)-0.05;
                        jiangwenmax(i)=1;
                        jiangwenmin(i)=0;
                     side(i)=-1;
                     if jiangwentime(i)<0
                         jiangwentime(i)=37;
                     end
            end   
            if (((gdwendu(i)>tsp(i)+15)&&(t_real(i)>feiqi_temp_set(i))&&(default_airgaspotial(i)<=min_airgaspotial(i))&&(mod(b,199)==0&&jiangwentime(i)<0))||(jiangwentime(i)>=0&&jiangwenmin(i)))  
%                       default_airgaspotial(i)=min_airgaspotial(i)+0.05;
                        jiangwenmax(i)=0;
                        jiangwenmin(i)=1;
                      side(i)=1;
                      if jiangwentime(i)<0
                         jiangwentime(i)=37;
                     end
                end 
         end
        end
 
 for i=1:3
    if default_airgaspotial(i)<min_airgaspotial(i)
       default_airgaspotial(i)=min_airgaspotial(i);
       good_airgaspotial(i)=default_airgaspotial(i);
    end 
    if default_airgaspotial(i)>max_airgaspotial(i)
       default_airgaspotial(i)=max_airgaspotial(i);
       good_airgaspotial(i)=default_airgaspotial(i);
    end
     a_his_airgaspotial(i,b+1)=default_airgaspotial(i);
 end

%% 判断左右侧
 for i=1:3
    if old_default_airgaspotial(i)~=default_airgaspotial(i)
        older_default_airgaspotial(i)=old_default_airgaspotial(i);
        older_gdwendu(i)=old_gdwendu(i);
        old_default_airgaspotial(i)=default_airgaspotial(i);
        old_gdwendu(i)=gdwendu(i);

        if(old_default_airgaspotial(i)<older_default_airgaspotial(i))&&(gdwendu(i)-old_gdwendu(i)<old_gdwendu(i)-older_gdwendu(i))|| ...
           (old_default_airgaspotial(i)>older_default_airgaspotial(i))&&(gdwendu(i)-old_gdwendu(i)>old_gdwendu(i)-older_gdwendu(i))
            side(i)=-1;
        end
        if(old_default_airgaspotial(i)>older_default_airgaspotial(i))&&(gdwendu(i)-old_gdwendu(i)<=old_gdwendu(i)-older_gdwendu(i))|| ...
           (old_default_airgaspotial(i)<older_default_airgaspotial(i))&&(gdwendu(i)-old_gdwendu(i)>=old_gdwendu(i)-older_gdwendu(i))||...
           (old_default_airgaspotial(i)==older_default_airgaspotial(i))
            side(i)=1;
        end
      
    end 

     data(a+23+i,b+1)=side(i);
     a_side(i,b+1)=side(i);
     his_side(i,25)=side(i);
     for j=1:24
         his_side(i,j)=his_side(i,j+1);
     end
     final_side(i)=round(mean(his_side(i,:)));
     if final_side(i)==0
         final_side(i)=1;
     end
     data(a+26+i,b+1)=final_side(i);
     if data(a+26+i,b+1)~=data(a+26+i,b)||sidecount(i)>=0

         if sidecount(i)>=0
            final_side(i)=data(a+26+i,b);
         end
         if sidecount(i)<0
            sidecount(i)=60;
         end
     end
     data(a+26+i,b+1)=final_side(i);
 end

end