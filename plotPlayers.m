function plotPlayers(players)
    %PLOTPLAYERS Summary of this function goes here
    %   Detailed explanation goes here
    r = 0.2;
    hold on
    for idx = 1:8
        rectangle('Position',[players(idx).pos(1)-r, players(idx).pos(2)-r, 2*r, 2*r],'Curvature', [1,1], 'FaceColor',players(idx).color)
    end
    hold off

end

