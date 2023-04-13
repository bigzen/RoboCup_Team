function [Flag_num] = checkFoul(ballposition,players)
%CHECKFOUL Summary of this function goes here
%   Detailed explanation goes here
load('robotSoccerParam','goalPosts','fieldLimitsX', 'fieldLimitsY')
if ballposition(1) < fieldLimitsX(1) || ballposition(1)>fieldLimitsX(2) 
   if ballposition(1) < fieldLimitsX(1) 
       if ballposition(2) < goalPosts(1,2)&&ballposition(2) > goalPosts(2,2)
           Flag_num = GameFlag.goalScore;
       elseif players(1).lastKick==1 || players(2).lastKick==1 || players(3).lastKick==1 || players(4).lastKick==1
           Flag_num = GameFlag.corner;
       else
           Flag_num = GameFlag.goalKick;
       end
   else
       if ballposition(2) < goalPosts(1,2)&&ballposition(2) > goalPosts(2,2)
           Flag_num = GameFlag.goalScore;
       elseif players(5).lastKick==1 || players(6).lastKick==1 || players(7).lastKick==1 || players(8).lastKick==1
           Flag_num = GameFlag.corner;
       else
           Flag_num = GameFlag.goalKick;
       end
   end
elseif ballposition(2) < fieldLimitsY(1) || ballposition(2) > fieldLimitsY(2)
    Flag_num = GameFlag.outOfPlay;
else
    Flag_num = GameFlag.normalPlay;

end
end

