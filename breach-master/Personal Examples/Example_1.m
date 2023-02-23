clc
clear all
InitBreach

Bdata = BreachTraceSystem({'temperature', 'humidity'});

time = 0:.1:24; % in hours
temperature = 10 + 15*cos(pi*(time-3)/12+pi)+sin(pi/2*time); % in Celsius deg
humidity = 50 + 10*cos(pi*(time+2)/12)+sin(pi/3*time); % in percents

trace = [time' temperature' humidity']; % combine into a trace, column oriented

Bdata.AddTrace(trace);
Bdata.PlotSignals();


phi = STL_Formula('phi', 'alw (temperature[t]<25) and ev_[0, 12] (humidity[t]>50)');
% phi = STL_Formula('phi', 'alw (temperature[t]<30)');

Rphi = BreachRequirement(phi);

Rphi.Eval(Bdata)