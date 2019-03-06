function vid = MakeVid(FileName, FrameRate, Quality)
    % This function is used to initialize a Movie object at a desired
    % FrameRate and Quality.
    %
    % The output is a video object.
    
    vid = VideoWriter(FileName, 'MPEG-4');
    vid.Quality = Quality;
    vid.FrameRate = FrameRate;
    set(gca, 'nextplot', 'replacechildren');
    set(gcf, 'renderer', 'zbuffer');
    open(vid);
end