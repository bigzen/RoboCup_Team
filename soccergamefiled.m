function [field] = soccergamefiled()
    % build the coordinate system
     x = [0, 11, 11, 0];
     y = [0, 0, 8, 8];
     fill(x, y, 'g')
    
    % add the circle in the system
     axis([0,11,0,8])
     hold on
     r = 0.75;
     a = 5.5;
     b = 4;
     theta = 0:pi/20:2*pi;
     x = a + r*cos(theta);
     y = b + r*sin(theta);
     plot(x,y,'w')
    
    % add the outline area
     plot([1,10],[1,1],'w')
     plot([1,10],[7,7],'w')
     plot([1,1],[1,7],'w')
     plot([10,10],[1,7],'w')
    
    % add the left area
     plot([5.5,5.5],[1,7],'w')
     plot([1,3],[6.5,6.5],'w')
     plot([1,3],[1.5,1.5],'w')
     plot([3,3],[1.5,6.5],'w')
     plot([2,2],[5.5,2.5],'w')
     plot([1,2],[5.5,5.5],'w')
     plot([1,2],[2.5,2.5],'w')
     plot([0.4,0.4],[5.3,2.7],'Color','w','linewidth',2)
     plot([0.4,1],[5.3,5.3],'Color','w','linewidth',2)
     plot([0.4,1],[2.7,2.7],'Color','w','linewidth',2)
     hold on
    
    % add the right area
     plot([8,10],[6.5,6.5],'w')
     plot([9,10],[5.5,5.5],'w')
     plot([9,10],[2.5,2.5],'w')
     plot([8,10],[1.5,1.5],'w')
     plot([10,10.6],[5.3,5.3],'Color','w','linewidth',2)
     plot([10,10.6],[2.7,2.7],'Color','w','linewidth',2)
     plot([8,8],[6.5,1.5],'w')
     plot([9,9],[5.5,2.5],'w')
     plot([10.6,10.6],[5.3,2.7],'Color','w','linewidth',2)
     hold on
end
