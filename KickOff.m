function gameState = KickOff(gameState,advteam) 
    if advteam == 0
        gameState.players = getPlayerInit()
        gameState.ball.position = [4.5,3];
        gameState.players(4).pos = [4.5-0.45*cosd(45),3-0.45*sind(45)];
    elseif advteam == 1
        gameState.players = getPlayerInit()
        gameState.ball.position = [4.5,3];
        gameState.players(5).pos = [4.5+0.45*cosd(45),3+0.45*sind(45)];
    end