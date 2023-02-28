%<<<<<<< HEAD
% Initialization script for Soccer Simulation example
% Copyright 2019 The MathWorks, Inc.

%% Load bus data types
clear
%load soccerBusTypes;
%=======
%>>>>>>> 01bda8825cae68d27f2e28787c6851ea16cbc722

%% Soccer field parameters
% X and Y limits for the field
fieldLimitsX = [0 9];
fieldLimitsY = [0 6];

% Define the field as an Occupancy Map
%map = robotics.OccupancyGrid(zeros(fieldLimitsY(2),fieldLimitsX(2)));

% Goal Post Parameters (X, Y, Object Index)
goalPosts = [ 0 4.3 2; 
              0 1.7 2; 
             9 4.3 3; 
             9 1.7 3];
fieldCenter = [mean(fieldLimitsX) mean(fieldLimitsY)];
homeGoalPosition = [fieldLimitsX(1) mean(fieldLimitsY)];
awayGoalPosition = [fieldLimitsX(2) mean(fieldLimitsY)];

%% Simulation Parameters
sampleTime = 0.1;

% Robot definitions and dimensions
numRobots = 8;
robotRadius = 0.3;
wheelRadius = 0.2;
robotColors = [1 0 0;0 0 1;1 0 0;0 0 1;1 0 0;0 0 1;1 0 0;0 0 1];

% Initial Robot poses (X, Y, Theta)
initialPoses = [2.0 2.0 0.0;
                8.0 3.0 pi;
                3.2 2.9 0.0;
                6.2 1.3 pi; 
                3.2 1.8 0.0;
                6.2 2.6 pi];

% Initial Ball Position
initBallPos = fieldCenter;

% Initial Game State
%<<<<<<< HEAD
%initGameState = struct('possession',0, ...
%                       'state',GameState.InPlay, ...
%                       'score',[0;0]);
%=======
%initGameState = struct('possession',0, ...                       'state',GameState.InPlay, ...                       'score',[0;0]);
%>>>>>>> 01bda8825cae68d27f2e28787c6851ea16cbc722
                   
% Ball kicking noise (multiplying factor for 'randn' function)
ballVelNoise = 0.5;
ballAngleNoise = pi/24;

ballThresh = robotRadius + 0.3; % Distance to grab the ball
ballCarryFactor = 0.94;          % Speed penalty when carrying the ball
outOfBoundsDist = 3;            % Distance to place ball back in bounds

% Randomize initial conditions
%randomizeStartingPositions;

%% Object Detector and Robot Detector sensor parameters
objDetectorOffset = [0 0];
objDetectorAngle = 0;
objDetectorFOV = pi/3;
objDetectorRange = 10.0;
objColors = [0 0.75 0; 1 0 0; 0 0 1];
objMarkers = 'o^^';
objDetectorMaxHits = 5;

robotDetectorOffset = [0 0];
robotDetectorAngle = 0;
robotDetectorFOV = pi;
robotDetectorRange = 2.0;
robotDetectorMaxHits = 5;

%% Behavior Logic Parameters
% General parameters
distThresh = 0.1;         % Threshold distance to track points [m]
angThresh = pi/16;      % Threshold angle to track rotation [rad]
goalThresh = 2.0;        % Threshold distance from the goal to kick ball [m]

% Attacker parameters
attackerKickSpeed = 3;              % Kick speed for attacking
attackerMinGoalDist = 0.5;            % Distance before taking the ball away from goal and try kick again
attackerMaxGoalDist = 1.0;           % Distance away from goal to travel before kicking again
dribbleTime = 25;                   % Max time before kicking the ball while dribbling
dribbleKickSpeed = 2;               % Kick speed for dribbling

% Defender parameters
defenderHomePoses = [2.0 2.85 0;
                     2.0 1.85 0]';   % Defender poses for home team
defenderAwayPoses = [7.2 2.85 pi;
                     7.2 1.85 pi]';  % Defender poses for away team
defenderKickSpeed = 5;              % Kick speed for defending

% Goalkeeper parameters
goalkeeperPoses = [ 0.0 3.0 0;
                   9.0 3.0 pi]';    % Goalkeeper poses for home and away teams
goalkeeperKickSpeed = 10;           % Kick speed for goalkeeping


%Rajit Added
extra_half_time = 100;
half_time = 300;
illegal_defense_duration = 20;
illegal_defense_number = 0;
nr_extra_halfs = 2;
nr_normal_halfs = 2;
pen_before_setup_wait = 10;
pen_max_extra_kicks = 5;
pen_nr_kicks = 5;
start_goal_l = 0;
start_goal_r = 0;
ball_accel_max = 2.7;
ball_size = 0.085;
ball_speed_max = 3;
ball_weight = 0.2;
inertia_moment = 5;
kick_power_rate = 0.027;
kick_rand = 0.1;
kick_rand_factor_l = 1;
kick_rand_factor_r = 1;
kickable_margin = 0.7;
max_back_tackle_power = 0;
max_dash_angle = 180;
max_dash_power = 100;
max_tackle_power = 100;
maxmoment = 180;
maxneckang = 90;
maxneckmoment = 180;
maxpower = 100;
minmoment = -180;
minneckang = -90;
minneckmoment = -180;
minpower = -100;
offside_active_area_size = 2.5;
%<<<<<<< HEAD
%=======

%>>>>>>> 01bda8825cae68d27f2e28787c6851ea16cbc722
offside_kick_margin = 9.15;
pen_dist_x = 42.5;
pen_max_goalie_dist_x = 14;
player_accel_max = 1;
player_decay = 0.4;
player_rand = 0.1;
player_speed_max = 1.05;
player_speed_max_min = 0.75;
player_weight = 60;
stamina_capacity = 130600;
stamina_inc_max = 45;
stamina_max = 8000;
stopped_ball_vel = 0.01;
tackle_back_dist = 0;
tackle_dist = 2;
tackle_exponent = 6;
tackle_power_rate = 0.027;
tackle_rand_factor = 2;
tackle_width = 1.25;
visible_angle = 90;


