function D = GetDistances(Positions, Metric)
    % Inputs:
    %       Positions = Nx2 list of Cartesian coordinates
    % Output:
    %       NxN matrix D such that D(i,j) is what you would expect
    
    D = squareform(pdist(Positions, 'minkowski', Metric));
end