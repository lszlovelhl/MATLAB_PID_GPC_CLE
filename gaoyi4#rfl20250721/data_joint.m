clear
clc
date = 20220923;
width=100;
filePath=[pwd,'\','data\'];
% filePath=['F:\data\'];
load([filePath,'data',num2str(date),'00.mat']);
datasave=data(1:width,2:3901)';
[lengthdata,widthdata]=size(datasave);



% for i = 0 : 9
%    fileName=strcat(filePath,'data',num2str(date),num2str(i),'.mat'); 
%    load(fileName); 
%    datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
%    [lengthdata,widthdata]=size(datasave);
%    % 即可将文件读入
% end
% 
% 
 for i = 0 : 9
    fileName=strcat(filePath,'data',num2str(date),'0',num2str(i),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
  [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
 end
 
  for i = 10 : 16
    fileName=strcat(filePath,'data',num2str(date),num2str(i),'.mat'); 
   load(fileName); 
   datasave(lengthdata+1:lengthdata+3600,1:width)=data(1:width,302:3901)';
  [lengthdata,widthdata]=size(datasave);
   % 即可将文件读入
 end




data=datasave';