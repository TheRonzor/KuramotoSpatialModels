function vid = MakeVid(FileName, FrameRate, Quality)
    vid = VideoWriter(FileName, 'MPEG-4');
    vid.Quality = Quality;
    vid.FrameRate = FrameRate;
    set(gca, 'nextplot', 'replacechildren');
    set(gcf, 'renderer', 'zbuffer');
    open(vid);
end