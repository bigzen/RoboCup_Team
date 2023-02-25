%% Ballpossession
if gameState.possession == 0
if gameState.possession == 0
   for idx = 1:numRobots %calculate the distance
    ballDists(idx) = norm(sensors(idx).pose(1:2) - ballpose');
    if behavior(idx).role == Role.Goalkeeper
        ballDists(idx) = ballDists(idx)/2;
    end
   end
   % Find the robot index of the current and latest possessions
  robotIdx = findPossession;
if robotIdx > 0
    lastPossession = robotIdx;
end
% Unpack the robot commands
action = commands(lastPossession).action;
ballVel = commands(lastPossession).ballVelocity;
robotPose = sensors(lastPossession).pose;
end
end

% If the robot that previously possessed the ball is still holding it, keep the same index
function rIdx = findPossession
    if gameState.possession > 0 && commands(gameState.possession).action == RobotAction.HoldBall
    else
[~,inds] = sort(ballDists);
rIdx = 0;
for idx = 1:numRobots
    if (commands(inds(idx)).action == RobotAction.HoldBall) && ....
       (ballDists(inds(idx)) <= ballThresh)
        rIdx = inds(idx);
        return;
    end
end
    end
end