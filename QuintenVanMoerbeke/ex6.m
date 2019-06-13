% Ex6 practice
close all
clearvars
clc

Lx = 50;
Ly = 50;
nx = 100;
ny = 100;
dx = Lx/nx;
dy = Lx/ny;
x = 0:dx:Lx;
y = 0:dy:Ly;

H = 10; %mg/Ls
D = 0.5; %m²/s
Vx = 0.5;
Vy = 0.5;
C = zeros(nx,ny);

dC = zeros(nx,ny);

dt = min(dx^2/(4*D),dx/(abs(Vx)+abs(Vy)));
C(nx/2,ny/2) = H*dt;
t_max = 1000;
t = 0;

Xc = 0:dx:(nx-1)*dx;
Yc = 0:dy:(nx-1)*dy;
[YG,XG]=meshgrid(Xc,Yc);

res = 1e6;
Cp = C;

while (res > 1)
    t = t + dt;
    
    %Advection
    dCdx_adv = -Vx * diff(C,1,1)./dx;
    dC(1:end-1,:) = dCdx_adv;
    dCdy_adv = -Vy * diff(C,1,2)./dy;
    dC(:,1:end-1) = dC(:,1:end-1) + dCdy_adv;
    
    %Diffusion
    qx = -D * diff(C,1,1)./dx;
    qy = -D * diff(C,1,2)./dy;
    dCdx_diff = -diff(qx,1,1)./dx;
    dC(2:end-1,:) = dC(2:end-1,:) + dCdx_diff;
    dCdy_diff = -diff(qy,1,2)./dy;
    dC(:,2:end-1) = dC(:,2:end-1) + dCdy_diff;
    
    %Update
    C(nx/2,ny/2) = H;
    C = C + dC.*dt;
    
    %Boundary conditions
    C(:,1)=C(:,2);
    C(:,end)=C(:,end-1);
    C(1,:)=C(2,:);
    C(end,:)=C(end-1,:);
    
    %Plot
    figure(1);
    %surf(C);
    mesh(XG,YG,C);shading interp;axis tight;colorbar;axis equal
    caxis([0,5])
%     xlim([0 100])
%     ylim([0 100])
%     zlim([-15 15])
    drawnow
    
    res = sum(sum(abs(Cp-C)));
    
    Cp = C;
end
display(t);

% Estimate C at 15m
est = sum(sum((C(35,35:65) + C(35:65,35) + C(65,35:65) + C(35:65,65))))/(4*16);
display(est);
% Retrieve > 1
[row, col, v] = find(C>1);
coord(:,1) = row - nx/2; % correct for center to get norm
coord(:,2) = col - ny/2;
for i = 1:length(coord)
    distance(i) = sqrt(coord(i,1)^2 + coord(i,2)^2);
end
display(max(distance));
fprintf('Done')
