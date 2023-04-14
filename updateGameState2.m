function gameState = updateGameState2(gameState)
%UPDATEGAMESTATE Summary of this function goes here
%   Detailed explanation goes here
load("robotSoccerParam.mat",'player_speed_max');
%% call the plyer action function and store the variables
update = struct('id',[], ...
                 'ball', [],...
                 'player', []);
for team=1:2
    behav = behavior2;
    behav = behav.setteam(team);
    id = 8^(team-1);
    [ball_speed, player_acceleration] = behav.goalKeeper(gameState.ball,gameState.players,id);
    player_acceleration(isnan(player_acceleration))=0;
    update(id).id=id;
    update(id).ball=ball_speed;
    update(id).player=player_acceleration;
    [idx, ball_speed, player_acceleration] = behav.othPlayers(gameState.ball,gameState.players);
    player_acceleration(isnan(player_acceleration))=0;
    for i = 1:length(idx)
        update(idx(i)).id=idx(i);
        update(idx(i)).ball=ball_speed(i,:);
        update(idx(i)).player=player_acceleration(i,:);
    end
end

%% calculate new player position and speed update the game state
dt=0.02;
for id = 1:8
    %player position
    player_dis2cov_x = gameState.players(id).vel(1)*dt + (0.5 * update(id).player(1)*(dt^2));
    player_dis2cov_y = gameState.players(id).vel(2)*dt + (0.5 *update(id).player(2)*(dt^2));
    if norm([player_dis2cov_x,player_dis2cov_y])> player_speed_max * dt
        player_dis2cov_x = player_dis2cov_x * (player_speed_max * dt)/norm([player_dis2cov_x,player_dis2cov_y]);
        player_dis2cov_y = player_dis2cov_y * (player_speed_max * dt)/norm([player_dis2cov_x,player_dis2cov_y]);
    end
    player_x_new = gameState.players(id).pos(1) + player_dis2cov_x;
    player_y_new = gameState.players(id).pos(2) + player_dis2cov_y;
    gameState.players(id).pos = [player_x_new,player_y_new];
    
    
    %player velocity
    player_new_speed_x = gameState.players(id).vel(1) + update(id).player(1)*dt;
    player_new_speed_y = gameState.players(id).vel(2) + update(id).player(2)*dt;
    player_new_dir = atan2(player_dis2cov_y,player_dis2cov_x);
    gameState.players(id).vel = [player_new_speed_x,player_new_speed_y];
    if norm(gameState.players(id).vel) > player_speed_max 
        gameState.players(id).vel = (player_speed_max * gameState.players(id).vel) / norm(gameState.players(id).vel);
    end
    gameState.players(id).dir = player_new_dir;
        
    

end
    %if norm(player_speed_next) > max_speed
   %     player_speed_next = max_speed * player_speed_next / norm(player_speed_next);
   %end
%% calculate ball position and decide who kickedlast 

lastKick = [];
for id=1:8
    if update(id).ball(1)~=0 || update(id).ball(2)~=0
        lastKick = [lastKick, id];
    end
end
ball_decay=0.94;
if length(lastKick)==1
    for id = 1:8
        gameState.players(id).lastKick = -1;
    end
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
    if newVel~=[0 0]
    endVel = newVel - ball_decay*newVel/norm(newVel)*dt;
    if endVel/norm(endVel)==newVel/norm(newVel)
        gameState.ball.position = gameState.ball.position + newVel*dt - ball_decay*newVel/norm(newVel)*(dt^2)/2;
        gameState.ball.velocity = endVel;
    else
        dt_new = norm(newVel)/(ball_decay);
        gameState.ball.position = gameState.ball.position + newVel*dt_new - ball_decay*newVel/norm(newVel)*(dt_new^2)/2;
        gameState.ball.velocity = [0,0];
    end
    end
else
    for id = 1:8
        gameState.players(id).lastKick = -1;
    end
    n= length(lastKick);
    prob = randn(n,1);
    if sum(prob>0)==0
        prob = -prob;
    end
    prob = (prob>0).*prob;
    prob = prob/norm(prob);
    newVel = [0,0];
    for id=1:length(lastKick)
        newVel = newVel+update(id).ball * prob(id);
    end
    endVel=[0 0];
    if norm(newVel)~=0
        tn=norm(newVel)/ball_decay;
        if tn>=dt
            gameState.ball.position = gameState.ball.position + newVel*dt - ball_decay*newVel/norm(newVel)*(dt^2)/2;
            gameState.ball.velocity = endVel;
        else
            gameState.ball.position = gameState.ball.position + newVel*tn - ball_decay*newVel/norm(newVel)*(tn^2)/2;
            gameState.ball.velocity = [0,0];
        end
    end
    [~,id]=max(prob);
    gameState.players(lastKick(id)).lastKick = 1;
end
%% update time
gameState.time=gameState.time+1;
end

