classdef State < Simulink.IntEnumType
   enumeration
      KickOff(0)
      Normal(1)
      ThrowIn(2)
      GoalKick(3)
      CornerKick(4)
   end
end