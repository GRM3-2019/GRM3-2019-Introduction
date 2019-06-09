% Solve the pop growth problem
clearvars
clc
close all

r = 0.48;
N_0 = 50e3;
N_t = 11.35e6;

%% General function: time to population
t_end = timeToPop(r, N_0, N_t);
disp(['Time required = ' num2str(t_end)]); % [] merge strings together

%% Anonymous function: time to population
timeToPop_An = @(r, N_0, N_t) 1/r * log (N_t/N_0);
t_end = timeToPop_An(r, N_0, N_t);
disp(['Time required = ' num2str(t_end)]); % [] merge strings together

%% Arrays: timeToPop
rArray = linspace(0.01,0.05,25);
t = timeToPop(rArray, N_0, N_t);
figure(1);
plot(rArray,t)
xlabel('Growth rate')
ylabel('Years')
title('Time until equilibrium population by growth rate')

%% Arrays: popAtTime
tArray = linspace(0,10,11);
popAtTime = @(r,N_0,t) N_0 .* exp(r.*t);
N = popAtTime(r,N_0,tArray);
figure(2);
plot(tArray,N)
xlabel('Years')
ylabel('Boar population')
title('Evolution boar population')

%% Make subplots
figure(3)
subplot(2,2,1)
r = 0.1;
plot(tArray,popAtTime(r,N_0,tArray));
xlabel('Years')
ylabel('Boar population')
ylim([0 12e5]);
txt = ['Evolution boar population: r = ' num2str(r)];
title(txt)

subplot(2,2,2)
r = 0.2;
plot(tArray,popAtTime(r,N_0,tArray));
xlabel('Years')
ylabel('Boar population')
ylim([0 12e5]);
txt = ['Evolution boar population: r = ' num2str(r)];
title(txt)

subplot(2,2,3)
r = 0.3;
plot(tArray,popAtTime(r,N_0,tArray));
xlabel('Years')
ylabel('Boar population')
ylim([0 12e5]);
txt = ['Evolution boar population: r = ' num2str(r)];
title(txt)

subplot(2,2,4)
r = 0.4;
plot(tArray,popAtTime(r,N_0,tArray));
xlabel('Years')
ylabel('Boar population')
ylim([0 12e5]);
txt = ['Evolution boar population: r = ' num2str(r)];
title(txt)

saveas(gcf,'Subplots pop.png')

%% Meshgrid
figure(4)
profile on
[T,R] = meshgrid(tArray,rArray);
mesh(T,R,popAtTime(R,N_0,T))
xlabel('Years')
ylabel('Growth rates')
title('Evolution boar population')
profile viewer