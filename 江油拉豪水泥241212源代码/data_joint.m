clear
clc
date = 804;
width=50;
filePath=[pwd,'\','data\'];
load([filePath,'data20200',num2str(date),'19.mat']);
datasave=data(1:width,2:3901)';
[lengthdata,widthdata]=size(datasave);

for i = 18:23
   fileName=strcat(filePath,'data20200',num2str(date),num2str(i),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
   [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
end


for i = 1:10
   fileName=strcat(filePath,'data20200',num2str(date+1),'0',num2str(i-1),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
   [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
end

fileName=strcat(filePath,'data20200',num2str(805),num2str(11),'.mat'); 
load(fileName); 
datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
[lengthdata,widthdata]=size(datasave);
% for i = 10:14
%    fileName=strcat(filePath,'data20200',num2str(date+1),num2str(i),'.mat'); 
%    load(fileName); 
%    datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
% [lengthdata,widthdata]=size(datasave);
%    % 即可将文件读入
% end