function gameState = updateGameState(gameState)
%UPDATEGAMESTATE Summary of this function goes here
%   Detailed explanation goes here
%% call the plyer action function and store the variables
update = struct('id',[], ...
                 'ball', [],...
                 'player', []);
for id=1:8
    if gameState.players(id).role==0
        [ball_speed, player_acceleration] = goal_keeper(gameState.ball,gameState.players,id);
        update(id).id=id;
        update(id).ball=ball_speed;
        update(id).player=player_acceleration;
    elseif gameState.players(id).role==1
        [ball_speed, player_acceleration] = defender(gameState.ball,gameState.players,id);
        update(id).id=id;
        update(id).ball=ball_speed;
        update(id).player=player_acceleration;
    else
        [ball_speed, player_acceleration] = attacker(gameState.ball,gameState.players,id);
        update(id).id=id;
        update(id).ball=ball_speed;
        update(id).player=player_acceleration;
    end
end

%% calculate new player position and speed update the game state


%% calculate ball position and decide who kickedlast 

%%
end

