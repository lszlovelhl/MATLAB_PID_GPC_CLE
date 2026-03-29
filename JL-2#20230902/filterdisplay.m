airgaspotial(1) = 0.85;
airgaspotial(2) = 0.85;
airgaspotial(3) = 0.7;
airsv(1,1:12)=[data(2,2:12) data(2,12)];               % 一加空气流量测量值==
airsv(2,1:12)=[data(22,2:12) data(22,12)];              % 二加加空气流量测量值==
airsv(3,1:12)=[data(42,2:12) data(42,12)];              % 均热空气流量测量值==

for bbb=12:3605
airsv(1,1:12)=[airsv(1,2:12) data(2,bbb+1)];               % 一加空气流量测量值==
airsv(2,1:12)=[airsv(2,2:12) data(22,bbb+1)];               % 二加加空气流量测量值==
airsv(3,1:12)=[airsv(3,2:12) data(42,bbb+1)];               % 均热空气流量测量值==

for j=1:3
    switch j
        case 1
            if abs(airsv(j,12) - airsv(j,11)) >= 3000       % 先对airsv进行“粗滤”
                airsv(j,12) = airsv(j,11);
%                 data(2,bbb+1) = airsv(j,11);
            end
        case 2
            if abs(airsv(j,12) - airsv(j,11)) >= 1400
                airsv(j,12) = airsv(j,11);
%                 data(22,bbb+1) = airsv(j,11);
            end
        case 3
            if abs(airsv(j,12) - airsv(j,11)) >= 950
                airsv(j,12) = airsv(j,11);
%                 data(42,bbb+1) = airsv(j,11);
            end
    end  
end

for i=1:3
    switch i
        case 1
            airsp(i)=airsv(i,12).*airgaspotial(i);
            m1(bbb) = airsp(i);
        case 2
            airsp(i)=airsv(i,12).*airgaspotial(i);
            m2(bbb) = airsp(i);
        case 3
            airsp(i)=airsv(i,12).*airgaspotial(i);
            m3(bbb) = airsp(i);
    end
end
end

