fid = fopen('data.csv','w');
datasave = datasave(:,1:36);
[row,col] = size(datasave);
for i = 1 : row
    fprintf(fid,'%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n',datasave(i,:));
end

        