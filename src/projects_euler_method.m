clc;
clear all;
close all;

mA  = 2;
mB  = 1;
rA  = 0.1;
rB  = 0.2;
g   = 9.8;

theta_A0    = 2.2;
theta_B0    = 1.6;
velocity_A0 = 0;
velocity_B0 = 0;

time      = 1;
framerate = 60;
h         = 1/framerate;

y1(1) = theta_A0;
y2(1) = velocity_A0;
y3(1) = theta_B0;
y4(1) = velocity_B0;

t = 0 : h : time;

f2 = @(mA,mB,rA,rB,g,y1,y2,y3,y4) ((mA+mB)*rA - mB*rA*(cos(y1-y3))^2)^(-1) * ...
        (-mB*rA*(y2^2)*sin(y1-y3)*cos(y1-y3) + mB*g*sin(y3)*cos(y1-y3) - mB*rB*(y4^2)*sin(y1-y3) - (mA+mB)*g*sin(y1));

f4 = @(mA,mB,rA,rB,g,y1,y2,y3,y4) (rB - (mB*rB/(mA+mB))*(cos(y1-y3))^2)^(-1) * ...
        (rA*(y2)^2*sin(y1-y3) - g*sin(y3) + (mB*rB/(mA+mB))*(y4^2)*sin(y1-y3)*cos(y1-y3) + g*sin(y1)*cos(y1-y3));

for i = 2 : length(t)
    y1(i) = y1(i-1) + h*y2(i-1);
    y3(i) = y3(i-1) + h*y4(i-1);
    y2(i) = y2(i-1) + h*f2(mA,mB,rA,rB,g,y1(i-1),y2(i-1),y3(i-1),y4(i-1));
    y4(i) = y4(i-1) + h*f4(mA,mB,rA,rB,g,y1(i-1),y2(i-1),y3(i-1),y4(i-1));
end

theta_A    = y1;
velocity_A = y2;
theta_B    = y3;
velocity_B = y4;

xA =  rA*sin(theta_A);
yA = -rA*cos(theta_A);
xB =  rA*sin(theta_A) + rB*sin(theta_B);
yB = -rA*cos(theta_A) - rB*cos(theta_B);

for i = 1 : 10 : length(t)
    figure(1)
    clf;
    hold on
    scatter(0, 0, "filled", Color="red");
    plot(xA(i), yA(i), 'wo', LineWidth=mA, Color="red");
    line([0 xA(i)], [0 yA(i)], 'Linewidth', 2)
    plot(xA(1:i), yA(1:i), LineWidth=1, Color=[0 0.447 0.7410], LineStyle='--');
    plot(xB(i), yB(i), 'Marker', 'o', LineWidth=mB, Color="red");
    line([xA(i) xB(i)], [yA(i) yB(i)], 'Linewidth', 2)
    plot(xB(1:i), yB(1:i), LineWidth=1, Color=[0 0.447 0.7410], LineStyle='--');
    axis equal
    axis([-(rB+rA) (rB+rA) -(rB+rA) (rB+rA)]);
    pause(0.0001);
end
