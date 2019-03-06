function PlotOsc(phases,pos,Nosc,plotSize,ColorMode)
    persistent figHandle s
    if isempty(figHandle)
        figHandle = figure('name', 'Oscillatory Behavior!','NumberTitle','off');
    else
        figure(figHandle)
        delete(s);
    end
    
    % TODO[_]: Just update the s.XData, etc. properties. Main problem, this
    % keeps stealing focus to the main figure (making things 
    % like popupmenus problematic), and 2) I think it's slower
    % than it needs to be, since we're deleting and recreating the entire
    % figure every time, vs. just updating a handful of values that define
    % it. (Recall that your first attempt ended in nothing being updated).
    
    % TODO[_]: Figure out the units for plot size vs marker size already!
    
    % Plot the oscillators in the plane and color by phase
    c = GetColors(phases,ColorMode);
    s = scatter(pos(:,1), pos(:,2),plotSize^2/Nosc,c,'filled','s');
    axis([0 max(pos(:))+1 0 max(pos(:))+1])
    set(gca,'xtick', [], 'ytick', [], 'looseinset', [0 0 0 0]);
    axis square; axis off; drawnow;
end