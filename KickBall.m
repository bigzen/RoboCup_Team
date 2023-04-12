function [ball_speed_x,ball_speed_y] = KickBall(ball, kickForce, targetPosition)
load('robotSoccerParam','ball_weight')
angularNoise = 0.3;
kickBallNoise = 0.3;
ballFrictionForce = -0.1;
ball_contact_time = 0.05;
ballPosition = ball.position;
% updatedBall = ball;

%caculate the force with kickBallNoise
kickBallForce=kickForce + kickBallNoise*normrnd(0.5,0) - 1;

% caculate the unit vector with angularNoise
kickDirection = (targetPosition - ballPosition) / norm(targetPosition - ballPosition);
kickDirection(1) = kickDirection(1) + normrnd(0, angularNoise);
kickDirection(2) = kickDirection(2) + normrnd(0, angularNoise);
kickDirection = kickDirection / norm(kickDirection);

speed = ball.velocity+ball_contact_time*kickBallForce*kickDirection/ball_weight;
ball_speed_x = speed(1);
ball_speed_y = speed(2);

end
