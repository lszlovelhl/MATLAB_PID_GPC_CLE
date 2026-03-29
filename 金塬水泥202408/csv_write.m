fid = fopen('0906.csv','w');
datasave = datasave(:,1:18);
[row,col] = size(datasave);
for i = 1 : row
    fprintf(fid,'%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n',datasave(i,:));
end

fclose(fid);