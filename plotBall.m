function plotBall(ball)
%PLOTBALL Summary of this function goes here
%   Detailed explanation goes here
    r = 0.143;
    hold on
    pos = ball.pos;
    rectangle('Position',[pos(1)-r, pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor','w')
    hold off
end
