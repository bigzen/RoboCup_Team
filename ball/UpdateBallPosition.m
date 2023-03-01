function [updatedBall] = UpdateBallPosition(ball, timeDelta, acceleration)
%UPDATEBALLPOSITION Summary of this function goes here
%   Detailed explanation goes here
fieldLength=120;
fieldWidth=90;
bounceCoefficient=0.2;
frictionCoefficient=0.85; %less than 1

updatedBall=ball;

updatedBall(1,1)=ball(1,1)+ball(2,1)*timeDelta;
updatedBall(1,2)=ball(1,2)+ball(2,2)*timeDelta;

updatedBall(2,1)=frictionCoefficient*ball(2,1);
updatedBall(2,2)=frictionCoefficient*ball(2,2);

end

