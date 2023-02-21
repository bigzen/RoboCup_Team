function [move] = move_toball(i, p, b,speed)

    dx = b.pos_x - p.pos_x;
    dy = b.pos_y - p.pos_y;
    speed_x = dx/1;
    speed_y = dy/1;
    p.display_person(i*speed_x*speed+p.pos_x,i*speed_y*speed+p.pos_y);
    
end 