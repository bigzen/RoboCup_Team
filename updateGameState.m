function gameState = updateGameState(gameState)
%UPDATEGAMESTATE Summary of this function goes here
%   Detailed explanation goes here
%% call the plyer action function and store the variables
update = struct('id',[], ...
                 'ball', [],...
                 'player', []);
for id=1:8
    if gameState.players(id).role{1}(1)==0
        [ball_speed, player_acceleration] = goal_keeper(gameState.ball,gameState.players,id);
        update(id).id=id;
        update(id).ball=ball_speed;
        update(id).player=player_acceleration;
    elseif gameState.players(id).role{1}(1)==1
        [ball_speed, player_acceleration] = defender(gameState.ball,gameState.players,id);
        update(id).id=id;
        update(id).ball=ball_speed;
        update(id).player=player_acceleration;
    else
        [ball_speed, player_acceleration] = attacker(gameState.ball,gameState.players,id);
        update(id).id=id;
        update(id).ball=ball_speed;
        update(id).player=player_acceleration;
    end
end

%% calculate new player position and speed update the game state


%% calculate ball position and decide who kickedlast 
lastKick = [];
for id=1:8
    if update(id).ball~=[0,0]
        lastKick = [lastKick, id];
    end
end
dt=0.15;
ball_decay=0.94;
if length(lastKick)==1
    gameState.players(:).lastKick = -1;
    newVel = update(lastKick(1)).ball;
    endVel = newVel - ball_decay*newVel/norm(newVel)*dt;
    if endVel/norm(endVel)==newVel/norm(newVel)
        gameState.ball.position = gameState.ball.position + newVel*dt - ball_decay*newVel/norm(newVel)*(dt^2)/2;
        gameState.ball.velocity = endVel;
    else
        dt_new = norm(newVel)/(ball_decay);
        gameState.ball.position = gameState.ball.position + newVel*dt_new - ball_decay*newVel/norm(newVel)*(dt_new^2)/2;
        gameState.ball.velocity = [0,0];
    end
    gameState.players(lastKick(1)).lastKick = 1;
elseif isempty(lastKick)
    newVel = gameState.ball.velocity;
    endVel = newVel - ball_decay*newVel/norm(newVel)*dt;
    if endVel/norm(endVel)==newVel/norm(newVel)
        gameState.ball.position = gameState.ball.position + newVel*dt - ball_decay*newVel/norm(newVel)*(dt^2)/2;
        gameState.ball.velocity = endVel;
    else
        dt_new = norm(newVel)/(ball_decay);
        gameState.ball.position = gameState.ball.position + newVel*dt_new - ball_decay*newVel/norm(newVel)*(dt_new^2)/2;
        gameState.ball.velocity = [0,0];
    end
else
    gameState.players(:).lastKick = -1;
    n= length(lastKick);
    prob = randn(n,1);
    if sum(prob>0)==0
        prob = -prob;
    end
    prob = (prob>0).*prob;
    prob = prob/norm(prob);
    newVel = sum(update(lastKick).ball .* prob);
    endVel = newVel - ball_decay*newVel/norm(newVel)*dt;
    if endVel/norm(endVel)==newVel/norm(newVel)
        gameState.ball.position = gameState.ball.position + newVel*dt - ball_decay*newVel/norm(newVel)*(dt^2)/2;
        gameState.ball.velocity = endVel;
    else
        dt_new = norm(newVel)/(ball_decay);
        gameState.ball.position = gameState.ball.position + newVel*dt_new - ball_decay*newVel/norm(newVel)*(dt_new^2)/2;
        gameState.ball.velocity = [0,0];
    end
    [~,id]=max(prob);
    gameState.players(lastKick(id)).lastKick = 1;
end
%%
end

