[~,length]=size(data);
plant=3;
pos=19*(plant-1);

for i=2:length
    if    data(12+pos,i)<1
        data(12+pos,i)=1000;
    end
portial(i-(2-1))=data(13+pos,i)/(data(12+pos,i)+0.0001);
end

figure;
subplot(3,1,1);
plot(portial(2:length-3));
hold on
plot(data(86+plant-1,2:length-3),'r');
subplot(3,1,2);
plot(data(5+pos,2:length-3));
subplot(3,1,3);
plot(data(61,2:length-3));



figure;
plot(data(12+pos,2:length-3));
hold on
plot(data(71+plant,2:length-3),'r');


for i=2:3900
    if data(31,i)>100
   p(i-1)=data(32,i)/data(31,i);
    else
         p(i-1)=0;
    end
end

figure;
plot(p);

figure;
plot(data(32,2:3901));
hold on
plot(data(76,2:3901),'r');

figure;
plot(data(22,2:3901));
hold on
plot(data(23,2:3901),'r');