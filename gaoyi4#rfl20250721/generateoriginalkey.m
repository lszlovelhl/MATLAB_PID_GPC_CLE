function main
key=struct;
key.validtime=encodekey(8640);
key.usedtime=encodekey(0);
key.warningtime=encodekey(240);
% key.license=encodekey(20200610);
key.license=encodekey(now);%用当前时间做license，在7天时间内更换license有效
key.licensevalid=encodekey(101110);%101110表示无效，默认无效，通过重新打开软件激活有效；100111表示有效
save('key.mat','key');
bak = key; %%防止授权激活后，拷贝key出去，再次使用
save('bak.mat','bak');
end