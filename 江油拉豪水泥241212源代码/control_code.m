global data pidloop itemset
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on 
global workpoint Up A B P gpc_a gpc_lmd



%% 获取自动控制开关信息

    if 0==first_cooler_rev_on
        pidloop(10,1)=1;
    else
        pidloop(10,1)=0;
    end
    
    if 0==decomposing_furnace_tempr_on
        pidloop(10,2)=1;
    else
        pidloop(10,2)=0;
    end
   %% 一段篦冷机PID参数设置 
  
    pidloop(1,1)=g11_current_sp;
    pidloop(2,1)=data(5,b+1);
    pidloop(7,1)=0.7;
   %修改：根据不同负荷可能需要分段调整Kp
    pidloop(8,1)=1000;%修改：过程中可能含积分环节，所以Ti减小
    pidloop(9,1)=0.01;
  
    
    pidloop(11,1)=40; %修改：根据现场调节上限
    pidloop(12,1)=10; %修改：根据现场调节下限
%% 一段篦冷机PID积分分离
 
%     if abs(pidloop(1,3)-pidloop(2,3))>=350
%         pidloop(2,3)=pidloop(1,3);
% %         pidloop(7,3)=0.028;
% %         pidloop(8,3)=200;
%         furnace_pressure_open=0;
%         set(handles. furnace_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);%将打开设置为灰色
%         set(handles. furnace_pressure_close,'BackgroundColor',[1 0  0]);%将关闭设置为红色
%     end
%% 计算各段篦冷机PID控制量
 [~, loopnum]=size(pidloop);
  

    % 各控制量的PID计算式
       if mod(b,5)==1
        if pidloop(10,1)==0
           
        pidloop(:,1)=pid_calc(pidloop(:,1)');
        pidloop(3,1)=round(pidloop(3,1)*10)/10;%修改：根据现场调节给定精度
        upid(1)=pidloop(3,1); 
        
        end
       end  
       
       
     upid(2)=1.4*upid(1);   
     upid(3)=2*upid(1);   

   %% 温度GPC主程序
if b>10
        if(mod(b,3)==1)
            workpoint=[22.9441441441444,868.519096305779];
            Up=data(27,b:b+1)-workpoint(1);
            A=[-0.995966846667114,1];
            B=[0.0907190164069290];
            P=[0.01,0.01;0.01,0.01];
            gpc_a=0.9;
            gpc_lmd=2;
            gpc_decomposing_furnace_tempr_2_sp=decomposing_furnace_tempr_2_sp-workpoint(2);
            yout=data(20,b-1:b+1)-workpoint(2);
            u_decomposing_furnace_tempr=workpoint(1)+round(gpc_clac(A,B,P,yout,Up,gpc_decomposing_furnace_tempr_2_sp,gpc_a,gpc_lmd)*10)/10;
        end
  
end
  %% 无扰切换         
         loopnum=4;%修改：
    for i=1:loopnum
        switch i
            case 1
                if pidloop(10,1)==1 
                    pidloop(1,1)=pidloop(2,1);
                    pidloop(3,1)=data(4,b+1);
                    upid(1)=pidloop(3,1);  
                    pidloop(4,1)=0;
                    pidloop(5,1)=0;
                    pidloop(6,1)=0;
                end
               
             case 2
                if 0==second_cooler_rev_on
                    upid(2)=data(12,b+1);
                end
                
              case 3
                if 0==third_cooler_rev_on
                    upid(3)=data(17,b+1);
                end  
                
               case 4
                if 0==decomposing_furnace_tempr_on
                    u_decomposing_furnace_tempr=data(27,b+1);
                      Up=[data(27,b+1),data(27,b+1)];
                  Up1=[data(27,b+1),data(27,b+1)];
                    
                end    
                
        end
        
        
    end
    

  
               
   %% 增量上下限处理
    if upid(1)<=(data(5,b)-0.2)    %%修改：根据现场实际
        upid(1)=data(5,b)-0.2;
    end
    if upid(1)>=(data(5,b)+0.2)
        upid(1)=data(5,b)+0.2;
    end
    
    if upid(2)<=(data(13,b)-0.3)    %%修改：根据现场实际
        upid(2)=data(13,b)-0.3;
    end
    if upid(2)>=(data(13,b)+0.3)
        upid(2)=data(13,b)+0.3;
    end
    
     if upid(3)<=(data(18,b)-0.5)    %%修改：根据现场实际
        upid(3)=data(18,b)-0.5;
    end
    if upid(3)>=(data(18,b)+0.5)
        upid(3)=data(18,b)+0.5;
    end
   %% 
       if u_decomposing_furnace_tempr<=(data(28,b)-0.5)    %%修改：根据现场实际
        u_decomposing_furnace_tempr=data(28,b)-0.5;
    end
    if u_decomposing_furnace_tempr>=(data(28,b)+0.5)
        u_decomposing_furnace_tempr=data(28,b)+0.5;
    end
   %% 上下限处理  
   if upid(1)<=10    %%修改：根据现场实际
        upid(1)=10;
    end
    if upid(1)>=40
        upid(1)=40;
    end
    
    if upid(2)<=10    %%修改：根据现场实际
        upid(2)=10;
    end
    if upid(2)>=40
        upid(2)=40;   
    end
    
    if upid(3)<=10    %%修改：根据现场实际
        upid(3)=10;
    end
    if upid(3)>=40
        upid(3)=40;
    end
    
    
    if u_decomposing_furnace_tempr<=decomposing_furnace_coal_floor    %%修改：根据现场实际
        u_decomposing_furnace_tempr=decomposing_furnace_coal_floor;
    end
    if u_decomposing_furnace_tempr>=decomposing_furnace_coal_top
        u_decomposing_furnace_tempr=decomposing_furnace_coal_top;
    end
    %% 清屏
    if mod(b,100)==0                   %每100s清屏
        clc;
    end
    
         %%    写控制量 

    for i=1:loopnum  %修改：loopnum=4
        switch i
            case 1
               
                    if 0==pidloop(10,i)
                          if abs(upid(i)-data(5,b+1))>=0.09                            
%                                 writeasync(itemset(4),upid(i));                
                          end
                         
                    end

                    
                     case 2
               
                    if 1==second_cooler_rev_on
                          if abs(upid(i)-data(13,b+1))>=0.09                            
%                                 writeasync(itemset(12),upid(i));                
                          end
                         
                    end
                    
                     case 3
               
                    if 1==third_cooler_rev_on
                          if abs(upid(i)-data(18,b+1))>=0.09                            
%                                 writeasync(itemset(17),upid(i));                
                          end
                         
                    end
                    
            case 4
             
                    if 1==decomposing_furnace_tempr_on                     
                             if abs(u_decomposing_furnace_tempr-data(28,b+1))>=0.07
 %                             writeasync(itemset(27),u_decomposing_furnace_tempr);
                              test=b;
                            end

                    end
              
        end
    end