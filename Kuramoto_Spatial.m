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
rng(111)

%% Simulation settings
s.N = 50;
s.gridType = 'square'; 
Nosc = GetNumberOfOscillators(s.gridType,s.N);
pos = GetOscillatorPositions(s.gridType,s.N);

s.metric = 'cityblock';
dist = GetDistances(pos, s.metric);

s.fun = 'cam';
s.funParams = 1;
fDist = SpatialInfluence(dist, s.fun, s.funParams);

s.dt = 1e-2;
s.k = 0;
s.noise = 0;

%% Oscillator properties and initial conditions
freqs = (rand(Nosc,1)*3 - 1);
phases = rand(Nosc,1)*2*pi;

%% Run numerical simulation
[ctrlWindow, controls] = MakeControlWindow; updateControlDisplay;
while 1    
    phases = GetNextState(phases,freqs,s.k,fDist,s.dt,s.noise);
    PlotOsc(phases,pos,Nosc,plotSize)
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

