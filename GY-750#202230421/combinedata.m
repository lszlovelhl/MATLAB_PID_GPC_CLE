clc
clear all
close all
%%
data_all=[];
List =dir('data20230410*.mat');
k =length(List);
for i=1:k
    file_name{i}=List(i).name;
    temp=importdata(file_name{i});
    %temp=temp';
    data_all=[data_all,temp(:,1:length(temp)-300)];
end
data=data_all;
% path_pri = ['data_all.mat'];
% save(path_pri,'data_all','-v7.3')
% figure;
% plot(a);
