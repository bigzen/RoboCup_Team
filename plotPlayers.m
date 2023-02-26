function plotPlayers(time,players)
    %PLOTPLAYERS Summary of this function goes here
    %   Detailed explanation goes here
    r = 0.31;
    color = ['r','b'];
    hold on
    for idx = 1:8
        [players(idx).pos(1)-r, players(idx).pos(2)-r]
        rectangle('Position',[players(idx).pos(1)-r, players(idx).pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor',color(players(idx).team+1))
    end
    hold off
end

