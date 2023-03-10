%Package PD Controller
function [player_x_next,player_y_next,player_speed_next,player_acceleration]=PD_Controller(player_x,player_y,player_speed,Kp,Kd,distance_to_ball,prev_distance_to_ball)
 % 初始化球员的速度inatialize the speed of the pl
    d_distance_to_ball=prev_distance_to_ball-distance_to_ball;
    dt=0.15;
    player_acceleration = [0,0];
 % 计算PD控制器的输出，即球员的速度
    player_acceleration(1) = -Kp * distance_to_ball(1) - Kd * d_distance_to_ball(1);
    player_acceleration(2) = -Kp * distance_to_ball(2) - Kd * d_distance_to_ball(2);  

 % 设定球员移动的最大加速度
    max_acceleration = 50;   
    max_speed=2;

  % 如果球员的加速度超过了最大加速度，则将其缩放到最大加速度
    if norm(player_acceleration) > max_acceleration
        player_acceleration = max_acceleration * player_acceleration / norm(player_acceleration);
    end
 % 更新球员的位置 
    player_speed_next = player_speed + player_acceleration*dt;
    player_x_next = player_x + player_speed_next(1)*dt;
    player_y_next = player_y + player_speed_next(2)*dt;

   if norm(player_speed_next) > max_speed
        player_speed_next = max_speed * player_speed_next / norm(player_speed_next);
   end
end