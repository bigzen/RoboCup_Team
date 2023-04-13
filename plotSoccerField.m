function plotSoccerField(gameState)
    %function to plot soccer field
    %number to one
    %figure(gameState.time)
    hold on
    %% plot field
    % Title
    title("Robot Soccer Simulation "+ num2str(gameState.score.a)+" - "+ num2str(gameState.score.b));
    % color the field
    rectangle('Position', [-1 -1 11 8],'LineWidth', 0.125,'FaceColor',"#003518");
    % Draw outer boundary
    rectangle('Position', [0 0 9 6],'LineWidth', 0.125,'EdgeColor','white');
    % Center Line
    rectangle('Position', [0 0 4.5 6],'LineWidth', 0.125,'EdgeColor','white');
    % Center circle
    viscircles([4.5 3],0.75,'Color','white','LineWidth',0.125);
    % Penalty kick position
    viscircles([7.5 3],0.075,'Color','white','LineWidth',0.125);
    viscircles([1.5 3],0.075,'Color','white','LineWidth',0.125);
    % Kickoff position
    viscircles([4.5 3],0.075,'Color','white','LineWidth',0.125);
    % corner circle
    %viscircles([0 0],0.75,'Color','k');
    %viscircles([0 6],0.75,'Color','k');
    %viscircles([9 0],0.75,'Color','k');
    %viscircles([9 6],0.75,'Color','k');
    % the goal area
    rectangle('Position', [0 1.5 1 3],'LineWidth', 0.125,'EdgeColor','white');
    rectangle('Position', [8 1.5 1 3],'LineWidth', 0.125,'EdgeColor','white');
    % the penalty area
    rectangle('Position', [0 0.5 2 5],'LineWidth', 0.125,'EdgeColor','white');
    rectangle('Position', [7 0.5 2 5],'LineWidth', 0.125,'EdgeColor','white');
    % the penalty area
    rectangle('Position', [-0.6 1.7 0.6 2.6],'LineWidth', 0.125,'EdgeColor','white');
    rectangle('Position', [9 1.7 0.6 2.6],'LineWidth', 0.125,'EdgeColor','white');
    % Remove default labels and ticks
    xlabel('');
    ylabel('');
    yticks('');
    xticks('');
    % Crop to field dimensions
    axis equal
    xlim([-1 10]);
    ylim([-1 7]);

    %% plot players
    r = 0.31;
    color = ['r','b'];
    players = gameState.players;
    for idx = 1:8
        %[players(idx).pos(1)-r, players(idx).pos(2)-r];
        rectangle('Position',[players(idx).pos(1)-r, players(idx).pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor',color(players(idx).team+1))
        if norm(players(idx).vel)>0
            dir = players(idx).vel/norm(players(idx).vel);
            plot([players(idx).pos(1),players(idx).pos(1)+dir(1)*0.31],[players(idx).pos(2), players(idx).pos(2)+dir(2)*0.31],'LineWidth', 0.3,'Color','white');
        end
    end
    %% plot ball
    r = 0.143;
    pos = gameState.ball.position;
    rectangle('Position',[pos(1)-r, pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor','w')
    hold off

end