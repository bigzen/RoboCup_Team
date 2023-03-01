function gameState = updateGameState(gameState)
%UPDATEGAMESTATE Summary of this function goes here
%   Detailed explanation goes here
    [gameState.ball,gameState.players(1)] = PD2(gameState.ball,gameState.players);
end


