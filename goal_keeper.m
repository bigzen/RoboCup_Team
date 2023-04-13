function [ball_speed, player_acceleration] = goal_keeper(ball,players,id)
 %% parametres
    kp = 20;    % Porpational param
    kd = 1;     % Differential param
    tolerance = 0.45;    %set Controller error tolerance
    dribbleKickForce = 2;               % Kick force for dribbling
%     shootKickForce = 7;                 % Kick force for shooting
%     defenderKickForce = 7;              % Kick force for defending
    goalkeeperKickForce = 10;              % Kick force for goalkeeper
    goalThresh = 2;
    
    %% speed of the ball
    %ball_speed=ball.vel;
    ball_speed_x=0;%ball_speed(1);
    ball_speed_y=0;%ball_speed(2);
    
    %% determind teamates and opponents
    if id <= 4
        teamates = [1 2 3 4];
        teamates(id) = [];         % delete defender itself
        opponents = [5 6 7 8];
    else
        teamates = [5 6 7 8];
        teamates(id - 4) = [];         % delete defender itself
        opponents = [1 2 3 4];
    end

    %% determind goal positions
    if players(id).team == 0
        ownGoalPosition = [0 3];
        goalPosition = [9 3];
    else
        ownGoalPosition = [9 3];
        goalPosition = [0 3];
    end
    %% caculate the distance and angle
    distToGoal = norm(players(id).pos - goalPosition);         % Distance to goal
    ballDistToOwnGoal = norm(ball.position - ownGoalPosition);          % Distance between ball and own goal
    player_acceleration = [0,0];

    %% defender behavior
    if ballDistToOwnGoal < 3
        if distToGoal > goalThresh
            desire_position = ownGoalPosition;
            [player_acceleration]=PD_Controller(kp,kd,desire_position, desire_position,players(id).pos, players(id).prev_pos);
        else
            [ball_speed_x,ball_speed_y] = KickBall(ball, goalkeeperKickForce, goalPosition);
        end
    else
        desire_position = ownGoalPosition;
        [player_acceleration]=PD_Controller(kp,kd,desire_position, desire_position,players(id).pos, players(id).prev_pos);
    end
    ball_speed = [ball_speed_x, ball_speed_y];