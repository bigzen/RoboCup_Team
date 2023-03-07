function gameState = updateGameState(gameState)
%UPDATEGAMESTATE Summary of this function goes here
%   Detailed explanation goes here
    [gameState.ball,gameState.players] = PD2(gameState.ball,gameState.players,5);

end


