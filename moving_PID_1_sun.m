clear all; clc;

% ball
x_ball = 100;
x_ball_last = 100;
y_ball = 100;

% robot 1
x = 150;
y = 150;
theta = -160;
theta_last = theta;
theta_ball_last = atan2(y_ball - y, x_ball - x) * 180 / pi;
v = 0;
v_max = 0.3;

% pd controller variables
Kp = 7.5270;
Kd = 0.5;
dt = 0.01;
data = [];

% robot 2
x_1 = 1;
y_1 = 1;
theta_1 = 90;
v_1 = 0;
theta_1_last = theta_1;
theta_1_ball_last = atan2(y_ball - y_1, x_ball - x_1) * 180 / pi;


for i = 1: 1: 1000

    [x, y, theta, v, theta_ball_last, theta_last] = moveRobot_PD(x, y, theta, v, x_ball, y_ball, v_max, Kp, Kd, dt, x_ball_last, theta_last, theta_ball_last);
    [x_1, y_1, theta_1, v_1, theta_1_ball_last, theta_1_last, x_ball_last] = moveRobot_PD(x_1, y_1, theta_1, v_1, x_ball, y_ball, v_max, Kp, Kd, dt, x_ball_last, theta_1_last, theta_1_ball_last);
    data = [data;[x, y, theta, v]]; % store the data of robot 1

    % visulization
    plot(x, y, 'o')
    hold on
    plot(x_ball, y_ball, 'x')
    hold on
    plot(x_1, y_1, 'o')
    hold off
    axis([0 250 0 250])
    drawnow

    % move the ball
    x_ball = x_ball + 0.1;
    y_ball = y_ball - 0.1;
end


function [x_next, y_next, theta_next, v_next, theta_ball_last, theta_last, x_ball_last] = moveRobot_PD(x, y, theta, v, x_ball, y_ball, v_max, Kp, Kd, dt, x_ball_last, theta_last, theta_ball_last)
    
    dis_x = x_ball - x; % calculate the distant to goal along x
    dis_y = y_ball - y; % calculate the distant to goal along y
    theta_ball = atan2(dis_y, dis_x) * 180 / pi; % calculate the angle to the goal
    d_theta_ball = theta_ball_last - theta_ball;% calculate the dtheta_goal
    theta_ball_last = theta_ball;
    d_theta = theta_last - theta;% calculate the dtheta
    theta_last = theta;
    d_ball_x = x_ball_last - x_ball;% calculate the dx_goal
    x_ball_last = x_ball;
    
    e_x = abs(x_ball - x)-1.5;
    e_theta = theta_ball - theta;
    u_x = Kp * e_x + Kd * (d_ball_x/dt - cos(e_theta)); % calculate the line acceleration
    u_x = min(0.2, u_x);
    u_x = max(-1, u_x);
    u_theta = Kp * e_theta + Kd * (d_theta_ball - d_theta)/dt; % calculate the angle velocity

    % renew the velocity of the robot
    v_next = min(v_max, v + u_x * dt);
    v_next = max(v_next, 0);
    
    % renew the heading angle and the velocity
    theta_next = theta + u_theta * dt;
    x_next = x + v_next * cosd(theta_next);
    y_next = y + v_next * sind(theta_next);
end
