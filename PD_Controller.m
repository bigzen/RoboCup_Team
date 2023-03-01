%Package PD Controller
function [player_x_next,player_y_next]=PD_Controller(player_x,player_y,Kp,Kd,distance_to_ball,angle_to_ball)

 % 初始化球员的速度inatialize the speed of the pl
    player_speed = [0, 0];


 % 计算PD控制器的输出，即球员的速度
    player_speed(1) = Kp * distance_to_ball * cos(angle_to_ball) - Kd * player_speed(1);
    player_speed(2) = Kp * distance_to_ball * sin(angle_to_ball) - Kd * player_speed(2);  

 % 设定球员移动的最大速度
    max_speed = 1;   

 % 如果球员的速度超过了最大速度，则将其缩放到最大速度
    if norm(player_speed) > max_speed
        player_speed = max_speed * player_speed / norm(player_speed);
    end
    
 % 更新球员的位置
    player_x_next = player_x + player_speed(1);
    player_y_next = player_y + player_speed(2);
end