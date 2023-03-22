%Game on
load('robotSoccerParam','fieldCenter')
%% Init Game State
state = State.KickOff;
players = getPlayerInit();
ball = struct('position', fieldCenter, ...
              'prev_pos', fieldCenter, ...
              'velocity', [0, 0], ...
              'direction', 0);
score = struct('a',0,'b',0);
time = 1;
gameState = GameState(state, players, ball, score, time);
gameState.players(4).pos = [4.5-0.45*cosd(45),3-0.45*sind(45)];
%% Loop the game
while(gameState.time<600)
    visualizeGameState(gameState)
    %disp('test')
    flag = checkFoul(gameState.ball.position, gameState.players);
    %disp('test_2')
    if flag~=0
        %disp('here')
        gameState = initFoulState(gameState,flag);
    else
        gameState = updateGameState(gameState);
        gameState.ball.position
    end
    %disp('test_3')
end