function gameState = initFoulState(gameState,flag)
    advteam= Adv_team(gameState);
    if flag == GameFlag.outOfPlay
        gameState = ThrowIn(gameState,advteam) ;
    elseif flag == GameFlag.goalKick
        gameState = GoalKick(gameState,advteam) ;
    elseif flag == GameFlag.goalScore
        gameState = KickOff(gameState,advteam);
    elseif flag == GameFlag.corner
        gameState = CornerKick(gameState,advteam);
    end
end

