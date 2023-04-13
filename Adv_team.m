
function advteam = Adv_team(gameState,flag)
advteam = -1;
load('robotSoccerParam','fieldLimitsX')
load('robotSoccerParam','goalPosts')

if flag == GameFlag.outOfPlay || flag == GameFlag.goalKick || flag == GameFlag.corner
    for playernum = 1:1:8
        if gameState.players(playernum).lastKick == 1
            if gameState.players(playernum).team == 0
                advteam = 1;             
            else 
                advteam = 0;     
            end 
        end                          
    end
elseif flag == GameFlag.goalScore
    if gameState.ball.position(1) < fieldLimitsX(1) 
       if gameState.ball.position (2) < goalPosts(1,2)&& gameState.ball.position (2) > goalPosts(2,2)
           advteam = 0;        
       end 
    elseif gameState.ball.position(1)> fieldLimitsX(2)
        if gameState.ball.position(2) < goalPosts(1,2)&& gameState.ball.position(2) > goalPosts(2,2)
            advteam = 1;
        end       
    end
    
end