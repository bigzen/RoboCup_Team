function [ball_speed_x,ball_speed_y]=KickBall(ball_speed,angle_to_ball)
% 设定kick ball的力度
kick_power = 1;

        % 计算kick ball的方向和力度
        kick_angle = 2*pi*rand()-pi;
        kick_speed_x = kick_power * cos(kick_angle);
        kick_speed_y = kick_power * sin(kick_angle);
        
        % 更新球的速度
        %update the speed of the ball
        ball_speed_x=ball_speed(1);
        ball_speed_y=ball_speed(2);
        ball_speed_x = ball_speed_x + kick_speed_x;
        ball_speed_y = ball_speed_y + kick_speed_y;




