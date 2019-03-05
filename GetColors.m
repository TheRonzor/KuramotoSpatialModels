function Colors = GetColors(Phases, ColorMode)
    persistent l o nColors cmap;
    if isempty(l)
        l = length(Phases);
        o = zeros(l,1);
        nColors = 1e6;
        cmap = jet(nColors);
    end
    
    switch ColorMode
        case 1
            f = 1-abs(pi-Phases)/pi;
            f = f.^2;
            Colors = [f o o];
        case 2
            f = 1-abs(pi-Phases)/pi;
            f = f.^2;
            Colors = [o f o];
        case 3
            f = 1-abs(pi-Phases)/pi;
            f = f.^2;
            Colors = [o o f];
        case 4
            % Use a full colormap
            % Map phases to (0,1)
            f = Phases/2/pi;
            % Map those values to integers 1 - 10,000
            f = floor(1+(nColors-1)*f);
            Colors = cmap(f,:);
    end
end