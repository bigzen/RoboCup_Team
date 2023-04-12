# RoboCup_Team

Revise the prev_distance issue(always equals to 0), modified files below.  
  
1. Player_detail.m & Ball_detail.m  
Add prev_pos to the strcture.  
  
2. getPlayerInit.m & Start_script.m  
Initialize prev_pos.  
    
3. updateGameState.m  
Record the prev_pos before position is updated.  
  
4. PD_controller_new.m  
Modified by PD_controller.m, caculate the distance to desire position & previous distance to desire position inside the function.  
Desire position can be ball position or any position on the field.  
  
5. attacker.m & defender.m & goal_keeper.m  
Change every PD controller to the new one.

6. Kickball.m  
Cancel ball friction force since there is ball decay in updateGameState.m
