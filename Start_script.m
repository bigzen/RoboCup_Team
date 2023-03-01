%Game on
robotSoccerParams1;
%% Init Game State
state = State.KickOff;
players = getPlayerInit(player,robotColors,initialPoses,initRoles);
ball = getballInit(ball,initBallPos);
score = struct('a',0,'b',0);
time = 1;
gameState = GameState(state, players, ball, score, time);
gameState.players(4).pos = [4.5-0.45*cosd(45),3-0.45*sind(45)];
%% Loop the game
while(gameState.time<600)
    visualizeGameState(gameState)
    %flag = checkFoul(gameState.ball.pos,fieldLimitsX,fieldLimitsY);
%     if flag~=0
%         gameState = initFoulState(gameState,flag);
%     else
%         gameState = updateGameState(gameState);
%     end
    gameState = updateGameState(gameState);
end