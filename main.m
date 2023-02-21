%set initial position of ball
b_pos = [8 5.5];
b = ball(b_pos);
%set initial position of player 1
p1_pos = [5.5 5];
p1 = person(p1_pos);
%set speed < 0.2(m/s)
speed = 0.1;
%calculate time
t = sqrt((b.pos_x - p1.pos_x) ^ 2 + (b.pos_y - p1.pos_y) ^ 2)/speed;
%then loop and display the play
for i = 1:1/speed
    soccergamefiled();
    b.display_ball(b.pos_x,b.pos_y);
    move_toball(i,p1,b,speed)
    pause(speed)
    movie(i) = getframe;
end


