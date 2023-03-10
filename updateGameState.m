function gameState = updateGameState(gameState)
%UPDATEGAMESTATE Summary of this function goes here
%   Detailed explanation goes here
%     [gameState.ball,gameState.players] = PD2(gameState.ball,gameState.players,5);
    [gameState.ball,gameState.players] = PD3(gameState.ball,gameState.players,3);
    [gameState.ball,gameState.players] = defender(gameState.ball, gameState.players, 2);
    [gameState.ball,gameState.players] = goalkeeper(gameState.ball, gameState.players, 1);
    [gameState.ball,gameState.players] = PD3(gameState.ball,gameState.players,6);
    [gameState.ball,gameState.players] = defender(gameState.ball, gameState.players, 7);
    [gameState.ball,gameState.players] = goalkeeper(gameState.ball, gameState.players, 8);
 
end


