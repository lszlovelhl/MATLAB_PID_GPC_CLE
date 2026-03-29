function ynum = decodekey( key )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
urlstring=fliplr(key);
chinsesstring=urldecode(urlstring);
originalstring=chinesedecode(chinsesstring);
originalnum=str2num(originalstring);
ynum=originalnum;

end


function stringout=chinesedecode(stringin)
l=length(stringin);
stringout='';
for i=1:l
    switch stringin(i)
        case '一'
            stringout=[stringout '1'];
        case '二'
            stringout=[stringout '2'];
        case '三'
            stringout=[stringout '3'];
        case '四'
            stringout=[stringout '4'];
        case '五'
            stringout=[stringout '5'];
        case '六'
            stringout=[stringout '6'];
        case '七'
            stringout=[stringout '7'];
        case '八'
            stringout=[stringout '8'];
        case '九'
            stringout=[stringout '9'];
        case '零'
            stringout=[stringout '0'];
        otherwise
            stringout=[stringout stringin(i)];
    end
end
end