function visualizeGameState(gameState)
    %VISUALIZEGAMESTATE Summary of this function goes here
    %   Detailed explanation goes here
    idx=1;
    if gameState.time~=1
        clf(idx)
    else
        figure(idx)
    end
    plotSoccerField(gameState)
    pause(0.001)
    %plotPlayers(gameState.time, gameState.players)
    %plotBall(gameState.time, gameState.ball) 
end

