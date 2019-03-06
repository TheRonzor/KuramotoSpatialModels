function n = GetNumberOfColorSchemes
    % Function reads in GetColors.m and returns an integer indicating the
    % number of options.  This is accomplished by counting lines that start
    % with the word 'Case'.
    fid = fopen('GetColors.m', 'r');
    
    n = 1; % The first option isn't in a case statement
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