function visualizeGameState(gameState)
    %VISUALIZEGAMESTATE Summary of this function goes here
    %   Detailed explanation goes here
    figure(gameState.time)
    plotSoccerField(gameState.time)
    plotPlayers(gameState.time, gameState.players)
    plotBall(gameState.time, gameState.ball) 
end

