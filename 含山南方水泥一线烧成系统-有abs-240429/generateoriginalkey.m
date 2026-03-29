function main
key=struct;
key.validtime=encodekey(2160);%87600小时表示10年，长期有效
key.usedtime=encodekey(0);
key.warningtime=encodekey(240);
% key.license=encodekey(20200610);
%用当前时间做license，在7天时间内更换license有效
key.license=encodekey(now);
%110110110110 表示无效，默认无效，通过重新打开软件激活有效；
key.licensevalid=encodekey(110110110110);%110110110110该值12位
save('key.mat','key');
bak = key;
save('bak.mat','bak');
end