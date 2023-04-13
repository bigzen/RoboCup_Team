classdef  behavior2
   
    properties
        Team = 0;
        targetGoal = [0,0;0,0];
        threshold = 0.45;
        %probabfn = zeros(8,5)
        dt=0.15
    end

    methods
        function setteam(team)
            % assigns curret team and target goal position to class object
            load("robotSoccerParam.mat",'goalPosts');
            behavior2.Team = team;
            if behavior2.Team==1
                behavior2.targetGoal = [goalPosts(1,1), goalPosts(1,2);goalPosts(2,1),goalPosts(2,2)];   %needs to be updated
            else
                behavior2.targetGoal = [goalPosts(3,1), goalPosts(3,2),goalPosts(4,1),goalPosts(4,2)];   
            end
        end

        % function probabilitymap(gameState)
        %     load("robotSoccerParam.mat",'player_accel_max');
        %     probmap = struct('id',[], 'coeficients', []);
        %     theta = 36;
        %     theta_rad = theta*pi/180;
        %     for id= 1:8
        %         probmap(id).id = id;
        %         x_arr = [];
        %         y_arr = [];
        %         for j=1:10
        %             x = gameState.players(id).pos(1) + gameState.players(id).vel(1)*behavior2.dt + 0.5*(behavior2.dt^2) * player_accel_max * cos(j*theta_rad) ;
        %             x_arr = [x_arr x];
        %             y = gameState.players(id).pos(2) + gameState.players(id).vel(2)*behavior2.dt + 0.5*(behavior2.dt^2) * player_accel_max * sin(j*theta_rad) ;  
        %             y_arr = [y_arr y];
        %         end
        %         xy = [x_arr; y_arr];
        %         probmap(id).coeficients= EllipseFitByTaubin(xy);
        %         %probmat = reshape(cell2mat(probcell(2,:)),[5,8])';    
        %      end
        %      probcell1 = struct2cell(probmap);
        %      behavior2.probabfn  = cell2mat(probcell1(2,:))';
        % end
        %function [a,b] = constOptim(Objfn, const)
        %end
        function [ball_speed,accel] = goalKeeper(ball,player,id)
            load("robotSoccerParam.mat",'player_speed_max');
            load("robotSoccerParam.mat",'player_accel_max');
            currVel = player(id).vel;
            playerPos = player(id).pos;
            ball_pos = ball.position;
            distance = sqrt(sum((playerPos-ball_pos).^2));
            accel = [0,0];
            ball_speed = [0,0];
            if distance(0) > behavior2.threshold
                %move goal keeper position
                goalCent = mean(behavior2.targetGoal,2);
                coeff = [[1; 1]  ball_pos(:)]\goalCent(:);
                %goalkeeper-y
                y_lim = [1.5,4.5];
                intercept = coeff(2)*playerPos(1)+coeff(1);
                if abs(intercept-playerPos(2))<0.1
                    if norm(currVel)~=0
                        accel = -currVel/norm(currVel);
                    end
                    return;
                end
                acc = 2*((intercept(2)-playerPos(2))-currVel(2)*(behavior2.dt))/behavior2.dt^2;%required accel to reach intercept
                velf = currVel(2)+acc*behavior2.dt;
                velf = max(abs(velf),player_speed_max)*velf/abs(velf);
                if intercept-playerPos>0
                    vel_max = sqrt(2*player_accel_max*abs(y_lim(2)-intercept));
                    if abs(velf)>vel_max
                        accel = [0,(vel_max-currVel(2))/behavior2.dt];
                    else
                        if acc>0
                            accel = [0,min(acc,player_accel_max)];
                        else
                            accel = [0,max(acc,-player_accel_max)];
                        end
                    end
                else
                    vel_max = sqrt(2*player_accel_max*abs(y_lim(1)-intercept));
                    if abs(velf)>vel_max
                        accel = [0,(-vel_max-currVel(2))/behavior2.dt];
                    else
                        if acc>0
                            accel = [0,min(acc,player_accel_max)];
                        else
                            accel = [0,max(acc,-player_accel_max)];
                        end
                    end
                end
            else 
                %kick
                if behavior2.Team == 1
                    own_team = [2,3,4];
                    opponent = 9-own_team;
                else
                    own_team = [5,6,7];
                    opponent = 9-own_team;
                end
                %opponentProb = behavior2.probabfn(opponent);
                own_pos = player(own_team).pos;
                [~,dist] = sort(sum((own_pos-playerPos).^2,2));
                for i = 1:3
                    target = player(dist(i)).pos;
                    dis=10;
                    for j=1:length(opponent)
                        dis = min(dis,distancefp(playerPos,target,player(opponent(j)).pos));
                    end
                    if dis<behavior2.threshold
                        %if no soln straight max kick
                        if ~pass && i==3
                            dir = [-1^(behavior2.Team+1),0];
                            ball_speed = ball_speed_max*dir;
                            accel = [0,0];
                        end
                        continue
                    else
                        dir = (target-playerPos)/norm(target-playerPos);
                        ball_speed = ball_speed_max*dir;
                        accel = [0,0];
                    end
                    %if exists and reachable calc kick speed, non reachable kick max break else continue
                end
            end
        end
        function d = distancefp(pf, pt, dp)
            numerator = abs((pf(1) - pt(1)) * (pt(2) - dp(2)) - (pt(1) - dp(1)) * (pf(2) - pt(2)));
            denominator = sqrt((pf(1) - pt(1)) ^ 2 + (pf(2) - pt(2)) ^ 2);
            d = numerator/denominator;
        end
        function [id, ball_speed, acceleration] = othPlayers(ball, player)
            load("robotSoccerParam.mat",'ball_speed_max');
            load("robotSoccerParam.mat",'player_speed_max');
            load("robotSoccerParam.mat",'player_accel_max');
            ballKick_max = 1.2;
            if behavior2.Team == 1
                own_team = [2,3,4];
                opponent = [5,6,7,8];
            else
                own_team = [5,6,7];
                opponent = [1,2,3,4];
            end
            own_pos = player(own_team).pos;
            [dist1,idx1] = sort(sqrt(sum((own_pos-ball.position).^2,2)));
            opp_pos = player(opponent).pos;
            [dist2,idx2] = sort(sqrt(sum((opp_pos-ball.position).^2,2)));
            own_team = [own_team,8^(behavior2.Team-1)];
            if dist1(1)<=behavior2.threshold
                teamPosession = behavior2.Team;
                inPosession = own_team(idx1(1));
            elseif dist2(1)<=behavior2.threshold
                teamPosession = 3-behavior2.Team;
                inPosession = opponent(idx2(1));
            else
                teamPosession = 0;
                inPosession = 0;
            end
            id = [];
            ball_speed = [];
            acceleration = [];
            if teamPosession==behavior2.Team
                %own team play dribble pass or get in pos
                for i=1:3
                    if own_team(i)==inPosession
                        goalCent = mean(behavior2.targetGoal,2);
                        %shoot
                        if sqrt(sum((goalCent+[0,0.6*(-1)^(behaviour2.Team+1)]-ball.position).^2,2))<ballKick_max
                            dis=10;
                            for j=1:length(opponent)
                                dis = min(dis,distancefp(goalCent,ball.position,player(opponent(j)).pos));
                            end
                            if dis<behavior2.threshold
                                %if no soln straight max kick
                                for j = 1:3
                                    kick=0;
                                    if kick==1
                                        break
                                    end
                                    if j==i
                                        continue
                                    end
                                    dis=10;
                                    for j=1:length(opponent)
                                        dis = min(dis,distancefp(player(own_team(j)).pos,ball.position,player(opponent(j)).pos));
                                    end
                                    if dis<behavior2.threshold
                                        continue
                                    else
                                        dir = (player(own_team(j)).pos-ball.position)/norm(player(own_team(j)).pos-ball.position);
                                        kick = ball_speed_max*dir;
                                        acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                                        accel = player_accel_max*acdir/norm(acdir);
                                        id = [id, own_team(i)];
                                        ball_speed = [ball_speed, kick];
                                        acceleration = [acceleration, accel];
                                        kick=1;
                                    end
                                end
                                if kick==0
                                    dir = [-1^(behavior2.Team+1),0];
                                    kick = ball_speed_max*dir/3;
                                    acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                                    accel = player_accel_max*acdir/norm(acdir);
                                    id = [id, own_team(i)];
                                    ball_speed = [ball_speed, kick];
                                    acceleration = [acceleration, accel];
                                end
                            else
                                dir = (goalCent-ball.position)/norm(goalCent-ball.position);
                                kick = ball_speed_max*dir;
                                accel = player_accel_max*dir;
                                id = [id,own_team(i)];
                                ball_speed = [ball_speed, kick];
                                acceleration = [acceleration, accel];
                            end
                        else 
                            kick=0;
                            %pass
                            for j = 1:3
                                if j==i
                                    continue
                                end
                                dis=10;
                                for j=1:length(opponent)
                                    dis = min(dis,distancefp(player(own_team(j)).pos,ball.position,player(opponent(j)).pos));
                                end
                                if dis<behavior2.threshold
                                    continue
                                else
                                    if kick==1
                                        break
                                    end
                                    dir = (player(own_team(j)).pos-ball.position)/norm(player(own_team(j)).pos-ball.position);
                                    kick = ball_speed_max*dir;
                                    acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                                    accel = player_accel_max*acdir/norm(acdir);
                                    id = [id, own_team(i)];
                                    ball_speed = [ball_speed, kick];
                                    acceleration = [acceleration, accel];
                                    kick=1;
                                end
                            end
                            %dribble
                            if kick==0
                                dir = [-1^(behavior2.Team+1),0];
                                kick = ball_speed_max*dir/3;
                                acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                                accel = player_accel_max*acdir/norm(acdir);
                                id = [id, own_team(i)];
                                ball_speed = [ball_speed, kick];
                                acceleration = [acceleration, accel];
                            end
                        end
                    else % players not posessing ball
                        if own_team(i)==idx1(2)
                            dir = ball.velocity;
                            accel = [dir(1)/abs(dir(1)),0];
                            kick=[0,0];
                            id = [id, own_team(i)];
                            ball_speed = [ball_speed, kick];
                            acceleration = [acceleration, accel];
                        else
                            ball_x = ball.position(1)-4.5;
                            ball_side = (3+ball_x/abs(ball_x))/2;
                            if ball_side==behavior2.Team
                                pos = player(own_team(i)).pos;
                                target = [9*(ball_side-1)+(-1)^(ball_side+1)*1.5, ball.position(2)];
                                dir = (target-pos)/norm(target-pos);
                                acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                                accel = player_accel_max*acdir/norm(acdir);
                                kick = [0,0];
                                id = [id, own_team(i)];
                                ball_speed = [ball_speed, kick];
                                acceleration = [acceleration, accel];
                            else
                                pos = player(own_team(i)).pos;
                                target = [4.5,ball.position(2)];
                                dir = (target-pos)/norm(target-pos);
                                acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                                accel = player_accel_max*acdir/norm(acdir);
                                kick = [0,0];
                                id = [id, own_team(i)];
                                ball_speed = [ball_speed, kick];
                                acceleration = [acceleration, accel];
                            end
                        end
                    end
                end
            else%if teamPosession==3-behavior2.Team
                for i=1:3
                    if own_team(i)==idx1(1)
                        target = ball.position;
                        pos = player(own_team(i)).pos;
                        dir = (target-pos)/norm(target-pos);
                        acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                        accel = player_accel_max*acdir/norm(acdir);
                        kick = [0,0];
                        id = [id, own_team(i)];
                        ball_speed = [ball_speed, kick];
                        acceleration = [acceleration, accel];
                    elseif own_team(i)==idx1(2)
                        ball_pos = ball.position;
                        block_play = player(opponent(idx2(2))).pos;
                        target = (ball_pos+block_play)/2;
                        pos = player(own_team(i)).pos;
                        dir = (target-pos)/norm(target-pos);
                        acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                        accel = player_accel_max*acdir/norm(acdir);
                        kick = [0,0];
                        id = [id, own_team(i)];
                        ball_speed = [ball_speed, kick];
                        acceleration = [acceleration, accel];
                    else
                        [~,idx] = sort(sqrt(sum((opp_pos-mean(behavior2.targetGoal,2)).^2,2)));
                        target=(ball.position+player(opponent(idx(end))).pos)/2;
                        pos = player(own_team(i)).pos;
                        dir = (target-pos)/norm(target-pos);
                        acdir = 2*player_speed_max*dir-player(own_team(i).vel);
                        accel = player_accel_max*acdir/norm(acdir);
                        kick = [0,0];
                        id = [id, own_team(i)];
                        ball_speed = [ball_speed, kick];
                        acceleration = [acceleration, accel];
                    end
                end
            % else
            %     for i=1:3
            %         if own_team(i)==idx1(1)
            %             target = ball.position;
            %             pos = player(own_team(i)).pos;
            %             dir = (target-pos)/norm(target-pos);
            %             acdir = 2*player_speed_max*dir-player(own_team(i).vel);
            %             accel = player_accel_max*acdir/norm(acdir);
            %             kick = [0,0];
            %             id = [id, own_team(i)];
            %             ball_speed = [ball_speed, kick];
            %             acceleration = [acceleration, accel];
            %         elseif own_team(i)==idx1(2)
            %             ball_pos = ball.position;
            %             block_play = player(opponent(idx2(2))).pos;
            %             target = (ball_pos+block_play)/2;
            %             pos = player(own_team(i)).pos;
            %             dir = (target-pos)/norm(target-pos);
            %             acdir = 2*player_speed_max*dir-player(own_team(i).vel);
            %             accel = player_accel_max*acdir/norm(acdir);
            %             kick = [0,0];
            %             id = [id, own_team(i)];
            %             ball_speed = [ball_speed, kick];
            %             acceleration = [acceleration, accel];
            %         else
            %             [~,idx] = sort(sqrt(sum((opp_pos-mean(behavior2.targetGoal,2)).^2,2)));
            %             target=(ball.position+player(opponent(idx(end))).pos)/2;
            %             pos = player(own_team(i)).pos;
            %             dir = (target-pos)/norm(target-pos);
            %             acdir = 2*player_speed_max*dir-player(own_team(i).vel);
            %             accel = player_accel_max*acdir/norm(acdir);
            %             kick = [0,0];
            %             id = [id, own_team(i)];
            %             ball_speed = [ball_speed, kick];
            %             acceleration = [acceleration, accel];
            %         end
            %     end
            end
        end
        function [x,y] = nearestPoint(line,point)
            slope = atan(line(1))+pi/2;
            cons = point(2)-point(1)*slope;
            x = (line(2)-cons)/(slope-line(1));
            y = slope*x+cons;
        end
    end
end