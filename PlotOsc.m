function PlotOsc(phases,pos,Nosc,plotSize,ColorMode)
    persistent figHandle s
    if isempty(figHandle)
        figHandle = figure('name', 'Oscillatory Behavior!','NumberTitle','off');
    else
        figure(figHandle)
        delete(s);
    end
    
    % Plot the oscillators in the plane and color by phase
    c = GetColors(phases,ColorMode);
    s = scatter(pos(:,1), pos(:,2),plotSize^2/Nosc,c,'filled','s');
    axis([0 max(pos(:))+1 0 max(pos(:))+1])
    set(gca,'xtick', [], 'ytick', [], 'looseinset', [0 0 0 0]);
    axis square; axis off; drawnow;
end