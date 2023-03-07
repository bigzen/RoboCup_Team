classdef player
    properties
        % color
        color
        %position
        pos
        dir
        %player team
        team
        %player velocity
        vel
        %player acceleration
        acc
        %player role: defender attacker or goalkeeper
        %0:goal keeper, 1: defender, 2:attacker
        role
        %player id: 1~8
        id
        % is player the last one to kick the ball
        lastKick
    end

    methods
        function player = getPlayerInit(player,robotColors,initialPoses,initRoles)
            % initialize 8 players
            for idx=1:8
                player(idx).color = robotColors(idx);
                player(idx).pos = initialPoses(idx,:);
                player(idx).dir = (idx>4)*pi;
                player(idx).team = idx>4;
                player(idx).vel = [0,0];
                player(idx).acc = [0,0];
                player(idx).role = initRoles(idx);
                player(idx).id = idx;
                player(idx).lastKick = -1;
            end
        
        end

        function display_player(player,x,y)
            player.pos_x = x;
            player.pos_y = y;

            y_circle = y;
            x_circle = x;
            
            radius=0.2;%change the radius of player
            circle(x_circle,y_circle,radius,player.color)
            hold on 
        end
    end
end