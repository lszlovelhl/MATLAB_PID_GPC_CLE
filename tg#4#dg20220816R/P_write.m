function  P_write( A,u_GPC,max,min )
global itemset 
if u_GPC>max
    u_GPC=max;
end
if u_GPC<min
    u_GPC=min;
end

write(itemset(A),u_GPC)      

   