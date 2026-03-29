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
    nt(i)=sum(nt(i-plen+1:i))/plen;
end
% dv=5;
% for i=plen:len
%     if abs(nt(i)-nt(i-1))>=dv
%         nt(i)=nt(i-1);
%     end
% end
% plen=20;
% for i=plen:len
%     nt(i)=sum(nt(i-plen+1:i))/plen;
% end
a=nt;