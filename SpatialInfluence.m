function S = SpatialInfluence(distances, funfunFunction, varargin)
    % Input:
    %       distances:  a list or square matrix of all the pairwise
    %                   distances between points
    %
    %       funfunFunction: a string. something defined in the switch 
    %                       statment of this function. 
    %                       Default: F(d_ij) = 1/d_ij
    %
    % Output:
    %       A transformed version of the input, meant to represent the
    %       influcene of all the phases on each other as a function of 
    %       their host object's 'distance'.
    %
    % TO DO: I'm not sure whether this function should accept things like
    % adjacency matrices, or if things like that should be handled in
    % advance and passed via the [distances] argument.
    %
    % TO DO: The error handling in this function does not exist.
    lower(funfunFunction)
    switch lower(funfunFunction)
        case 'inverse'
            S = (1./distances).^varargin{1};
        case 'sin'
            S = sin(distances/varargin{1});
        case 'sin2'
            S = sin(distances/varargin{1}).^2;
        case 'cos'
            S = cos(distances/varargin{1});
        case 'tan'
            S = tan(distances/varargin{1});
        case 'cam'
            S = (distances-0).*(distances-20).*(distances-60).*exp(-distances*varargin{1});
        otherwise
            S = 1./distances;
    end
    S(~isfinite(S)) = 0;
end