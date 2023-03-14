function gameState = CornerKick(gameState,advteam)
    if (gameState.ball.position(2) > 0 && gameState.ball.position(2) <=1.7) && gameState.ball.position(1) <= 0 && advteam == 1
        gameState.ball.position = [0 0];
        thruplayeridx = randsample([5 6 7], 1);
        gameState.players(thruplayeridx).pos = [gameState.ball.position(1)-0.45*cosd(45) gameState.ball.position(2)-0.45*sind(45)];
        
        allPositions = zeros(100,100, 2);
        for i = 1:100
            for j = 1:100
                allPositions(i,j,:) = [i*0.060, j*0.08];
            end
        end
        allPositions = reshape(allPositions, [], 2);
        allPositions((allPositions(:,1) > 2 ),:) = [];
        allPositions((allPositions(:,1) < 0.5 ),:) = [];
        allPositions((allPositions(:,2) > 5.5 ),:) = [];
        allPositions((allPositions(:,2) < 0.5 ),:) = [];
        shuffledPositions = allPositions(randperm(size(allPositions,1)), :);
        shuffledPositions = shuffledPositions(randperm(size(shuffledPositions,1)), :);
        for i = 2:length(gameState.players)-1
            if i ~= thruplayeridx
                gameState.players(i).pos = shuffledPositions(i,:);
            end
        end
        for idx = 1:8
            gameState.players(idx).vel = [0,0];
            if idx ~= thruplayeridx
                gameState.players(idx).dir = 0.5*pi;
            end
        end

    elseif (gameState.ball.position(2) > 4.3 && gameState.ball.position(2) <=6) && gameState.ball.position(1) <= 0 && advteam == 1
        gameState.ball.position = [0 6];
        thruplayeridx = randsample([5 6 7], 1);
        gameState.players(thruplayeridx).pos = [gameState.ball.position(1)-0.45*cosd(45) gameState.ball.position(2)+0.45*sind(45)];
        
        allPositions = zeros(100,100, 2);
        for i = 1:100
            for j = 1:100
                allPositions(i,j,:) = [i*0.060, j*0.08];
            end
        end
        allPositions = reshape(allPositions, [], 2);
        allPositions((allPositions(:,1) > 2 ),:) = [];
        allPositions((allPositions(:,1) < 0.5 ),:) = [];
        allPositions((allPositions(:,2) > 5.5 ),:) = [];
        allPositions((allPositions(:,2) < 0.5 ),:) = [];
        shuffledPositions = allPositions(randperm(size(allPositions,1)), :);
        shuffledPositions = shuffledPositions(randperm(size(shuffledPositions,1)), :);
        for i = 2:length(gameState.players)-1
            if i ~= thruplayeridx
                gameState.players(i).pos = shuffledPositions(i,:);
            end
        end        
        for idx = 1:8
            gameState.players(idx).vel = [0,0];
            if idx ~= thruplayeridx
                gameState.players(idx).dir = -0.5*pi;
            end 
        end







    elseif (gameState.ball.position(2) > 0 && gameState.ball.position(2) <=1.7) && gameState.ball.position(1) >= 9 && advteam == 0
        gameState.ball.position = [9 0];
        thruplayeridx = randsample([2 4 3], 1);
        gameState.players(thruplayeridx).pos = [gameState.ball.position(1)+0.45*cosd(45) gameState.ball.position(2)-0.45*sind(45)];
        
        allPositions = zeros(100,100, 2);
        for i = 1:100
            for j = 1:100
                allPositions(i,j,:) = [i*0.0850, j*0.08];
            end
        end
        allPositions = reshape(allPositions, [], 2);
        allPositions((allPositions(:,1) > 9 ),:) = [];
        allPositions((allPositions(:,1) < 7 ),:) = [];
        allPositions((allPositions(:,2) > 5.5 ),:) = [];
        allPositions((allPositions(:,2) < 0.5 ),:) = [];
        shuffledPositions = allPositions(randperm(size(allPositions,1)), :);
        shuffledPositions = shuffledPositions(randperm(size(shuffledPositions,1)), :);
        for i = 2:length(gameState.players)-1
            if i ~= thruplayeridx
                gameState.players(i).pos = shuffledPositions(i,:);
            end
        end        
        for idx = 1:8
            gameState.players(idx).vel = [0,0];
            if idx ~= thruplayeridx
                gameState.players(idx).dir = 0.5*pi;
            end 
        end

    elseif (gameState.ball.position(2) > 4.3 && gameState.ball.position(2) <=6) && gameState.ball.position(1) >= 9 && advteam == 0
        gameState.ball.position = [9 6];
        thruplayeridx = randsample([2 4 3], 1);
        gameState.players(thruplayeridx).pos = [gameState.ball.position(1)+0.45*cosd(45) gameState.ball.position(2)+0.45*sind(45)];
        allPositions = zeros(100,100, 2);
        for i = 1:100
            for j = 1:100
                allPositions(i,j,:) = [i*0.0850, j*0.08];
            end
        end
        allPositions = reshape(allPositions, [], 2);
        allPositions((allPositions(:,1) > 9 ),:) = [];
        allPositions((allPositions(:,1) < 7 ),:) = [];
        allPositions((allPositions(:,2) > 5.5 ),:) = [];
        allPositions((allPositions(:,2) < 0.5 ),:) = [];
        shuffledPositions = allPositions(randperm(size(allPositions,1)), :);
        shuffledPositions = shuffledPositions(randperm(size(shuffledPositions,1)), :);
        for i = 2:length(gameState.players)-1
            if i ~= thruplayeridx
                gameState.players(i).pos = shuffledPositions(i,:);
            end
        end               
        for idx = 1:8
            gameState.players(idx).vel = [0,0];
            if idx ~= thruplayeridx
                gameState.players(idx).dir = -0.5*pi;
            end 
        end
    end
    
end