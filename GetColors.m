function Colors = GetColors(Phases,ColorMode)
    % Input is an Nx1 list of phases, and an integer indicating the color mode
    % to use.
    
    % Output is an Nx3 list of RGB values.
    persistent l o nColors cmap pow;
    if isempty(l)
        l = length(Phases);
        o = zeros(l,1);
        nColors = 1e6;
        cmap = hsv(nColors);
        pow = 4;
    end
    
    if ColorMode == 1
        f = Phases/2/pi;
        f = floor(1+(nColors-1)*f);
        Colors = cmap(f,:);
        return;
    else
        f = (1-abs(pi-Phases)/pi).^pow;
    end
    
    switch ColorMode
        case 2
            Colors = [f o o];
        case 3
            Colors = [o f o];
        case 4
            Colors = [o o f];
        case 5
            Colors = brighten([f 1-f o+1],-0.5);
        case 6
            Colors = brighten([(1-f)/3 f (1-f)/2], 0.2);
    end
end