function funArray = GetSpatialFunctions
    % Function returns a cell array containing all of the spatial influence
    % functions defined in SpatialInfluence.m.
    %
    % The code looks for lines with the word 'case' and returns the rest of
    % the text on those lines.
    
    fid = fopen('SpatialInfluence.m');
    i = 1;
    while ~feof(fid)
        line = fgetl(fid);
        line = fliplr(deblank(fliplr(line)));
        line = split(line,{' ', ''''});
        if strcmp(line{1}, 'case')
            funArray(i) = line(3);
            i=i+1;
        end
    end
    fclose(fid);
end