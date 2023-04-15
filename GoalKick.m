function gameState = GoalKick(gameState,advteam) 
  if advteam == 0
      allPositions = zeros(100,100, 2);
      for i = 1:100
          for j = 1:100
              allPositions(i,j,:) = [i*0.060, j*0.08];
          end
      end
      allPositions = reshape(allPositions, [], 2);
      allPositions((allPositions(:,1) < 2.8 ),:) = [];
      allPositions((allPositions(:,1) > 6.5 ),:) = [];
      allPositions((allPositions(:,2) > 5.1 ),:) = [];
      allPositions((allPositions(:,2) < 0.1 ),:) = [] ;
      shuffledPositions = allPositions(randperm(size(allPositions,1)), :);
      shuffledPositions = shuffledPositions(randperm(size(shuffledPositions,1)), :); 
      for i = 1:length(gameState.players)
          if i ~= 1 && i ~= 8
              gameState.players(i).pos = shuffledPositions(i,:);
          end
      end
      gameState.ball.position = [0.5 3];
      gameState.players(1).pos = [0 3];
      gameState.players(5).pos = [8.5,3];
      gameState.players(1).vel = [0,0];
      for idx = 2:8
          gameState.players(idx).vel = [0,0];
          gameState.players(idx).dir = pi;
      end

  elseif advteam==1
      allPositions = zeros(100,100, 2);
      for i = 1:100
          for j = 1:100
              allPositions(i,j,:) = [i*0.060, j*0.08];
          end
      end
      allPositions = reshape(allPositions, [], 2);
      allPositions((allPositions(:,1) < 2.5 ),:) = [];
      allPositions((allPositions(:,1) > 6.8 ),:) = [];
      allPositions((allPositions(:,2) > 5.8 ),:) = [];
      allPositions((allPositions(:,2) < 0.08 ),:) = [];
      shuffledPositions = allPositions(randperm(size(allPositions,1)), :);
      shuffledPositions = shuffledPositions(randperm(size(shuffledPositions,1)), :);
      
      for i = 1:length(gameState.players)
          if i ~= 1 && i ~= 8
              gameState.players(i).pos = shuffledPositions(i,:);
          end
      end
      gameState.ball.position = [8.5 3];
      gameState.players(1).pos = [0.5,3];
      gameState.players(5).pos = [9 3];
      gameState.players(5).vel = [0,0];
      for idx = 1:7
          gameState.players(idx).vel = [0,0];
          gameState.players(idx).dir = 0;
      end
  end