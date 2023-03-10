function [ball_speed_x,ball_speed_y] = KickBall(ball, kickForce, targetPosition)
angularNoise = 0.3;
kickBallNoise = 0.3;
ballFrictionForce = -0.1;
dt = 0.5;
ballPosition = ball.pos;
% updatedBall = ball;

%caculate the force with kickBallNoise
kickBallForce=kickForce + kickBallNoise*normrnd(0.5,0) - 1 + ballFrictionForce;

% caculate the unit vector with angularNoise
kickDirection = (targetPosition - ballPosition) / norm(targetPosition - ballPosition);
kickDirection(1) = kickDirection(1) + normrnd(0, angularNoise);
kickDirection(2) = kickDirection(2) + normrnd(0, angularNoise);
kickDirection = kickDirection / norm(kickDirection);

ball.acc= ball.acc + kickBallForce*kickDirection;
ball.vel = ball.vel + ball.acc * dt;
ball_speed_x = ball.vel(1);
ball_speed_y = ball.vel(2);

end