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

%distToBall = norm(ball.position - player0.position);       %% Distance to ball
distToGoal = norm(player0.position - goalPosition);         %% Distance to goal
ballDistToOwnGoal = norm(ball.position - ownGoalPosition);          %%Distance between ball and own goa

if player0.last_kick == 1       %% if ball held
    if distToGoal < 4
        action = 'shoot';
    else
        action = 'dribble';
    end
elseif player1.last_kick == 1 || player2.last_kick == 1 || player3.last_kick == 1       %% if ball is held by teamates
    action = 'donothing';
else
    desire_position = ball.position;        %% go to ball
    action = 'gotopose';
end

end