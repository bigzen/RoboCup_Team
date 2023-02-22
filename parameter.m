%% Object Detector and Robot Detector sensor parameters
objDetectorOffset = [0 0];
objDetectorAngle = 0;
objDetectorFOV = pi/3;
objDetectorRange = 100;
objColors = [0 0.75 0; 1 0 0; 0 0 1];
objMarkers = 'o^^';
objDetectorMaxHits = 5;

robotDetectorOffset = [0 0];
robotDetectorAngle = 0;
robotDetectorFOV = pi;
robotDetectorRange = 20;
robotDetectorMaxHits = 5;

%% Behavior Logic Parameters
% General parameters
distThresh = 1;         % Threshold distance to track points [m]
angThresh = pi/16;      % Threshold angle to track rotation [rad]
goalThresh = 20;        % Threshold distance from the goal to kick ball [m]

% Attacker parameters
attackerKickSpeed = 3;              % Kick speed for attacking
attackerMinGoalDist = 5;            % Distance before taking the ball away from goal and try kick again
attackerMaxGoalDist = 10;           % Distance away from goal to travel before kicking again
dribbleTime = 25;                   % Max time before kicking the ball while dribbling
dribbleKickSpeed = 2;               % Kick speed for dribbling

% Defender parameters
defenderHomePoses = [20 28.5 0;
                     20 18.5 0]';   % Defender poses for home team
defenderAwayPoses = [72 28.5 pi;
                     72 18.5 pi]';  % Defender poses for away team
defenderKickSpeed = 5;              % Kick speed for defending

% Goalkeeper parameters
goalkeeperPoses = [ 2 23.5 0;
                   90 23.5 pi]';    % Goalkeeper poses for home and away teams
goalkeeperKickSpeed = 10;           % Kick speed for goalkeeping

%% The rule for the velocity, accelaration and speed
% The ball limitation
ball_accel_max = 2.7;   %max. ball acceleration
ball_decay	= 0.94;     %ball decay
ball_rand	= 0.05;	    %noise parameter for the ball movement
ball_size	= 0.085;	%ball size
ball_speed_max	= 3;	%max. ball velocity
ball_stuck_area	= 3;	%threshold of distance to detect a stucked situation

% The player
player_accel_max	= 1;	        %max. player acceleration
player_decay	= 0.4;	            %default player decay
player_rand	= 0.1;	                %players= movement noise parameter
player_size	= 0.3;	                %player radius
player_speed_max	= 1.05;	        %maxium speed of players
player_speed_max_min	= 0.75;	    %The minumum value of the maximum speed of players

% Behavior 
kickable_margin_delta_max	= 0.1;	    %defines the upper bound of player=s kickable margin when added to default kickable margin
kickable_margin_delta_min	= -0.1; 	%defines the lower bound of player=s kickable margin when added to default kickable margin
stopped_ball_vel	= 0.01;	            %threshold value to detect ball is moving or not
visible_angle	= 90;	                %visible angle
visible_distance	= 3;
keepaway_length	= 20;	    %length of rectangle in keep away mode
keepaway_width	= 20;	    %width of rectangle in keep away mode
kick_power_rate	= 0.027;	%kick power rate
kick_rand	= 0.1;	        %base parameter for noise added directly to kicks
kick_rand_factor_l	= 1;	%factor to multiply kick rand for left team
kick_rand_factor_r	= 1;	%factor to multiply kick rand for right team
kickable_margin	= 0.7;	    %default kickable margin

catch_probability	=1;	    %default goalie catch probability
catchable_area_L	=1.2;	%goalie=s defalut catchable area length
catchable_area_w	=1;	    %goalie=s catchable area width

