function state = GameSate(flag)
    if flag == 0
        state = "Normal";
    elseif flag == 1
        state = "Goal";
    elseif flag == 2
        state = "ThrowIn";
    elseif flag == 3
        state = "GoalKick";
    elseif flag == 4
        state = "CornerKick";
end