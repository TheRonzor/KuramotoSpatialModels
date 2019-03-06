function n = GetNumberOfColorSchemes
    fid = fopen('GetColors.m', 'r');
    n = 1; % The first one isn't in a case statement
    while ~feof(fid)
        line = fgetl(fid);
        line = fliplr(deblank(fliplr(line)));
        line = split(line,{' ', ''''});
        if strcmp(line{1}, 'case')
            n=n+1;
        end
    end
    fclose(fid);
end