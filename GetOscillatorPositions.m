function OscPositions = GetOscillatorPositions(configurationType, varargin)
    % Inputs:
    %       configurationType: square, hexagonal, circular, etc.
    %       
    %       varargin: Right now, just a number that 'characterizes' the
    %       grid.  If nothing is passed, defaults to 10.
    %
    % Output: 
    %       A list of Cartesian coordinates representing the center of
    %       each oscillator.
    %
    % NOTE: I'm only supporting square grids right now.
    
    switch lower(configurationType)
        case 'square'
            if nargin > 1
                nWide = varargin{1};
            else
                nWide = 10;
            end
            [x,y] = meshgrid(1:nWide);
            OscPositions = [x(:) y(:)];
        otherwise
            disp('You didn''t say square. I quit!');
    end

end