function advteam = Adv_team(gameState)
advteam = -1;
for playernum = 1:1:8
    if gameState.players(playernum).lastKick == 1
        if gameState.players(playernum).team == 0
            advteam = 1;             
        else 
            advteam = 0;     
        end 
    end                          
end
