clc
clear
close all

% physics
D = 100;
Lx = 30; %300

% numerical properties
dx = 0.05;
x = 0:dx:Lx;
nt = 10000;

% initial condition
%Choose an initial condition where C = C1 when x <Lx / 2 and C = 0 when x> Lx / 2.
C1 = 500;
C = zeros(size(x));
C(x<Lx/2) = C1;
figure;
plot(x,C)

% impose a condition on the time step (use the above described rule)
dt = dx^2/(2.1*D); %2.5

% model run
%solve the heat equation and plot the result.

% for t = 1:nt
%     q = -diff(C)./dx; %(C(i+1)-C(i))/dx;
%     C(2:end-1) = C(2:end-1) - 10 .* diff(q)./dx .* dt;
%     
%     if mod(t,10)==0
%         plot(x,C)
%         drawnow
%     end
% end

Cp = C;
t = 0;
res = 1e6;

while (res > 10)
    t = t+dt;
    q = -D *diff(C)./dx; %(C(i+1)-C(i))/dx;
    C(2:end-1) = C(2:end-1) - diff(q)./dx .* dt;
    
%     if mod(t,10)==0
%         plot(x,C)
%         drawnow
%     end
    plot(x,C)
    drawnow
    
    res = sum(abs(Cp-C));
    Cp = C;
end
