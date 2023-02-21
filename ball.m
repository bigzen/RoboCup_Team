classdef ball

    properties
        pos_x
        pos_y
        color
    end
    
    methods
        function ball = ball(pos)
            ball.color = 'w';
            ball.pos_x = pos(1);
            ball.pos_y = pos(2);
            display_ball(ball,ball.pos_x,ball.pos_y)
        end
        function display_ball(ball, x, y)
            ball.pos_x = x;
            ball.pos_y = y;

            y_circle = y;
            x_circle = x;
            
            radius=0.143;%the radius of a ball
            circle(x_circle,y_circle,radius,ball.color)
            hold on 
        end
    end
end
