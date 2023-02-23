clc
clear all
close all

%% Initialize model with input range
BrDemo.InitAFC; %  Initialize the AFC model with a pulse generator for Pedal_Angle
var = {'Pedal_Angle_pulse_amp', 'Pedal_Angle_pulse_period'}; 
ranges = [ 10 60 ; 10 15]; % ranges for pulse amplitude and pulse period
BrAFC.SetParamRanges(var, ranges); % declare ranges 

%% Generate simulations for 10 samples
Bgrid = BrAFC.copy(); 
Bgrid.GridSample(5);  % creates a grid of 5x5=25 samples

Brand = BrAFC.copy();
Brand.QuasiRandomSample(10);  % Creates 10 samples quasi-randomly in the specified range. 

%% Simulate the 10 random samples for the model
Brand.Sim(40); % simulate AFC model until time 40
Brand.PlotSignals({'Pedal_Angle', 'AF'}); 

%% Read STL specifications from file
STL_ReadFile('AFC_simple_spec.stl');
R = BreachRequirement(AF_alw_ok);
R.Eval(Brand)

%% Plot results approprately
BreachSamplesPlot(R)