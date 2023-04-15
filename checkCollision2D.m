
function collision = checkCollision2D(pos1, radius1, pos2, radius2)
distance = norm(pos1 - pos2);
    if distance <= (radius1 + radius2)
        collision = true;
    else
        collision = false;
    end
    
figure('Name', '2D Soccer Simulation');
ax = axes('XLim', [-50 50], 'YLim', [-30 30]);
xlabel('X-axis');
ylabel('Y-axis');
grid on;
hold on;

rectangle('Position', [-50, -30, 100, 60], 'LineWidth', 2);
line([-50, 50], [0, 0], 'LineWidth', 2);

ball_radius = 1;
player_radius = 0.5;

ball = rectangle('Position', [-ball_radius, -ball_radius, 2*ball_radius, 2*ball_radius], 'Curvature', [1 1], 'FaceColor', 'y');
num_players = 5;
for i = 1:num_players
    players(i) = rectangle('Position', [-player_radius, -player_radius, 2*player_radius, 2*player_radius], 'Curvature', [1 1], 'FaceColor', 'r');
end

ball_velocity = [2, 1];
player_velocities = randi([-1, 1], num_players, 2);

num_iterations = 100;
for k = 1:num_iterations
    ball_pos = [ball.Position(1) + ball_radius, ball.Position(2) + ball_radius];
    new_ball_pos = ball_pos + ball_velocity;
    ball.Position(1:2) = new_ball_pos - ball_radius;
    
    for i = 1:num_players
        player_pos = [players(i).Position(1) + player_radius, players(i).Position(2) + player_radius];
        new_player_pos = player_pos + player_velocities(i, :);
        
        if checkCollision2D(new_player_pos, player_radius, new_ball_pos, ball_radius)
            ball_velocity = ball_velocity + player_velocities(i, :);
        else
            collision = false;
            for j = 1:num_players
                if j ~= i
                    other_player_pos = [players(j).Position(1) + player_radius, players(j).Position(2) + player_radius];
                    if checkCollision2D(new_player_pos, player_radius, other_player_pos, player_radius)
                        collision = true;
                        break;
                    end
                end
            end

            if ~collision
                players(i).Position(1:2) = new_player_pos - player_radius;
            end
        end
    end

    drawnow;
end
