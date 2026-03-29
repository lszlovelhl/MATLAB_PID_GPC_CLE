[~,length]=size(data);
plant=1;
pos=19*(plant-1);
for i=2:length
    if    data(12+pos,i)<1
        data(12+pos,i)=1000;
    end
portial(i-(2-1))=data(13+pos,i)/(data(12+pos,i)+0.0001);
end
figure;
subplot(6,1,1);
plot(data(12+pos,2:length-3));
hold on
plot(data(72+plant-1,2:length-3),'r');
hold on
plot(data(89+plant-1,2:length-3),'g');
subplot(6,1,2);
plot(data(13+pos,2:length-3));
hold on
plot(data(75+plant-1,2:length-3),'r');
hold on
plot(data(92+plant-1,2:length-3),'g');
subplot(6,1,3);
plot(data(1+pos,2:length-3));
hold on
plot(data(3+pos,2:length-3),'r');
subplot(6,1,4);
plot(data(61,2:length-3));
hold on
plot(data(62,2:length-3),'r');
subplot(6,1,5);
plot(portial(2:length-3));
hold on
plot(data(86+plant-1,2:length-3),'r');
subplot(6,1,6);
plot(data(5+pos,2:length-3));
