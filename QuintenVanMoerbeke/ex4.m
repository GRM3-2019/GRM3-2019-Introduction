clc
clear
close all

% physics
D = 25; %km²/Ma
plate_width = 10;
Lx = plate_width; 
Ly = plate_width;

% numerical properties
nx = 101; %Number of pixels
ny = 101;
dx = Lx/(nx-1);
dy = Ly/(ny-1);

tmax = 3; %tmax
nout = 10; %?

% initial condition
Te = zeros(nx,ny);
T_ini = 500;
Te(round(ny*1/3):round(ny*2/3),round(nx*1/3):round(nx*2/3)) = T_ini;
imagesc(Te)
dTedt = zeros(nx,ny); %Tussenstap voor bij originele T

% impose a condition on the time step (use the above described rule)
dt = dx^2/(4.1*D); %to make sure

% model run
%solve the heat equation and plot the result.
time = 0;
it = 0;
while (time < tmax)
    % Update time and iteration number
    time = time + dt;
    it = it + 1;
    % compute diffusion
    qx   = - diff(Te(1:end-0,2:end-1),1,1)./dx;
    qy   = - diff(Te(2:end-1,1:end-0),1,2)./dy;
    %Te(2:end-1,2:end-1) = Te(2:end-1,2:end-1) - dt*D(diff(qx,1,1)./dx + diff(qy,1,2)./dy);
    
    dTedt(2:end-1,2:end-1) = D*(-diff(qx,1,1)/dx - diff(qy,1,2)/dy);

    % update Temperature
    Te = Te + dt*dTedt;

    % Boundary conditions
    %Te(round(nx/2),round(ny/2)) = 500;
    Te(round(ny*1/3):round(ny*2/3),round(nx*1/3):round(nx*2/3)) = T_ini;
%     Te(:,1) = 0;
%     Te(:,end) = 0;
%     Te(1,:) = 0;
%     Te(end,:) = 0;

    % plot temperature field
    if mod(it,nout)==0
        figure(1);
        surf(Te);
        shading interp;
        title(time)
        zlim([0 T_ini])
        xlim([0 nx])
        ylim([0 ny])
        drawnow
    end
end
    
% - make a time loop
% - in this loop, first calculate the flow by discretizing equation (1)
% - calculate the new concentration (Eq. 2, without changing the extremities) 
% - plot intermediate results, but only for every 1000 time steps
%%%%%%%%%%%%%
