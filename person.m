classdef person
    properties
        % color
        color
        %position
        pos_x
        pos_y
        ang
    end

    methods
        %function initialises the person constructor
        function person = person(pos)
            person.color = 'b';
            person.pos_x = pos(1);
            person.pos_y = pos(2);
            person.ang = atan2(pos,[0 0]);
            display_person(person,person.pos_x,person.pos_y)
        end
        

        function display_person(person,x,y)
            person.pos_x = x;
            person.pos_y = y;

            y_circle = y;
            x_circle = x;
            
            radius=0.2;%change the radius of player
            circle(x_circle,y_circle,radius,person.color)
            hold on 
        end
    end
end