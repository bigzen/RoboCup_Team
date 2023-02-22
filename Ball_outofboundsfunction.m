function [Flag_num] = untitled2(ballposition)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if ballposition(1) < fieldlimitX(1) || ballposition(1)>fieldlimitX(2)|| ballposition(2) < fieldlimitY(1) || ballposition(2) > fieldlimitY(2)
   if ballposition(2) < GoalareaL(2,2) && ballposition(2) > GoalareaL(1,2)||ballposition(2) < GoalareaR(2,2) && ballposition(2) > GoalareaR(1,2)
       Flag_num = GameFlag.goalscore;
   elseif ballposition(2) < ExtraGoalareaL(2,2) && ballposition(2) > ExtraGoalareaL(1,2)||ballposition(2) < ExtraGoalareaR(2,2) && ballposition(2) > ExtraGoalareaR(1,2)
       Flag_num = GameFlag.coener;
   else
       Flag_num = GameFlag.outofplay;
   end
else
    Flag_num = GameFlag.normalplay;

end
end