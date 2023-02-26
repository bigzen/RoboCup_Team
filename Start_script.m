%Game on
%% Init Game State
state = State.KickOff;
players = getPlayersInit();
ball = struct('position', fieldCenter, ...
              'velocity', [0, 0], ...
              'direction', 0);
score = struct('a',0,'b',0);
time = 0;
gameState = GameState(state, players, ball, score, time);
%% Loop the game
while(gameState.time<600)
    
    gameState.time=gameState.time+1;
end