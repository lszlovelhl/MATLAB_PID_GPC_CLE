fid = fopen('1013.csv','w');
[row,col] = size(datasave);
for i = 1 : row
    fprintf(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',datasave(i,:));
end

fclose(fid);