classdef GameState
    properties
        % game state
        state
        % player
        players
        % ball
        ball
        % score
        score
        % game time
        time
    end

    methods
        function gameState = GameState(state, players, ball, score, time)
            %Provides initial Game state variable
            %   Detailed explanation goes here
            gameState.state = state;
            gameState.players = players;
            gameState.ball = ball;
            gameState.score = score;
            gameState.time = time;
        end
    end
end


