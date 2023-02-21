function circles = circle(x,y,r,c)
    th = 0:pi/50:2*pi;
    x_circle = r * cos(th) + x;
    y_circle = r * sin(th) + y;
    circles = plot(x_circle, y_circle);
    fill(x_circle, y_circle, c)
    hold off
end