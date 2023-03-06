function visualizeGameState(gameState)
    %VISUALIZEGAMESTATE Summary of this function goes here
    %   Detailed explanation goes here
    plotSoccerField()
    plotPlayers(gameState.players)
    plotBall(gameState.ball) 
end

