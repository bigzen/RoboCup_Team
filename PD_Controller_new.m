function [player_acceleration]=PD_Controller_new(Kp,Kd,desire_position,desire_prev_pos,player_position,player_prev_pos)
    
    % distance and previous distance
    distance_to_dpos = [player_position(1) - desire_position(1), player_position(2) - desire_position(2)];
    prev_distance_to_dpos = [player_prev_pos(1) - desire_prev_pos(1), player_prev_pos(2) - desire_prev_pos(2)];

    % inatialize the speed of the player
    d_distance_to_dpos=prev_distance_to_dpos-distance_to_dpos;
    player_acceleration = [0,0];

    % caculate player acceleration by PD controller
    player_acceleration(1) = -Kp * distance_to_dpos(1) - Kd * d_distance_to_dpos(1);
    player_acceleration(2) = -Kp * distance_to_dpos(2) - Kd * d_distance_to_dpos(2);  

    % max acceleration
    max_acceleration = 1;   

    % cannot acceed max acceleration
    if norm(player_acceleration) > max_acceleration
        player_acceleration = max_acceleration * player_acceleration / norm(player_acceleration);
    end
end
