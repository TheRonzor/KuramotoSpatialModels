function Colors = GetColors(phases)
    persistent l o nColors cmap MODE;
    if isempty(l)
        l = length(phases);
        o = zeros(l,1);
        nColors = 1e6;
        cmap = jet(nColors);
        MODE = 1;
    end
    
    switch MODE
        % If phase is near pi , then color red, otherwise black
        case 1
            f = 1-abs(pi-phases)/pi;
            f = f.^2;
            Colors = [o f o];
        case 2
            % Use a full colormap
            % Map phases to (0,1)
            f = phases/2/pi;
            % Map those values to integers 1 - 10,000
            f = floor(1+(nColors-1)*f);
            Colors = cmap(f,:);
    end
end