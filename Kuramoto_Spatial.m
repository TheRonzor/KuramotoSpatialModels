%% The KuramotRon
%   This script runs the simulation!  See the ReadMe for more information
%
%   Ronald D. Smith
%   College of William & Mary
%   2019 March
%--------------------------------------------------------------------------

clear; clear PlotOsc2 GetColors; % These are for clearing persistent variables

% I don't know if it works right when you change this, but the idea is that
% if you change the size of the plot, the MarkerSize of the plots will
% scale with it.  I had some trouble figuring out how to go from the
% plotSize to the MarkerSize.  I know it works for plotSize=800 though!
plotSize = 800; 

% Set the default plot size, and make the background dark.
set(groot, 'DefaultFigurePosition', [0 0 plotSize plotSize])
whitebg([0 0 0]); close all; clc;

% tStamp can be used as a unique identifier for saving things related 
% to the current simulation
tStamp = num2str(now, '%.12f');

%% Set the random seed for reproducibility
rng(121)

%% Simulation settings
if 1
    % If you have previously saved your settings, you can import them
    % below and change the above line to 'if 1'.  Otherwise, you can set
    % the initial parameters in the 'else' block below.
    s = table2struct(readtable('../Output/WaveWheels.txt'));
else
    s.N = 40;               % The width of the grid (squared, the number of oscillators).
    s.gridType = 'square';  % The only option is square. I might add hex or circular grids in the future.
    s.metric = 2;           % The parameter for the Minkowski distance
    s.fun = 'sinexp';       % The spatial influence function
    s.funParams = 3;        % The parameter for the spatial influence function
    s.dt = 0.05;            % Time step for Euler's method
    s.k = 25;               % The initial coupling strength (it is divided by Nosc later).
    s.noise = 0.3;          % The variance of the noise distribution (it will always have mean=0)
    s.ColorMode = 1;        % The initial color mode, for showing phases.
end

%% Compute distances, etc.
Nosc = GetNumberOfOscillators(s.gridType,s.N);
pos = GetOscillatorPositions(s.gridType,s.N);
dist = GetDistances(pos, s.metric);
fDist = SpatialInfluence(dist, s.fun, s.funParams);

%% Oscillator properties and initial conditions
% Intrinsic frequencies are drawn from a folded normal distribution (they
% are all positive).
freqs = abs((randn(Nosc,1)*0.5 + 1));
% The initial phases are uniformly selected from (0, 2pi).
phases = rand(Nosc,1)*2*pi;

%% Movies
% Do not attempt to make movies unless you have read and understand all of
% the code. It is very easy to generate enormous movie files if you are not
% paying attention.
MOV = 1;
if MOV
    FPS = 30;
    MINS = 1;
    FRAMES = 60*MINS*FPS;
    QUAL = 50;    
    vid = MakeVid(['../Output/Kuramoto_' tStamp '_.mp4'], FPS, QUAL);
    framesSoFar=0;
end

%% Initialize control window
[ctrlWindow, controls] = MakeControlWindow(s); updateControlDisplay;

%% Run numerical simulation
while 1    
    phases = GetNextState(phases,freqs,s.k/Nosc,fDist,s.dt,s.noise);
    if PlotOsc2(phases,pos,Nosc,plotSize, s.ColorMode) == 0
        break;
    end
    if MOV
        writeVideo(vid,getframe(gcf));
        framesSoFar = framesSoFar+1;
        if framesSoFar>=FRAMES
            break;
        end
    end
end
if MOV; close(vid); end

function newPhases = GetNextState(phases, naturalFreqs, coupling, spatialCoupling, dt, noise)
    persistent tau
    if isempty(tau)
        tau = 2*pi;
    end
    
    diffs = repmat(phases',length(phases),1) - phases;
    sins = sin(diffs).*spatialCoupling;
    sums = sum(sins,2);
    
    % Euler's method (upgrade to Heun's if it's not too slow).
    if noise
        % With noise
        newPhases = mod(phases + (naturalFreqs+noise*randn(size(naturalFreqs)) + coupling.*sums)*dt,tau);
    else
        % Without noise
        newPhases = mod(phases + (naturalFreqs + coupling.*sums)*dt,tau);
    end
        
end

