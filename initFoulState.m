function gameState = initFoulState(gameState,flag);
    advteam= Adv_team(gameState);
    if gameState.state == "ThrowIn"
        gameState = ThrowIn(gameState,advteam) ;
    elseif gameState.state == "GoalKick"
        gameState = GoalKick(gameState,advteam) ;
    elseif gameState.state == "KickOff"
        gameState = KickOff(gameState,advteam);
    elseif gameState.state == "CornerKick"
        gameState = CornerKick(gameState,advteam);
    end
end
