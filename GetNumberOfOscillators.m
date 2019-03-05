function NumOsc = GetNumberOfOscillators(configurationType,varargin)
    % Inputs:
    %       configurationType: square, hexagonal, circular, etc.
    %
    % NOTE: I'm only supporting square grids right now.
    switch lower(configurationType)
        case 'square'
            NumOsc = varargin{1}^2;
        otherwise
            NumOsc = varargin{1}^2;
    end
end