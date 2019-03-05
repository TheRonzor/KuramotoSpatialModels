function updateControlDisplay(src,evt)
    persistent annot clr offset
    if isempty(clr)
        clr = 'w';
        offset = [0.0075 0.006];
    end
    
    if nargin < 1; src.String = 'initialize'; end
    src.String
    
    % This is bad practice!
    cWin = evalin('base', 'ctrlWindow');
    c = evalin('base', 'controls');
    Nosc = evalin('base', 'Nosc');
    
    
    %% Update k
    evalin('base',['s.k = ' num2str(c.kSlider.Value/Nosc) ';']);
    try
        delete(annot.k)
    end
    annot.k = annotation(cWin, ...
                'textbox', [c.kSlider.Position([3 2]) + offset 0.1 0.05], ...
                'string', ['$k=' num2str(c.kSlider.Value, '%.3f') '$'], ...
                'edgecolor', 'none', ...
                'color', clr, ...
                'fontsize', 20, ...
                'interpreter', 'latex');
    
    %% Update dt
    evalin('base',['s.dt = ' num2str(c.dtSlider.Value) ';']);
    try
        delete(annot.dt)
    end
    annot.dt = annotation(cWin, ...
                'textbox', [c.dtSlider.Position([3 2]) + offset 0.1 0.05], ...
                'string', ['$dt=' num2str(c.dtSlider.Value, '%.4f') '$'], ...
                'edgecolor', 'none', ...
                'color', clr, ...
                'fontsize', 20, ...
                'interpreter', 'latex');
    
    %% Update noise
    evalin('base',['s.noise = ' num2str(c.noiseSlider.Value) ';']);
    try
        delete(annot.noise)
    end
    annot.noise = annotation(cWin, ...
                'textbox', [c.noiseSlider.Position([3 2]) + offset 0.1 0.05], ...
                'string', ['$|\xi|=' num2str(c.noiseSlider.Value, '%.2f') '$'], ...
                'edgecolor', 'none', ...
                'color', clr, ...
                'fontsize', 20, ...
                'interpreter', 'latex');
            
    %% Update distance function parameter and update fDist
    evalin('base',['s.funParams = ' num2str(c.paramSlider.Value) ';']);
    evalin('base', 'fDist = SpatialInfluence(dist, s.fun, s.funParams);');
    try
        delete(annot.param)
    end
    annot.param = annotation(cWin, ...
                'textbox', [c.paramSlider.Position([3 2]) + offset 0.1 0.05], ...
                'string', ['$\alpha=' num2str(c.paramSlider.Value, '%.2f') '$'], ...
                'edgecolor', 'none', ...
                'color', clr, ...
                'fontsize', 20, ...
                'interpreter', 'latex');
            
    %% Update distance metric
    evalin('base',['s.metric = ''' c.metricSlider.String{c.metricSlider.Value} ''';']);
    evalin('base', 'dist = GetDistances(pos, s.metric);');
    evalin('base', 'fDist = SpatialInfluence(dist, s.fun, s.funParams);');
    try
        delete(annot.metric)
    end
    annot.metric = annotation(cWin, ...
                'textbox', [c.metricSlider.Position([3 2]) + offset 0.1 0.05], ...
                'string', c.metricSlider.String{c.metricSlider.Value}, ...
                'edgecolor', 'none', ...
                'color', clr, ...
                'fontsize', 20, ...
                'interpreter', 'latex');
end