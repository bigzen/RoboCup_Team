classdef ball

    properties
        %position of ball
        pos
        %velocity of ball
        vel
        %direction of ball
        dir
    end
    
    methods
        function ball = getballInit(ball,initBallPos)
            ball.pos = initBallPos;
            ball.vel = [0 0];
            ball.dir = [0 0];
   
        end
    end
end
