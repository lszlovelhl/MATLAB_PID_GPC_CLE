[cc,c]=size(temp);
%  h = fspecial('gaussian', 50, 50);%创建一个滤波器
 h = fspecial('average',100);%创建一个滤波器
filteredRGB = imfilter(temp(:,1), h);

t=1:cc;
p2 = plotyy(t,filteredRGB(1:cc,1),t,temp(1:cc,1));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);