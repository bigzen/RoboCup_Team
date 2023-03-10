function [ball, players] = goalkeeper(ball,players,id)
    %% Assume the position of the ball is (ball_x, ball_y)
    ball_x = ball.pos(1);
    ball_y = ball.pos(2);
    distance_to_ball=0;   
    
    %% Assume the position of the player is (player_x, player_y)
    player = players(id);
    player_x = player.pos(1);
    player_y = player.pos(2);
    player_speed = player.vel;
    
    %% parametres
    kp = 20;    % Porpational param
    kd = 1;     % Differential param
    tolerance = 0.1;    %set Controller error tolerance
    dribbleKickForce = 2;               % Kick force for dribbling
%     shootKickForce = 7;                 % Kick force for shooting
%     defenderKickForce = 7;              % Kick force for defending
    goalkeeperKickForce = 10;              % Kick force for goalkeeper
    goalThresh = 2;
    
    %% speed of the ball
    ball_speed=ball.vel;
    ball_speed_x=ball_speed(1);
    ball_speed_y=ball_speed(2);
    
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
    prev_distance_to_ball=distance_to_ball;
    distance_to_ball = [player_x - ball_x, player_y - ball_y];
    angle_to_ball = atan2(ball_y - player_y, ball_x - player_x);
    distToGoal = norm(players(id).pos - goalPosition);         % Distance to goal
    ballDistToOwnGoal = norm(ball.pos - ownGoalPosition);          % Distance between ball and own goal
    distToBall = norm(ball.pos - players(id).pos); 


    %% defender behavior
    if ballDistToOwnGoal < 3
        if distToGoal > goalThresh
            desire_position = ownGoalPosition
            distance_to_dpos = [player_x - desire_position(1), player_y - desire_position(2)];
            [player_x,player_y,player_speed,player_acceleration]=PD_Controller(player_x,player_y,player_speed,kp,kd,distance_to_dpos,prev_distance_to_ball);
        else
            [ball_speed_x,ball_speed_y] = KickBall(ball, goalkeeperKickForce, goalPosition);
        end
    else
        desire_position = ownGoalPosition
        distance_to_dpos = [player_x - desire_position(1), player_y - desire_position(2)];
        [player_x,player_y,player_speed,player_acceleration]=PD_Controller(player_x,player_y,player_speed,kp,kd,distance_to_dpos,prev_distance_to_ball);
    end

    pause(0);

    %% update the ball
    
    ball_x = ball_x+ball_speed_x*0.5;
    ball_y = ball_y+ball_speed_y*0.5;  
    ball_speed_x=0.3*ball_speed_x;
    ball_speed_y=0.3*ball_speed_y;
    %% visulization
    ball.pos(1) = ball_x;
    ball.pos(2) = ball_y;
    
    player.pos(1) = player_x;
    player.pos(2) = player_y;
    players(id) = player;
    r = 0.2;

    ball.vel(1) = ball_speed_x;
    ball.vel(2) = ball_speed_y;
    player.vel = player_speed;
    %player.acc = player_acceleration;
    
%     rectangle('Position',[player.pos(1)-r, player.pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor',player.color)
%     rectangle('Position',[ball.pos(1)-0.143, ball.pos(2)-0.143, 2*0.143, 2*0.143],'Curvature', [1,1], 'FaceColor','w')


