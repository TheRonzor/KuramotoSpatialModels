function funArray = GetSpatialFunctions
% Generate a list of options defined in the SpatialInfluence function
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