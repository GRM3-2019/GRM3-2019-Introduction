clc
clear
close all

% physics
D = 25; %km²/Ma
Lx = 25; 
e = -10;
Ts = 10;
Tb = 700;

% numerical properties
nx = 251;
dx = Lx/(nx-1);
nt = 1e6;
nout = 1000;

% initial condition
%Choose an initial condition where C = C1 when x <Lx / 2 and C = 0 when x> Lx / 2.
x = (0:dx:Lx);
T = Ts + (Tb-Ts)*x/max(x); %y2-y1/x2-x1
qx = zeros(1,nx-1);
dTdt = zeros(1,nx);
Vx = ones(1,nx+1)*e;
time = 0;
plot(T,x)
axis ij

% impose a condition on the time step (use the above described rule)

% model run
% solve the heat equation and plot the result.
for t = 1:nt
    % pick dt
    dt = min(dx^2/2.1/D, dx/max(abs(Vx))); %iedere tijdstip valideren om zeker te zijn dat alles mee is, gebruik maximale erosiesnelheid
    time = time + dt;
    
    % Diffusion
    q = -diff(T)/dx;
    dTdt(2:end-1) = - D.*(diff(q)/dx);
    
    %Advection
    dTdt(2:end) = dTdt(2:end) - Vx(2:end-1).*diff(T)/dx;
    T = T + dt*dTdt;
    
    % Boundary
    T(1)=Ts;
    T(nx)=Tb;

    if mod(t,nout)==0
        plot(T,x)
        axis ij
        xlim([0 Tb])
        ylim([0 Lx])
        drawnow
        hold on
    end
end
    
    
% - make a time loop
% - in this loop, first calculate the flow by discretizing equation (1)
% - calculate the new concentration (Eq. 2, without changing the extremities) 
% - plot intermediate results, but only for every 1000 time steps
%%%%%%%%%%%%%
