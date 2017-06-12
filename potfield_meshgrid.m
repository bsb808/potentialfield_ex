
%% Define potential field behavior for line
% Define line obstacle with two points
x1 = 0; y1 = 60;
x2 = -50; y2 = -50;
% Define distances to line
d1 = 25.0;  % [m]
d2 = 50.0;  % [m]
% Define Fmax
fmax = 1.0;  

%% Define meshgrid coordinates
N=41;
M=41;
L=100;
xx = linspace(-L,L,N);
yy = linspace(-L,L,M);
[X,Y]=meshgrid(xx,yy);

% Loop through 2D space
Fx = [];
Fy = [];
for ii = 1:size(X,1)
    for jj = 1:size(X,2)
        [Fx(ii,jj), Fy(ii,jj)]=pot_line_linear(X(ii,jj),Y(ii,jj),x1,y1,x2,y2, ...
            d1,d2,fmax);
    end
end

figure(1)
clf()
theta = atan2(Fy,Fx);
mag = sqrt(Fx.^2+Fy.^2);
u = mag.*cos(theta);
v = mag.*sin(theta);
quiver(X,Y,u,v)
hold on
plot([x1,x2],[y1,y2],'r','linewidth',2)
plot(x1,y1,'ko','markerfacecolor','k','markersize',5)
plot(x2,y2,'ko','markerfacecolor','k','markersize',5)
% plot parallel lines to illustrate d1 and d2
th = atan2(y2-y1,x2-x1);
dx = d1*cos(th+pi/2);
dy = d1*sin(th+pi/2);
plot([x1,x2]+dx,[y1,y2]+dy,'r--')
plot([x1,x2]-dx,[y1,y2]-dy,'r--')

dx = (d1+d2)*cos(th+pi/2);
dy = (d1+d2)*sin(th+pi/2);
plot([x1,x2]+dx,[y1,y2]+dy,'g--')
plot([x1,x2]-dx,[y1,y2]-dy,'g--')

axis('equal')
xlabel('X [m]')
ylabel('Y [m]')
