classdef  behavior2
   
    properties
        Team = 0;
        targetGoal = [0,0;0,0];
        threshold = 0.45;
        probabfn = zeros(8,5)
        dt=0.15
    end

    methods
        function setteam(team)
            % assigns curret team and target goal position to class object
            load("robotSoccerParam.mat",'goalPosts');
            behavior2.Team = team;
            if behavior2.Team==1
                behavior2.targetGoal = [goalPosts(1,1), goalPosts(1,2);goalPosts(2,1),goalPosts(2,2)];   %needs to be updated
                behavior2.OwnGoal = [goalPosts(3,1), goalPosts(3,2),goalPosts(4,1),goalPosts(4,2)];   

            else
                behavior2.targetGoal = [goalPosts(3,1), goalPosts(3,2),goalPosts(4,1),goalPosts(4,2)];   
                behavior2.OwnGoal = [goalPosts(1,1), goalPosts(1,2);goalPosts(2,1),goalPosts(2,2)];   %needs to be updated
            end
        end

        function probabilitymap(gameState)
            load("robotSoccerParam.mat",'player_accel_max');
            probmap = struct('id',[], 'coeficients', []);
            theta = 36;
            theta_rad = theta*pi/180;
            for id= 1:8
                probmap(id).id = id;
                x_arr = [];
                y_arr = [];
                for j=1:10
                    x = gameState.players(id).pos(1) + gameState.players(id).vel(1)*behavior2.dt + 0.5*(behavior2.dt^2) * player_accel_max * cos(j*theta_rad) ;
                    x_arr = [x_arr x];
                    y = gameState.players(id).pos(2) + gameState.players(id).vel(2)*behavior2.dt + 0.5*(behavior2.dt^2) * player_accel_max * sin(j*theta_rad) ;  
                    y_arr = [y_arr y];
                end
                xy = [x_arr; y_arr];
                probmap(id).coeficients= EllipseFitByTaubin(xy);
                %probmat = reshape(cell2mat(probcell(2,:)),[5,8])';    
             end
             probcell1 = struct2cell(probmap);
             behavior2.probabfn  = cell2mat(probcell1(2,:))';
        end
        function [a,b] = constOptim(Objfn, const)
        end
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
                    own_gk = [1];
                else
                    own_team = [5,6,7];
                    opponent = 9-own_team;
                    own_gk = [8];
                end
                opponentProb = behavior2.probabfn(opponent);
                own_pos = player(own_team).pos;
                [~,dist] = sort(sum((own_pos-playerPos).^2,2));
                for i = 1:3
                    receiverPos = own_pos(dist(i));
                    %write eqn = (a*(x-receiverPos(1) +
                    %%b*(y-receiverPos(2))/sqrt(a^2+b^2)
                    %eqn of oppn objective fn
                    %optimize
                    %if exists and reachable calc kick speed, non reachable kick max break else continue
                end
                %if no soln straight max kick
            end
        end
        
        function [id, ball_speed, acceleration] = othPlayers(ball, player)
            load("robotSoccerParam.mat",'ball_speed_max');
            load("robotSoccerParam.mat",'player_speed_max');
            load("robotSoccerParam.mat",'player_accel_max');
            if behavior2.Team == 1
                own_team = [2,3,4];
                opponent = 9-own_team;
            else
                own_team = [5,6,7];
                opponent = 9-own_team;
            end
            own_pos = player(own_team).pos;
            [dist1,idx1] = sort(sum((own_pos-ball.position).^2,2));
            opp_pos = player(opponent).pos;
            [dist2,idx2] = sort(sum((own_pos-ball.position).^2,2));
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
                %optim = %equation of the line
                %constfn = %line at goalpost1*line at goalpost2 < 0
                %constfn = %collate behavior2.probabfn(opponent,:) and constfn
                %a,b = constOptim(optim,constfn);
                %if a~=null
                 %   id = [id, ]
                  %  kickSpeed = ball_speed_max*[1/sqrt(1+a^2),(a^2)/sqrt(1+a^2)];
                   % accel = player_accel_max*[1/sqrt(1+a^2),(a^2)/sqrt(1+a^2)];
                %can score shoot
                %forward pass available pass
                %dir to goal un hindered dribble
                %back pass available
                %back dribble
               
            elseif teamPosession==3-behavior2.Team
                nearest = own_team(idx1(1));
                %move_to_ball
                intercept_pt = ball.position + ball.velocity*((ball_speed_max/norm(ball.velocity))*behaviour2.dt);
                player_int_disp = intercept_pt-player(nearest).pos;
                accel1 = player_accel_max * (player_int_disp/norm(player_int_disp));
                %nearest intercept ball get in position
                owp_other = own_team;
                owp_other(idx1(1))= [];
                %Second Player Movement
                %[dist3,idx3]= sort(sum((player(owp_other(1)).pos-ball.position).^2,2));
                duv1=(player(opponent(1)).pos-player(owp_other(1)).pos)/norm(player(opponent(1)).pos-player(owp_other(1)).pos);
                duv2=(player(opponent(2)).pos-player(owp_other(1)).pos)/norm(player(opponent(2)).pos-player(owp_other(1)).pos);
                duv3=(player(opponent(3)).pos-player(owp_other(1)).pos)/norm(player(opponent(3)).pos-player(owp_other(1)).pos);
                dbuv1=(ball.position-player(owp_other(1)).pos)/norm(intercept_pt-player(owp_other(1)).pos);
                p2_uv = (duv1 + duv2 + duv3 + dbuv1)/norm(duv1 + duv2 + duv3 + dbuv1);
                accel2 = player_accel_max*p2_uv;
                %Third Player Movement
                goalCent = mean(behavior2.OwnGoal,2);
                ball2goal_uv = (goalCent - ball.position)/norm(goalCent - ball.position);
                player2ogk_uv = (player(own_gk(1)).pos - player(owp_other(2)).pos))/norm(player(own_gk(1)).pos - player(owp_other(2)).pos));
                intof2pts = lineSegmentIntersect(ball2goal_uv,player2ogk_uv); %needs to be tested
                
                
                
            else
                %nearest goto ball get in position
                %others goto clear position
            end
        end
    end
end