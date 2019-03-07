function [status, figHand] = PlotOsc2(pos,Nosc,plotSize,Colors)
    % This function creates the simulation window if it does not exist.  If
    % it does exist, then it updates it with the provided input values.
    %
    % Function should return 0 if any error occurs, and return 1 otherwise.
    %
    % Function also returns the figureHandle to facilitate getFrame for
    % movies.
    
    persistent figHandle s
    status = 1;
    if isempty(figHandle)
        figHandle = figure('name', 'The KuramotRon','NumberTitle','off', ...
                           'position', [plotSize+10 0 plotSize plotSize]);
        s = scatter(pos(:,1), pos(:,2),plotSize^2/Nosc,Colors,'filled','s');
        axis([0 max(pos(:))+1 0 max(pos(:))+1])
        set(gca,'xtick', [], 'ytick', [], 'looseinset', [0 0 0 0]);
        axis square; axis off; drawnow;
    else
        try
            s.XData = pos(:,1);
            s.YData = pos(:,2);
            s.CData = Colors;
            drawnow;
        catch ex
            % If the window was closed, then end the simulation.
            close all;
            if strcmp(ex.message, 'Invalid or deleted object.')
                disp('The KuramotRon hopes you have enjoyed it! Run me again sometime!')
            else
                % Otherwise, let the user know something unexpected
                % happened.
                disp('There may have been an unexpected error.  See below:')
                disp(ex.message)
                disp(ex.getReport)
            end
            % Return a flag telling the script to terminate.
            status = 0;
            return;
        end
    end
    figHand = figHandle;
end