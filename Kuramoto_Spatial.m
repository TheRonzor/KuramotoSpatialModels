clear; clear PlotOsc GetColors;
plotSize = 800;
set(groot, 'DefaultFigurePosition', [0 0 plotSize plotSize])
whitebg([0 0 0]); close all; clc;
tStamp = num2str(now, '%.12f');

MOV = 0;
if MOV
    FPS = 60;
    MINS = 2;
    FRAMES = 60*MINS*FPS;
    QUAL = 50;    
    vid = MakeVid(['../Output/Kuramoto_' tStamp '_.mp4'], FPS, QUAL);
    framesSoFar=0;
end

%% Set the seed for reproducibility
rng(121)

%% Simulation settings
if 1
    s = table2struct(readtable('../Output/Settings_737489.805264826049.txt'));
else
    s.N = 40;
    s.gridType = 'square'; 
    s.metric = 1;
    s.fun = 'inverse';
    s.funParams = 1;
    s.dt = 1e-2;
    s.k = 0;
    s.noise = 0;
    s.ColorMode = 1;
end

%% Compute distances, etc.
Nosc = GetNumberOfOscillators(s.gridType,s.N);
pos = GetOscillatorPositions(s.gridType,s.N);
dist = GetDistances(pos, s.metric);
fDist = SpatialInfluence(dist, s.fun, s.funParams);

%% Oscillator properties and initial conditions
freqs = -(randn(Nosc,1)*0.5 + 1);
phases = rand(Nosc,1)*2*pi;

%% Run numerical simulation
[ctrlWindow, controls] = MakeControlWindow(s); updateControlDisplay;
while 1    
    phases = GetNextState(phases,freqs,s.k/Nosc,fDist,s.dt,s.noise);
    PlotOsc(phases,pos,Nosc,plotSize, s.ColorMode)
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
    
    % Euler's method
    if noise
        % With noise
        newPhases = mod(phases + (naturalFreqs+noise*randn(size(naturalFreqs)) + coupling.*sums)*dt,tau);
    else
        % Without noise
        newPhases = mod(phases + (naturalFreqs + coupling.*sums)*dt,tau);
    end
        
end

