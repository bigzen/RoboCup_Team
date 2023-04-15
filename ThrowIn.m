function gameState = ThrowIn2(gameState,advteam)
    %% Caculate the ThrowIn ball position
    throwInPos = [0 0];
    if gameState.ball.position(2) > 6
        slope = (gameState.ball.prev_pos(2)-gameState.ball.position(2))/(gameState.ball.prev_pos(1)-gameState.ball.position(1));
        throwInPos(1) = gameState.ball.prev_pos(1) + (6 - gameState.ball.prev_pos(2)) / slope;
        throwInPos(2) = 6;
    else
        slope = (gameState.ball.prev_pos(2)-gameState.ball.position(2))/(gameState.ball.prev_pos(1)-gameState.ball.position(1));
        throwInPos(1) = gameState.ball.prev_pos(1) + (0 - gameState.ball.prev_pos(2)) / slope;
        throwInPos(2) = 0;
    end
    
    gameState.ball.position = throwInPos;

    if advteam == 0
        thruplayeridx = randsample([2 4 3], 1);
        if (gameState.ball.position(1) > 0 && gameState.ball.position(1) <=4.5) && gameState.ball.position(2) <= 0
            gameState.players(thruplayeridx).pos = [gameState.ball.position(1)-0.45*cosd(45) gameState.ball.position(2)-0.45*sind(45)];
            
        elseif (gameState.ball.position(1) > 4.5 && gameState.ball.position(1) <=7.875) && gameState.ball.position(2) <= 0
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1) gameState.ball.position(2)-0.45*sind(45)];
        elseif (gameState.ball.position(1) > 7.875 && gameState.ball.position(1) <9) && gameState.ball.position(2) <= 0
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1)+0.45*cosd(45) gameState.ball.position(2)-0.45*sind(45)];
        elseif (gameState.ball.position(1) > 0 && gameState.ball.position(1) <=4.5) && gameState.ball.position(2) >= 6
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1)-0.45*cosd(45) gameState.ball.position(2)+0.45*sind(45)];
        elseif (gameState.ball.position(1) > 4.5 && gameState.ball.position(1) <=7.875) && gameState.ball.position(2) >= 6
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1) gameState.ball.position(2)+0.45*sind(45)];
        elseif (gameState.ball.position(1) > 7.875 && gameState.ball.position(1) <9) && gameState.ball.position(2) >= 6
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1)+0.45*cosd(45) gameState.ball.position(2)+0.45*sind(45)];
        end
    elseif advteam == 1 
        thruplayeridx = randsample([6 7 8], 1);
        if (gameState.ball.position(1) > 0 && gameState.ball.position(1) <=1.125) && gameState.ball.position(2) <= 0
            gameState.players(thruplayeridx).pos = [gameState.ball.position(1)-0.45*cosd(45) gameState.ball.position(2)-0.45*sind(45)];
        elseif(gameState.ball.position(1) > 1.125 && gameState.ball.position(1) <=4.5) && gameState.ball.position(2) <= 0
            gameState.players(thruplayeridx).pos = [gameState.ball.position(1) gameState.ball.position(2)-0.45*sind(45)];
        elseif (gameState.ball.position(1) > 4.5 && gameState.ball.position(1) <9) && gameState.ball.position(2) <= 0
            gameState.players(thruplayeridx).pos = [gameState.ball.position(1)+0.45*cosd(45) gameState.ball.position(2)-0.45*sind(45)];
        elseif (gameState.ball.position(1) > 0 && gameState.ball.position(1) <=1.125) && gameState.ball.position(2) <= 6
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1)-0.45*cosd(45) gameState.ball.position(2)+0.45*sind(45)];
        elseif (gameState.ball.position(1) > 1.125 && gameState.ball.position(1) <=4.5) && gameState.ball.position(2) <= 6
                gameState.players(thruplayeridx).pos = [gameState.ball.position(1) gameState.ball.position(2)+0.45*sind(45)];
        elseif (gameState.ball.position(1) > 4.5 && gameState.ball.position(1) <9) && gameState.ball.position(2) <= 6
            gameState.players(thruplayeridx).pos = [gameState.ball.position(1)+0.45*cosd(45) gameState.ball.position(2)+0.45*sind(45)];
        end
        
    end
    for idx = 1:8 
        gameState.players(idx).vel = [0,0];
    end
end
