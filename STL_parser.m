% pseudo code %%

%% STL specifications to Toolbox inputs %%

% 
%
STL_1 = "alw ((ev_[00,10] (X(1:2,t) > [0.4;0.4] and X(1:2,t) < [0.5;0.5]))" + ...
    "and (ev_[10,20] (X(1:2,t) > [0.8;0.6] and X(1:2,t) < [0.9;0.7]))";

STL_2 = "alw ((ev_[00,09] (X(1:2,t) > [0.4;0.4] and X(1:2,t) < [0.5;0.6]))" + ...
    "and (ev_[15,25] (X(1:2,t) > [0.8;0.6] and X(1:2,t) < [0.9;0.8]))";


[waypoints,time_stamp] = waypoint_locations(STL_2);


% [success,st1,st2,int] = parenthesis_split_balance(STL1,)

%% Parse %%

function [waypoints,time_stamps] = waypoint_locations(st)

% split st into st1 op st2 where st1 and st2 are parenthesisly balanced
char = st.char();

time_stamps = [];
start_idx_g = [];
start_idx_l = [];
waypoints_lower= [];
waypoints_upper= [];
start_idx_g = strfind(st,'>');
start_idx_l = strfind(st,'<');
time_start = strfind(st,'ev');


waypoints = cell(numel(start_idx_g),1);


for i = 1:numel(start_idx_g)
    stlx = char(start_idx_g(i)+3:start_idx_g(i)+5);
    stly = char(start_idx_g(i)+7:start_idx_g(i)+9);
    waypt_xl = str2double(stlx);
    waypt_yl = str2double(stly);
    waypoints_lower = [waypoints_lower; waypt_xl waypt_yl];

end
for i = 1:numel(start_idx_l)
    stlx = char(start_idx_l(i)+3:start_idx_l(i)+5);
    stly = char(start_idx_l(i)+7:start_idx_l(i)+9);
    waypt_xu = str2double(stlx);
    waypt_yu = str2double(stly);
    waypoints_upper = [waypoints_upper;waypt_xu waypt_yu];
    
end

for i = 1:numel(time_start)
    time_stamp = char(time_start(i)+4:time_start(i)+8);
    time_stamps = [time_stamps; time_stamp];

end

for i = 1:numel(start_idx_g)
    waypoints{i} = [waypoints_lower(i,:); waypoints_lower(i,1) waypoints_upper(i,2); waypoints_upper(i,:);waypoints_upper(i,1) waypoints_lower(i,2)];

end

end