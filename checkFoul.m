function [Flag_num] = checkFoul(ballposition,fieldLimitsX,fieldLimitsY)
%CHECKFOUL Summary of this function goes here
%   Detailed explanation goes here
if ballposition(1) < fieldLimitsX(1) || ballposition(1)>fieldLimitsX(2)|| ballposition(2) < fieldLimitsY(1) || ballposition(2) > fieldLimitsY(2)
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

