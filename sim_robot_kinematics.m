%% EXAMPLE: Differential Drive discrete simulation
% Copyright 2018 The MathWorks, Inc.
clear
%% Define Robot
R = 0.067/2;                % Wheel radius [m]
L = R;                % Wheelbase [m]
dd = DifferentialDrive(R,L);

%% Simulation parameters
sampleTime = 0.5;              % Sample time [s]

initPose = [0;0;0];          % Initial pose (x y theta)
load ('verification_data.mat')
% v = sqrt(xvals(3,:)^2 + xvals(4,:)^2);

% Initialize time, input, and pose arrays
tVec = 0:sampleTime:length(uvals)/2;         % Time array
vRef = 0;    % Reference linear speed
uvals = uvals*60;
for i = 2:length(orientation)
    r(:,:,i) = [cos(orientation(i)) sin(orientation(i)); -sin(orientation(i)) cos(orientation(i))];
    z(:,i) = r(:,:,i)*uvals(:,i);       % Reference angular speed
    vRef(i) = z(1,i)*sampleTime + vRef(i-1);
    wRef(i) = z(2,i)/vRef(i);
end
lin_vel = sqrt(xvals(3,:).^2+xvals(4,:).^2);
pose = zeros(3,numel(tVec));    % Pose matrix
pose(:,1) = initPose;

%% Simulation loop
for idx = 2:numel(tVec)
    pose_d1=vRef(idx-1)*cos(orientation(idx-1));
    pose_d2=vRef(idx-1)*sin(orientation(idx-1));
    pose_d3 = wRef(idx-1); 
    pose(:,idx) = pose(:,idx-1) + [pose_d1;pose_d2;pose_d3];
%     % Solve inverse kinematics to find wheel speeds
%     [wL,wR] = inverseKinematics(dd,vRef(idx-1),wRef(idx-1));
%     
%     % Compute the velocities
%     [v,w] = forwardKinematics(dd,wL,wR);
%     velB = [v;0;w]; % Body velocities [vx;vy;w]
%     vel = bodyToWorld(velB,pose(:,idx-1));  % Convert from body to world
%     
%     % Perform forward discrete integration step
%     pose(:,idx) = pose(:,idx-1) + vel*sampleTime;         
end

%% Display results
% close all
figure(2)
hold on
plot(pose(1,:),pose(2,:),'b-');
% figure(3)
plot(xvals(1,:),xvals(2,:),'r-');
axis equal
title('Vehicle Trajectory');
xlabel('X [m]')
ylabel('Y [m]')
% xlim([0,40])
% ylim([0,40])
legend('Start','End','Trajectory')