clear;
set(groot,'DefaultFigurePosition', [0 0 1600 800])
set(groot,'DefaultAxesFontSize',16);
set(groot,'DefaultTextFontSize',14);
set(groot,'defaultTextInterpreter','latex')
set(groot,'DefaultAxesTickDir', 'out');
set(groot,'DefaultAxesTickDirMode', 'manual');
whitebg([0 0 0]);
close all; clc;
% Consider a plot of phase differences

tau = 2*pi; unitC = exp(2*pi*i*linspace(0,1,1000));

USE_EULER = 1;
ADD_NOISE = 0; % Probably not for this one

if ADD_NOISE > 0
    f = @(x,k,n,w) w+sqrt(ADD_NOISE)*randn(n,1)+(k/n)*sum(sin(x*ones(1,n)-(ones(n,1)*x')))';
else
    f = @(x,k,n,w) w+(k/n)*sum(sin(x*ones(1,n)-(ones(n,1)*x')))';
end

n = 11;
%w = 0.2+abs(randn(n,1)*0.5);
w = linspace(0.1, 0.8, n)' + rand(n,1)*0.1;
%w = 2;
theta(:,1) = tau*rand(n,1);
dt = 0.01; tMax = 300; tDisplay = 60;

for k = linspace(0,1,500)
    % Seems like Euler is more stable... which seems a bit odd...
    if USE_EULER
        y(1,:) = theta(:,1);
        t = 0:dt:tMax;
        for i = 2:length(t)
            y(i,:) = y(i-1,:)+dt*f(y(i-1,:)',k,n,w)';
        end
    else
        tspan = [0 tMax];
        [t,y] = ode45(@(t,u)f(u,k,n,w),tspan,theta(:,1));
    end
    tIdx = t>=(tMax-tDisplay);
    tVals = t(tIdx);
    % Convert to complex
    z = exp(1i*y);
    % Get center of mass
    m = mean(z,2);
    % Phase of center of mass
    phi = angle(m);
    % Coherence
    d = abs(m);
    
    subplot(2,2,1)
    plot(unitC, '.w'); hold on
    plot(m(tIdx),'.y'); hold off
    title(['$k = ' num2str(k, '%.3f') '$'])
    axis([-1 1 -1 1]*1.1); axis square
    
    subplot(2,2,2)
    plot(tVals, d(tIdx), '-r', 'linewidth', 2);
    xlabel('Time')
    ylabel('Coherence')
    axis([min(tVals) tMax 0 1])
    
    subplot(2,2,[3 4])
    plot(tVals, angle(z(tIdx,:)), '.', 'linewidth', 2)
    xlabel('Time')
    ylabel('Phase')
    axis([min(tVals) tMax -pi pi])
    set(gca, 'ytick', [-pi 0 pi], 'yticklabel', {'-\pi', '0', '\pi'})
    
    drawnow
end
