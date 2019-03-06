clear; clear PlotOsc2 GetColors; % These are for clearing persistent variables
plotSize = 800; % I don't know if it works right when you change this.
set(groot, 'DefaultFigurePosition', [0 0 plotSize plotSize])
whitebg([0 0 0]); close all; clc;

% Time stamp can be used as a unique identifier for saving things related 
% to the current simulation
tStamp = num2str(now, '%.12f');

%% Set the seed for reproducibility
rng(121)

%% Simulation settings
if 0
    % If you have previously saved your settings, you can import them
    % below. Otherwise, change the above line to if 0... and adjust
    % parameters below.
    s = table2struct(readtable('../Output/TravelingWave1.txt'));
else
    s.N = 40;               % The width of the grid (squared, the number of oscillators).
    s.gridType = 'square';  % The only option is square. I might add hex or circular grids in the future.
    s.metric = 1;           % The parameter for the Minkowski distance
    s.fun = 'inverse';      % The spatial influence function
    s.funParams = 1;        % The parameter for the spatial influence function
    s.dt = 1e-2;            % Time step for Euler's method
    s.k = 0;                % The initial coupling strength (it is divided by Nosc later).
    s.noise = 0;            % The variance of the noise distribution (it will always have mean=0)
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
MOV = 0;
if MOV
    FPS = 60;
    MINS = 2;
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
    PlotOsc2(phases,pos,Nosc,plotSize, s.ColorMode)
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

