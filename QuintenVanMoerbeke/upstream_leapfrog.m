
% --------------------------------------------------------------------
% Main script which is used to calculate the temperature anomaly of a 
% discrete, sine shaped perturbation and visualise the result
% --------------------------------------------------------------------

tic

% clean up
clc
clear
close all
                     
% --------------------------------------------------------------------
% initialisation
% --------------------------------------------------------------------

% initialisation of model constants
dx     = 1E3;       % spatial step = 1km
lambda = 100*dx;    % wavelength
nr     = 500;       % size of the domain
ampl   = 5;         % amplitude


% initialisation of variables (including scalars, arrays and matrices)
x = 0:dx:((nr-1)*dx);
b = find(x <= lambda);
c = find(x >  lambda);

% --------------------------------------------------------------------
% manipulations
% --------------------------------------------------------------------

% get sine wave
y(b) = ampl*sin(x(b)*2*pi/lambda);
y(c) = 0;

% analytical: Chloe
% t = 5*3600;
% v = 10;
% 
% analytic = zeros(size(y));
% 
% for i = 1:length(x)   
%     if x(i)-v*t > 0
%         analytic(i) = y((x(i)-v*t)/dx);   
%     end
% end

% analytical: Quinten
t = 5; %h
v = 36; %km/h
e = b + t*v;
y(e) = y(b);
%y(b) = 0;

figure(1);
plot(x./1e3,y,'r')
ylim([-6 6])
xlabel('x (km)');
ylabel('T (K)');
box   ('on');
grid  ('on');
hold on

% Upstream
dx     = 1E3;       % spatial step = 1km
lambda = 100*dx;    % wavelength
nr     = 500;       % size of the domain
ampl   = 5;         % amplitude
x = 0:dx:((nr-1)*dx);
b = find(x <= lambda);
c = find(x >  lambda);

% get sine wave
y(b) = ampl*sin(x(b)*2*pi/lambda);
y(c) = 0;

v = 10; %(m/s)
dt = 10;
t_max = 5*60*60;
t = 0:dt:t_max;
x = 0:dx:((nr-1)*dx);

numerical = zeros(length(t),length(x));
numerical(1,b) = y(b);

for i = 2:length(t)
    for j = 1:length(x)
        if j == 1
            numerical(i,j) = numerical(i-1,j) - v * dt/dx * (numerical(i-1,j)-numerical(i-1,length(x)));
        else
            numerical(i,j) = numerical(i-1,j) - v * dt/dx * (numerical(i-1,j)-numerical(i-1,j-1));
        end
    end
% plot(x/1.E3, numerical(i,:), 'r', 'LineWidth',1.5)
% ylim([-6 6])
% xlabel('x (km)');
% ylabel('T (K)');
% box   ('on');
% grid  ('on');
% drawnow
end

for s = 1:100:length(t)
    plot(x/1.E3, numerical(s,:), 'g', 'LineWidth',1.5)
end

%% Leapfrog
dx     = 1E3;       % spatial step = 1km
lambda = 100*dx;    % wavelength
nr     = 500;       % size of the domain
ampl   = 5;         % amplitude

b = find(x <= lambda);
c = find(x >  lambda);

% get sine wave
y(b) = ampl*sin(x(b)*2*pi/lambda);
y(c) = 0;
dx     = 1E3;       % spatial step = 1km
lambda = 100*dx;    % wavelength
nr     = 500;       % size of the domain
ampl   = 5;         % amplitude

v = 10; %(m/s)
dt = 10;
t_max = 5*60*60;
t = 0:dt:t_max;
x = 0:dx:((nr-1)*dx);

numerical = zeros(length(t),length(x));
numerical(1,b) = y(b);

alpha = 0.0000;

for i = 2:length(t)
    if i == 2 %Upstream
        for j = 1:length(x)
            if j == 1
                numerical(i,j) = numerical(i-1,j) - v * dt/dx * (numerical(i-1,j)-numerical(i-1,length(x)));
            else
                numerical(i,j) = numerical(i-1,j) - v * dt/dx * (numerical(i-1,j)-numerical(i-1,j-1));
            end
            numerical(i,j) = numerical(i,j) + alpha * (numerical(i+1,j)-2*numerical(i,j)+numerical(i-1,j));
        end
    else 
        for j = 1:length(x)
            if j == 1
                numerical(i,j) = numerical(i-2,j) - v * (2*dt)/(2*dx) * (numerical(i-1,j+1)-numerical(i-1,length(x)));   
            elseif j == length(x)
                numerical(i,j) = numerical(i-2,j) - v * (2*dt)/(2*dx) * (numerical(i-1,1)-numerical(i-1,j-1)); 
            else
                numerical(i,j) = numerical(i-2,j) - v * (2*dt)/(2*dx) * (numerical(i-1,j+1)-numerical(i-1,j-1));
            end
            if i == length(t)
                numerical(i,j) = numerical(i,j) + alpha * (numerical(1,j)-2*numerical(i,j)+numerical(i-1,j)); 
            else
                numerical(i,j) = numerical(i,j) + alpha * (numerical(i+1,j)-2*numerical(i,j)+numerical(i-1,j));
            end
        end
    end   
end

for s = 1:100:length(t)
    plot(x/1.E3, numerical(s,:), 'b', 'LineWidth',1.5)
end

% Save the file
print -djpeg 'leapfrog.jpg';

toc
