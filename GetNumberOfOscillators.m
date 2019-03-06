function NumOsc = GetNumberOfOscillators(configurationType,varargin)
    % Inputs:
    %       configurationType: square, hexagonal, circular, etc.
    %
    %       varargin: a list of parameters specifying things about the
    %       configuration. Right now, it's just the width of a square
    %       grid.
    %
    % NOTE: I'm only supporting square grids right now, but have written
    % the code so it can be easily extended later.
    switch lower(configurationType)
        case 'square'
            NumOsc = varargin{1}^2;
        otherwise
            NumOsc = varargin{1}^2;
    end
end