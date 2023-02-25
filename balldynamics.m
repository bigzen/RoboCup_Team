%%Start the game and initialise the balldata
coder.extrinsic('randn'); % Lets us use MATLAB's interpreted RNG
setBallState(initBallPos,0,0);

%%Outofbound
if gameState.state ~= GameState.InPlay
 %If a goal is scored, increment the score
    if gameState.state == GameState.GoalScored
      ballPose = initBallPos;
      teamIdx = behavior(lastPossession).team;
      gameState.score(teamIdx) = gameState.score(teamIdx) + 1;
    % Else, place the ball back in bounds
    else
    ballPose = gameRestart();
    end
   setBallState(ballPose,0,robotPose(3));

%%inbounds
else
    while(0)
    randNum = randn(2,1);
    gameState.state = getGameState;
    %ballHeld
    if robotIdx > 0
        gameState.possession = robotIdx;
        ballPose = [robotPose(1) robotPose(2)] + (robotRadius+ballThresh)*[cos(robotPose(3)) sin(robotPose(3))];
    elseif action == RobotAction.KickBall
        setBallState(ballPose,ballVel + ballVelNoise*randNum(1),robotPose(3) + ballAngleNoise*randNum(2));
        gameState.possession = 0;
    else 
    %BallFree
    ballpose = balldata(ballpose);
    ballvelocity = balldata(ballvelocity) - ball_accel_max* t;
    end
    end
end





%%Function
function [Flag_num] = getGamestate(ballposition)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if ballposition(1) < fieldlimitX(1) || ballposition(1)>fieldlimitX(2)|| ballposition(2) < fieldlimitY(1) || ballposition(2) > fieldlimitY(2)
   if ballposition(2) < GoalareaL(2,2) && ballposition(2) > GoalareaL(1,2)||ballposition(2) < GoalareaR(2,2) && ballposition(2) > GoalareaR(1,2)
       Flag_num = GameFlag.goalscore;
   elseif ballposition(2) < ExtraGoalareaL(2,2) && ballposition(2) > ExtraGoalareaL(1,2)||ballposition(2) < ExtraGoalareaR(2,2) && ballposition(2) > ExtraGoalareaR(1,2)
       Flag_num = GameFlag.coener;
   else
       Flag_num = GameFlag.outofplay;
   end
else
    Flag_num = GameFlag.normalplay;

end
end

function newPose = gameRestart()
newPose = max(fieldLimitsX(1)+outOfBoundsDist,min(ballPose(1),fieldLimitsX(2)-outOfBoundsDist)), max( fieldLimitsY(1)+outOfBoundsDist , min(ballPose(2),fieldLimitsY(2)-outOfBoundsDist));
end

function [ballpose,ballvelocity] = balldata(ballpose,theta,velocity)
ballpose = ballpose;
ballvelocity = [velocity*cos(theta),velocity*sin(theta)];
end

