function a=filter2(nt,plen)
% % % len=length(nt);
% % % plen=30;
% % % for i=plen:len
% % %     nt(i)=sum(nt(i-plen+1:i))/plen;
% % % end
% % % a=nt;
% a=nt(1:len-200);
    
    

len=length(nt);
% plen=10;
for i=plen:len
    if i>plen && nt(i) ==0 %去掉煤气空气时换向时流量变0的影响，其他变量使用 可注释掉
        nt(i) = nt(i-1);
    end
    nt(i)=sum(nt(i-plen+1:i))/plen;
    if i>plen &&abs(nt(i-1)-nt(i)) >= 2000 %%去掉煤气空气时换向时流量变0过程其他数值影响，其他变量使用 可注释掉
        nt(i) = nt(i-1);
    end
%     nt(i)=mean(nt(i-plen+1:i));
end
% dv=10;
% plen=10;
% for i=plen:len
%     nt(i)=sum(nt(i-plen+1:i))/plen;
% end
a=nt;