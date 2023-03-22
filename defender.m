function [ball_speed, player_acceleration] = defender(ball,players,id)
    %% parametres
    kp = 20;    % Porpational param
    kd = 1;     % Differential param
    tolerance = 0.45;    %set Controller error tolerance
    dribbleKickForce = 2;               % Kick force for dribbling
    shootKickForce = 7;                 % Kick force for shooting
    defenderKickForce = 7;              % Kick force for defending
    goalThresh = 2;
    
    %% speed of the ball
    %ball_speed=ball.vel;
    ball_speed_x=0;
    ball_speed_y=0;
    
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
    distToBall = norm(ball.position - players(id).pos); 
    player_acceleration = [0,0];

    %% defender behavior
    if players(id).lastKick == 1       % if ball held
        if distToGoal < goalThresh
            if distToBall > tolerance       % if dis tance to ball > torelance -> move to ball
                [player_acceleration]=PD_Controller_new(kp,kd,ball.position, ball.prev_pos,players(id).pos, players(id).prev_pos);
            else
                [ball_speed_x,ball_speed_y] = KickBall(ball, shootKickForce, goalPosition);
            end
        else
            if distToBall > tolerance
                [player_acceleration]=PD_Controller_new(kp,kd,ball.position, ball.prev_pos,players(id).pos, players(id).prev_pos);
            else
                [ball_speed_x,ball_speed_y] = KickBall(ball, dribbleKickForce, goalPosition);
            end
        end

    elseif players(teamates(1)).lastKick == 1 || players(teamates(2)).lastKick == 1 || players(teamates(3)).lastKick == 1
        desire_position = [4.5 3];
        [player_acceleration]=PD_Controller_new(kp,kd,desire_position, desire_position,players(id).pos, players(id).prev_pos);
    else
        if ballDistToOwnGoal > 3
            if distToBall > tolerance       % if distance to ball > torelance -> move to ball
                desire_position = (ball.position + ownGoalPosition) / 2;      % block goal
                [player_acceleration]=PD_Controller_new(kp,kd,desire_position, desire_position,players(id).pos, players(id).prev_pos);
            else
                [ball_speed_x,ball_speed_y] = KickBall(ball, defenderKickForce, goalPosition);
            end
        else
            if distToBall > tolerance
                [player_acceleration]=PD_Controller_new(kp,kd,ball.position, ball.prev_pos,players(id).pos, players(id).prev_pos);
            else
                [ball_speed_x,ball_speed_y] = KickBall(ball, defenderKickForce, goalPosition);
            end
        end
    end
    
    ball_speed=[ball_speed_x,ball_speed_y];


