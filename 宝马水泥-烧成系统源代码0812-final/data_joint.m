clear
clc
date = 1103;
width=40;
filePath=[pwd,'\','data\'];
load([filePath,'data2020',num2str(date),'00.mat']);
datasave=data(1:width,2:3901)';
[lengthdata,widthdata]=size(datasave);


for i = 1:9
   fileName=strcat(filePath,'data2020',num2str(date),'0',num2str(i),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
   [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
end

for i = 10:19
   fileName=strcat(filePath,'data2020',num2str(date),num2str(i),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
   [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
end


for i = 20:23
   fileName=strcat(filePath,'data2020',num2str(date),num2str(i),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
   [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
end



data=datasave';