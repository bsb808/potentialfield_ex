function [fx,fy]=pot_line_linear(x,y,x1,y1,x2,y2,d1,d2,fmax)
% Line definec by two points (x1,y1) and (x2,y2)
% Robot location is (x,y)

% Slope of line
m = 0;
if (abs(x2-x1)<0.01) % Vertical
    m = 1e6;
else
    m = (y2-y1)/(x2-x1);
end

% Intersection between robot current location and line
xint = 0;
yint = 0;
if (m==0)
    yint = y1;
    xint = x;
elseif (abs(m) > 1000)
    yint = y;
    xint = x1;
else
    xint = (m/(m^2+1))*(y-y1+m*x1+x/m);
    yint = y1+m*(xint-x1);
end

% Distance from robot to line
dist = sqrt((x-xint)^2+(y-yint)^2);

% Angle from line to robot
ang = atan2(y-yint,x-xint);

% Magnitude of repusive force
mag = 0.0;
if (dist < 1e-6)
    mag = 0.0;
elseif (dist < d1)
    mag = fmax;
elseif (dist < (d2+d1))
    mag = fmax/d2*((d1+d2)-dist);
else
    mag = 0.0;
end

% x and y components of repulsive force
fx = mag*cos(ang);
fy = mag*sin(ang);
return 

