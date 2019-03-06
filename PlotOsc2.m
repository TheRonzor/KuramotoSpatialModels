function PlotOsc2(phases,pos,Nosc,plotSize,ColorMode)
    persistent figHandle s
    c = GetColors(phases,ColorMode);
    if isempty(figHandle)
        figHandle = figure('name', 'The KuramotRon','NumberTitle','off');
        s = scatter(pos(:,1), pos(:,2),plotSize^2/Nosc,c,'filled','s');
        axis([0 max(pos(:))+1 0 max(pos(:))+1])
        set(gca,'xtick', [], 'ytick', [], 'looseinset', [0 0 0 0]);
        axis square; axis off; drawnow;
    else
        s.XData = pos(:,1);
        s.YData = pos(:,2);
        s.CData = c;
        drawnow;
    end
end