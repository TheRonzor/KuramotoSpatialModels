function D = GetDistances(Positions, Metric)
    % Inputs:
    %       Positions = Nx2 list of Cartesian coordinates
    % Output:
    %       NxN matrix D such that D(i,j) is what you would expect
    
    D = squareform(pdist(Positions, 'minkowski', Metric));
    
    %switch lower(Metric)
    %    case 'cityblock'
    %        D = squareform(pdist(Positions, 'cityblock'));
    %    otherwise % assume euclidean with no adjustments
    %        D = squareform(pdist(Positions));
    %end
end