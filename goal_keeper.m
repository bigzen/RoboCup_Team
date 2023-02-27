function [desire_position, action] = attacker(player0, player1, player2, player3, player4, player5, player6, player7, ball)
%% input = ball, players (which player0 is itself, player 1~3 are teamates and player4~7 are opponents)

%% initialise desire position and action
desire_position = player0.position;
action = 'donothing';

%% determind goal positions
if player0.team == 'A'
    ownGoalPosition = [0 3];
    goalPosition = [9 3];
else
    ownGoalPosition = [9 3];
    goalPosition = [0 3];
end

distToBall = norm(ball.position - player0.position);       %% Distance to ball
distToGoal = norm(player0.position - goalPosition);         %% Distance to goal
ballDistToOwnGoal = norm(ball.position - ownGoalPosition);          %%Distance between ball and own goal

if ballDistToOwnGoal < 3
    if distToBall < 0.3
        action = 'defend_kick'
    else
    theta = acos(abs(ball.position(2) - ownGoalPosition(2)), ballDistToOwnGoal);
    desire_position = ownGoalPosition + [ballDistToOwnGoal*cos(theta)/8 ballDistToOwnGoal*sin(theta)/8];
    action = 'gotopose';
    end
else
    desire_position = ownGoalPosition;
    action = 'gotopose';
end

end