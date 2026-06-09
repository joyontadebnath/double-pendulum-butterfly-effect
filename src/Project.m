clc;
clear all;
close all;

mA  = 2;
mB  = 1;
lA  = 0.1;
lB  = 0.2;
g   = 9.8;

theta_A0    = 2.2;
theta_B0    = 1.6;
velocity_A0 = 0;
velocity_B0 = 0;

time      = 1;
framerate = 60;

[t, results] = solution_to_double_pendulam(mA, mB, lA, lB, g, theta_A0, theta_B0, velocity_A0, velocity_B0, time, framerate);

theta_A    = results(:,1);
velocity_A = results(:,2);
theta_B    = results(:,3);
velocity_B = results(:,4);

xA =  lA*sin(theta_A);
yA = -lA*cos(theta_A);
xB =  lA*sin(theta_A) + lB*sin(theta_B);
yB = -lA*cos(theta_A) - lB*cos(theta_B);

for i = 1 : length(t)
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
    axis([-(lB+lA) (lB+lA) -(lB+lA) (lB+lA)]);
    pause(0.0001);
end


function [t, results] = solution_to_double_pendulam(mA, mB, lA, lB, g, theta_A0, theta_B0, velocity_A0, velocity_B0, tf, fR)

    parameters = [mA mB lA lB g];
    theta_0    = [theta_A0 velocity_A0 theta_B0 velocity_B0];
    dt         = 1/fR;
    time_span  = 0 : dt : tf;

    [t, results] = ode45(@(time,theta) double_pendulum_model(time, theta, parameters), time_span, theta_0);

end

function dx = double_pendulum_model(t, y, parameters)

    mA = parameters(1);
    mB = parameters(2);
    lA = parameters(3);
    lB = parameters(4);
    g  = parameters(5);

    y1 = y(1);
    y2 = y(2);
    y3 = y(3);
    y4 = y(4);

    out(1) = y2;
    out(2) = ((mA+mB)*lA - mB*lA*(cos(y1-y3))^2)^(-1) * ...
             (-mB*lA*(y2^2)*sin(y1-y3)*cos(y1-y3) + mB*g*sin(y3)*cos(y1-y3) - mB*lB*(y4^2)*sin(y1-y3) - (mA+mB)*g*sin(y1));
    out(3) = y4;
    out(4) = (lB - (mB*lB/(mA+mB))*(cos(y1-y3))^2)^(-1) * ...
             (lA*(y2)^2*sin(y1-y3) - g*sin(y3) + (mB*lB/(mA+mB))*(y4^2)*sin(y1-y3)*cos(y1-y3) + g*sin(y1)*cos(y1-y3));

    dx = [out(1); out(2); out(3); out(4)];

end
