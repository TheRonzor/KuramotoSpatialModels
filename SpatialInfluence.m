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
    %       their distance.
    %
    % TO DO: I'm not sure whether this function should accept things like
    % adjacency matrices, or if things like that should be handled in
    % advance and passed via the [distances] argument.
    %
    % TO DO: The error handling in this function does not exist.
    
    % To ensure that the code runs properly, DO NOT add any comments on the 
    % same line as the case statements. This file is read by another function
    % to generate a list of available options.  If you add comments, do it
    % either above or below the 'case' statements.
    
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
        case 'tannorm'
            S = tan(distances/varargin{1});
            S = S/max(abs(S(:)));
        case 'cam'
            S = (distances-0).*(distances-20).*(distances-60).*exp(-distances*varargin{1});
        case 'sigmoid'
            S = 2./(1+exp(distances-10)/varargin{1})-1;
        case 'sinexp'
            S = sin(distances/varargin{1}).*exp(-sqrt(distances));
            S = S/max(abs(S(:)));
        case 'cosexp'
            S = cos(distances/varargin{1}).*exp(-sqrt(distances));
            S = S/max(abs(S(:)));
        case 'mlj'
            S=-0.1*distances.^(-8)-varargin{1}*distances.^(-4)+1*distances.^(-1);
            S = S/max(abs(S(:)));
        otherwise
            S = 1./distances;
    end
    % Any infinities or otherwise are set to 0.
    S(~isfinite(S)) = 0;
end