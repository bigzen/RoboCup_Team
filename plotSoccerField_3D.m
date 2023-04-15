function plotSoccerField_3D(gameState)
    hold on;
    
    title("Robot Soccer Simulation "+ num2str(gameState.score.a)+" - "+ num2str(gameState.score.b));

    % Draw boundary
    boundaryLength = 11;
    boundaryWidth = 8;

    rectangle('Position', [-1, -1, boundaryLength, boundaryWidth], 'FaceColor',[0.1 0.5 0.1], 'EdgeColor', 'w');
    %rectangle('Position', [-1, -1, boundaryLength, boundaryWidth], 'LineWidth', 0.125, 'EdgeColor', 'w');
    %rectangle('Position', [-1, -1, boundaryLength, boundaryWidth], 'LineWidth', 0.125, 'LineStyle', '--', 'EdgeColor', 'w');
    
    % Define field dimensions
    fieldLength = 9;
    fieldWidth = 6;
    fieldHeight = 5;
    
    % Draw field
    rectangle('Position', [0, 0, fieldLength, fieldWidth], 'FaceColor',[0.1 0.5 0.1], 'EdgeColor', 'w');
    rectangle('Position', [0, 0, fieldLength, fieldWidth], 'LineWidth', 0.125, 'EdgeColor', 'w');
    rectangle('Position', [0, 0, fieldLength, fieldWidth], 'LineWidth', 0.125, 'LineStyle', '--', 'EdgeColor', 'w');
    
    % Draw penalty areas

    rectangle('Position', [0 0.5 2 5], 'FaceColor', [0.1 0.5 0.1], 'EdgeColor', 'w');
    rectangle('Position', [7 0.5 2 5], 'FaceColor', [0.1 0.5 0.1], 'EdgeColor', 'w');
    

    % Draw goal area

    rectangle('Position', [0 1.5 1 3], 'FaceColor', [0.1 0.5 0.1], 'EdgeColor', 'w');
    rectangle('Position', [8 1.5 1 3], 'FaceColor', [0.1 0.5 0.1], 'EdgeColor', 'w');
    
    rectangle('Position', [-0.6 1.7 0.6 2.6], 'FaceColor', [0.1 0.5 0.1], 'EdgeColor', 'w');
    rectangle('Position', [9 1.7 0.6 2.6], 'FaceColor', [0.1 0.5 0.1], 'EdgeColor', 'w');
    
    stldemo(1,9)
    stldemo(-1,0)
    % Draw halfway line
    line([4.5 4.5],[0 6],[0, 0], 'LineWidth', 0.125, 'Color', 'w');

    % Center circle
    viscircles([4.5,3],0.75,'Color','white','LineWidth',0.125);

    % Penalty kick position
    viscircles([7.5 3],0.075,'Color','white','LineWidth',0.125);
    viscircles([1.5 3],0.075,'Color','white','LineWidth',0.125);
    % Kickoff position
    viscircles([4.5 3],0.075,'Color','white','LineWidth',0.125);

    %% plot players
    r = 0.31;
    color = ['r','b'];
    players = gameState.players;
    for idx = 1:8
        %[players(idx).pos(1)-r, players(idx).pos(2)-r];
        [x1 y1 z1]=sphere; 
        a=[players(idx).pos(1) players(idx).pos(2) r r];
        surf(x1*a(1,4)+a(1,1),y1*a(1,4)+a(1,2),z1*a(1,4)+a(1,3),'FaceColor',color(players(idx).team+1),'EdgeColor','none');
        
        if norm(players(idx).vel)>0
            dir = players(idx).vel/norm(players(idx).vel);
            plot([players(idx).pos(1),players(idx).pos(1)+dir(1)*0.31],[players(idx).pos(2), players(idx).pos(2)+dir(2)*0.31],'LineWidth', 0.3,'Color','white');
        end
    end
    
    %% plot ball
    %r = 0.143;
    %pos = gameState.ball.position;
    [x1 y1 z1]=sphere; 
    pos = gameState.ball.position;
    a=[pos(1) pos(2) 0.143 0.143];
    surf(x1*a(1,4)+a(1,1),y1*a(1,4)+a(1,2),z1*a(1,4)+a(1,3),'FaceColor','w','EdgeColor','none');

    % Set view and axis properties
    view(30, 30);
    axis equal;
    axis([-2 boundaryLength -2 boundaryWidth -fieldHeight/2 fieldHeight/2]);
    axis off;

    hold off;
end