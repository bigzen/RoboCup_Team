classdef GameFlag < Simulink.IntEnumType
   enumeration
      normalPlay(0)
      goalScore(1)
      corner(2)
      goalKick(3)
      outOfPlay(4)
   end
end
