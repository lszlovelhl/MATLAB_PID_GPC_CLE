function key = encodekey( originalnum )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
originalstring=num2str(originalnum);
chinsesstring=chineseencode(originalstring);
urlstring=urlencode(chinsesstring);
urlstringmirror=fliplr(urlstring);
key=urlstringmirror;

end


function chinesecharactor=chineseencode(stringin)
l=length(stringin);
chinesecharactor='';
for i=1:l
    switch stringin(i)
        case '1'
            chinesecharactor=[chinesecharactor '一'];
        case '2'
            chinesecharactor=[chinesecharactor '二'];
        case '3'
            chinesecharactor=[chinesecharactor '三'];
        case '4'
            chinesecharactor=[chinesecharactor '四'];
        case '5'
            chinesecharactor=[chinesecharactor '五'];
        case '6'
            chinesecharactor=[chinesecharactor '六'];
        case '7'
            chinesecharactor=[chinesecharactor '七'];
        case '8'
            chinesecharactor=[chinesecharactor '八'];
        case '9'
            chinesecharactor=[chinesecharactor '九'];
        case '0'
            chinesecharactor=[chinesecharactor '零'];
        otherwise
            chinesecharactor=[chinesecharactor stringin(i)];
    end
end
end