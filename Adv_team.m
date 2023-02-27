
function advteam = Advantageteam(gameState)
    for playernum = 1:1:8
        if gameState.players(playernum).lastKick == 1
            advteam = ~gameState.players(playernum).team;             
        end                               
    end    
end


