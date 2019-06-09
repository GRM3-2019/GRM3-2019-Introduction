clc
clear
close all

% physics
D = 25; %km²/Ma
sill_width = 0.1;
Lx = 0.4+sill_width; %sand up and down

% numerical properties
dx = 0.001;
x = 0:dx:Lx;
nt = 1e5;

% initial condition
%Choose an initial condition where C = C1 when x <Lx / 2 and C = 0 when x> Lx / 2.
C = zeros(size(x));
C(x>0.2&x<0.2+sill_width) = 1000;

figure;
plot(x,C)

% impose a condition on the time step (use the above described rule)
dt = dx^2/(2*D); %2.5 to make sure

% model run
%solve the heat equation and plot the result.

for t = 1:nt
    q = -D * diff(C)./dx; %(C(i+1)-C(i))/dx;
    C(2:end-1) = C(2:end-1) - diff(q)./dx .* dt;

    if mod(t,10)==0
        plot(x,C)
        ylim([0 1000])
        drawnow
    end
end
    
    
% - make a time loop
% - in this loop, first calculate the flow by discretizing equation (1)
% - calculate the new concentration (Eq. 2, without changing the extremities) 
% - plot intermediate results, but only for every 1000 time steps
%%%%%%%%%%%%%
