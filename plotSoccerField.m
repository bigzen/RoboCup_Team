% Script for plotting the Soccer field over the Robot Visualizer
%
% Copyright 2019 The MathWorks, Inc.
% Find the figure number to start plotting over
%obj = findobj('Tag','MultiRobotEnvironment'); currently setting figure
%number to one
figNum = 1;
figure(figNum);
hold on
% Title
title('Robot Soccer Simulation');
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
hold off