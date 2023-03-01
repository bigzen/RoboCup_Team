function [ball, player] = PD2(ball,players)

    % Assume the position of the ball is (ball_x, ball_y)
    ball_x = ball.pos(1);
    ball_y = ball.pos(2);
        
    
    % 假设球员初始位置是(player_x, player_y)
    % players(idx).pos(1) players(idx).pos(2)
    %Assume the position of the player is (player_x, player_y)
    player = players(5);
    player_x = player.pos(1);
    player_y = player.pos(2);
    
    %players(idx).pos(1)=player_x;
    %players(idx).pos(2)=player_y;
    
    % 设定PD控制器的参数
    %set PD Controller's parametres
    kp = 0.1;  % 比例系数
    kd = 0.01;  % 微分系数
    
    % 设定控制器的误差容忍度
    %set Controller error tolerance
    tolerance = 0.2;
    
    %设定球运动速度
    %speed of the ball
    ball_speed=[0,0];
    ball_speed_x=ball_speed(1);
    ball_speed_y=ball_speed(2);
    
    
    % 设定一个循环，不断更新球员的位置，直到球员到达球的位置
    %main loop of updating positions of  players
    %while norm([player_x - ball_x, player_y - ball_y]) > tolerance
    while true
    %移动球
    
    
    % 计算球员到球的距离和角度
        distance_to_ball = norm([player_x - ball_x, player_y - ball_y]);
        angle_to_ball = atan2(ball_y - player_y, ball_x - player_x);
    
    
        
    
    % 如果球和球员的距离小于等于一个设定的距离，则进行kick ball操作
        if norm([player_x - ball_x, player_y - ball_y]) <= tolerance
    %%%%%%%%%%%%invoke the KickBall
            [ball_speed_x,ball_speed_y]=KickBall(ball_speed,angle_to_ball)
        else
    %%%%%%%%%%%%invoke the PD
            [player_x,player_y]=PD_Controller(player_x,player_y,kp,kd,distance_to_ball,angle_to_ball);
        end 
    
         pause(0.05);
    %update the ball
          
        ball_x = ball_x+ball_speed_x;
        ball_y = ball_y+ball_speed_y;  
        ball_speed_x=0;
        ball_speed_y=0;
    % 显示球员和球的位置
    % visulization
        ball.pos(1) = ball_x;
        ball.pos(2) = ball_y;
        
        player.pos(1) = player_x;
        player.pos(2) = player_y;
        r = 0.2;
        
        rectangle('Position',[player.pos(1)-r, player.pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor',player.color)
        rectangle('Position',[ball.pos(1)-0.143, ball.pos(2)-0.143, 2*0.143, 2*0.143],'Curvature', [1,1], 'FaceColor','w')
        
        drawnow
    end
