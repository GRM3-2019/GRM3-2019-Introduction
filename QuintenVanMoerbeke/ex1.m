clc
clear
close all

% Create vector
n = 1000;
rng = 10;
xp = rand(1,n)*rng*2-rng;

% Diffuse
t = 10000;

for i =1:t
    rng = 10;
    xp = xp + rand(1,n)*rng*2-rng;
    xbins = -200:2:200;
    figure(1)
    hist(xp,xbins)
    axis([-200 200 0 n/10])
    xlabel('horizontal distance')
    ylabel('number of particles')
    drawnow
end