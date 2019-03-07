function status = PlotOscOnCircle(phases, cWin, colors)
    % Plots the oscillators on a circle in the control window
    % Return 1 if succesful, 0 if any error occurs
    persistent s dPlot
    status = 1;
    if isempty(dPlot)
        dPlot = subplot(2,2,2,'parent',cWin);
        plot(exp(1i*linspace(0,2*pi,1000)),'-w'); hold on;
        z = exp(1i*phases);
        s = scatter(real(z), imag(z), 50, colors, 'o', 'filled', 'markeredgecolor', 'k', 'parent', dPlot);
        axis([-1.1 1.1 -1.1 1.1])
        set(gca,'xtick', [], 'ytick', [], 'looseinset', [0 0 0 0]);
        axis square; axis off; drawnow;
    else
        z = exp(1i*phases);
        try
            s.XData = real(z);
            s.YData = imag(z);
            s.CData = colors;
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
        end
    end
end