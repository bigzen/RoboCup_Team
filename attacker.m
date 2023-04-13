function [ball_speed, player_acceleration] = attacker(ball,players,id)
    %% parametres
    kp = 20;    % Porpational param
    kd = 1;     % Differential param
 
    tolerance = 0.45;
    
    ball_speed_x=0;
    ball_speed_y=0;
    
    player_acceleration = [0,0];

        %% determind goal positions
    if players(id).team == 0
        ownGoalPosition = [0 3];
        goalPosition = [9 3];
    else
        ownGoalPosition = [9 3];
        goalPosition = [0 3];
    end
    

    %% behvior
    if norm(players(id).pos - goalPosition) <= 2
        if norm(players(id).pos - ball.position) <= tolerance
            [ball_speed_x,ball_speed_y] = KickBall(ball, 7, goalPosition);
        else
            [player_acceleration]=PD_Controller(kp,kd,ball.position, ball.prev_pos,players(id).pos, players(id).prev_pos);
        end
    else
        if norm(players(id).pos - ball.position) <= tolerance
            [ball_speed_x,ball_speed_y] = KickBall(ball, 2, goalPosition);
        else
            [player_acceleration]=PD_Controller(kp,kd,ball.position, ball.prev_pos,players(id).pos, players(id).prev_pos);
        end
    end
 
    ball_speed = [ball_speed_x,ball_speed_y];