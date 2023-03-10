function [ball_speed, player_acceleration] = attacker(ball,players,id)

    % Assume the position of the ball is (ball_x, ball_y)
    ball_x = ball.pos(1);
    ball_y = ball.pos(2);
    distance_to_ball=0;   
    
    % 假设球员初始位置是(player_x, player_y)
    % players(idx).pos(1) players(idx).pos(2)
    %Assume the position of the player is (player_x, player_y)
    player = players(id);
    player_x = player.pos(1);
    player_y = player.pos(2);
    player_speed = player.vel;
    
    %players(idx).pos(1)=player_x;
    %players(idx).pos(2)=player_y;
    
    % 设定PD控制器的参数
    %set PD Controller's parametres
    kp = 20;  % 比例系数
    kd = 1;  % 微分系数
    
    % 设定控制器的误差容忍度
    %set Controller error tolerance
    tolerance = 0.1;
    
    %设定球运动速度
    %speed of the ball

    %ball_speed=ball.vel;
    ball_speed_x=0;
    ball_speed_y=0;
    
    
    % 设定一个循环，不断更新球员的位置，直到球员到达球的位置
    %main loop of updating positions of  players
    %while norm([player_x - ball_x, player_y - ball_y]) > tolerance
    %移动球
    % 计算球员到球的距离和角度
    prev_distance_to_ball=distance_to_ball;
    distance_to_ball = [player_x - ball_x, player_y - ball_y];
    angle_to_ball = atan2(ball_y - player_y, ball_x - player_x);


    

    %% behvior
    if norm([player_x - 0, player_y - 3]) <= 2
        if norm([player_x - ball_x, player_y - ball_y]) <= tolerance
            target_position = [0 3];
            [ball_speed_x,ball_speed_y] = KickBall(ball, 7, target_position);
        else
            [player_acceleration]=PD_Controller(player_x,player_y,player_speed,kp,kd,distance_to_ball,prev_distance_to_ball);
        end
    else
        if norm([player_x - ball_x, player_y - ball_y]) <= tolerance
            target_position = [0 3];
            [ball_speed_x,ball_speed_y] = KickBall(ball, 2, target_position);
        else
            [player_acceleration]=PD_Controller(player_x,player_y,player_speed,kp,kd,distance_to_ball,prev_distance_to_ball);
        end
    end
    

    %pause(0);
%update the ball
    
    %ball_x = ball_x+ball_speed_x*0.5;
    %ball_y = ball_y+ball_speed_y*0.5;  
    %ball_speed_x=0.3*ball_speed_x;
    %ball_speed_y=0.3*ball_speed_y;
% 显示球员和球的位置
% visulization
    %ball.pos(1) = ball_x;
    %ball.pos(2) = ball_y;
    
    %player.pos(1) = player_x;
    %player.pos(2) = player_y;
    %players(id) = player;
    %r = 0.2;

    %ball.vel(1) = ball_speed_x;
    %ball.vel(2) = ball_speed_y;
    %player.vel = player_speed;
    %player.acc = player_acceleration;
    ball_speed = [ball_speed_x,ball_speed_y];
%     rectangle('Position',[player.pos(1)-r, player.pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor',player.color)
%     rectangle('Position',[ball.pos(1)-0.143, ball.pos(2)-0.143, 2*0.143, 2*0.143],'Curvature', [1,1], 'FaceColor','w')
