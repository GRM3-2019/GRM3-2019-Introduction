% nested loops
B=zeros(4,5);

for r=1:size(B,1) %row
    for c=1:size(B,2) %column
        B(r,c)=1;
    end
end
%% ex slopecalc
% exercise slope calculation: make github folder, the other one forks, read
% DEM and make 2 calculations: 1 with nested for loops and the other vect
% Mainscript
% first load dem
clearvars
clc
close all
locationofthefile='F:\grmIII\introles2\'
FileName='dem.mat'
dr = 30
DEM=LoadFileFunction(locationofthefile, FileName)
Slope1 = SlopeLoopFunction(DEM,dr) % calculation1 - Nested Loops
Slope2 = SlopeNonLoopFunction(DEM,dr) % calculation2 - vector
% you can also combine both functions into 1 with 2 outputs via case
% statements, where you have to specify type = nested loop or not DO THIS


%% compare strings efficiently
name = 'James';
switch name
    case 'Silence'
        A=5;
    case 'James'
        A=0;
end
%% numerical and analytical solution with carrying capacity (start Lecture 3)
% Numerical
% dN/dt = r.N(1- N/K)
% dN/dt = (N(t+1) - N(t))/dt
% combineert tot N(t+1) = N(t) + r.t.N(t)(1- N/K)
% kan je schrijven als: N(t+1)= N(t)(1+rt(1-N/K))
clearvars
clc
close all
% numerical solution
N0 = 50000;
r=0.48;
K = 11E6;

% numerical parameters
dt=0.01;
time = [0:dt:100];
N = zeros(size(time));
N(1)=N0;

% model
for t = 1:numel(time)-1
    N(t+1) = N(t)*(1+ r*dt*((K-N(t))/K));
end

% plotting
plot(time,N,"--r")
xlabel("time (years)")
ylabel("population")

% analytical
Anacalc = @(t,N0,K) K./(1 + ((K - N0 / N0).*exp(-r.*t)));
Ana = Anacalc(time,N0,K);
% still do this

%% calculate equilibrium population witk carrying capacity
% Numerical
clearvars
clc
close all

r=0.48;
N_ini=50000;
K=600000;

N_store=[];
T_store=[];

N=N_ini;
iter=0;
time=0
dt=0.01; %timestep

while N<0.9999*K %because the pop approaches K, but never reaches (asymptotic) it you need the 0.9999 otherwise the loop keeps going
    iter=iter+1;
    time=time+dt;
    dN=r.*N*(1-N/K);
    N=N+(dN*dt);
    N_store(iter)=N;
    T_store(iter)=time;
end

% analytical (see notes)

t=[0:5:30];
A=(K-N_ini)/N_ini;
N_t=@(t) K./(A.*exp(-r.*t)+1)
Pop=N_t(t)
%plot both! finish this!
figure;
plot(T_store,N_store);
xlabel('time')
ylabel('N')
hold on 
plot(t,Pop)
hold off

%% go hunting! to control them in belgium

clearvars
clc
close all
% numerical solution
N0 = 50000;
r=0.48;

% numerical parameters
dt=0.1;
time = [0:dt:30];
N = zeros(size(time));
N(1)=N0;

% model
for t = 1:numel(time)-1
    H = 1.4*r*N(t);
    N(t+1) = N(t)*(1+(r*dt)) - H*dt;
end

% plotting
plot(time,N,"--r")
xlabel("time (years)")
ylabel("population")

%% predator - prey
clearvars
clc
close all
% numerical solution

% parameters
N0 = 100;
W0 = 25;
c = 0.0001;
r=0.48;
e = 0.0005;
d = 0.24;

% numerical parameters
dt=0.01;
time = [0:dt:500];
N = zeros(size(time));
W = zeros(size(time));
N(1)=N0;
W(1) = W0;

% model
for t = 1:numel(time)-1
    N(t+1) = N(t) + dt*(r*N(t) - c*N(t)*W(t));
    W(t+1) = W(t) + dt*(-d*W(t) + e*N(t)*W(t));
end

% plotting
% plot(time,N,"r")
% hold on
% plot(time,W, "b")
% xlabel("time (years)")
% ylabel("population")
% legend("boars","wolves")

% or plot
plot(N,W,"b")
hold on
% analytical constant --> This condition is met at any point in time.
Ccheck=@(N0,W0,r,c,d,e) d*log(N0)-e*N0+r*log(W0)-(c*W0);
Cst=Ccheck(N0, W0, r,c,d,e);

% A perfect numerical solution should respect this ratio during the simulation
NumCcheck=@(N0,W0,r,c,d,e) d.*log(N0)-e.*N0+r.*log(W0)-(c.*W0);
NumCst = NumCcheck(N, W,r,c,d,e);

RMSE = sqrt((NumCst-Cst).^2);

% Can plot for different dt by saving & loading.



%% ODE45 --> Matlab standard solver for first order ordinary differential equations.
clearvars
clear all 
tic
N0 = 100;
W0 = 25;
c = 0.0001;
r=0.48;
e = 0.0005;
d = 0.24;

tspan = [0 30];
y0 = [N0,W0]; % initial population conditions.
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-4); % if difference between a low acc integration and high accuracy integration is larger than tolerance, t-step is reduced.
[time,pop]=ode45(@(t,y) PP45(y,r,c,e,d),tspan,y0,options); % have to write it like this if you want to add more arguments than t,y
elapsed = toc;

plot(pop(:,1),pop(:,2))
xlabel("Boars")
ylabel("Wolves")

% Accuracy of my numerical x ode45. Depends on timestep chosen for my model
% and the tolerance for the ode45 solver. 
check45=@(N0,W0,r,c,d,e) d.*log(N0)-e.*N0+r.*log(W0)-(c.*W0);
Cst45 = check45(pop(:,1),pop(:,2),r,c,d,e);
% Subtract analytical constant from numerical constants (RMSE) --> plot..
%% P-P + hunting
clearvars
clc
close all
% numerical solution

% parameters
N0 = 100;
W0 = 25;
c = 0.0001;
r=0.48;
e = 0.0005;
d = 0.24;
a = 0.9*r;
% numerical parameters
dt=0.01;
time = [0:dt:500];
N = zeros(size(time));
W = zeros(size(time));
N(1)=N0;
W(1) = W0;

% model
for t = 1:numel(time)-1
    H = a*N(t);
    N(t+1) = N(t) + dt*(r*N(t) - c*N(t)*W(t));
    W(t+1) = W(t) + dt*(-d*W(t) + e*N(t)*W(t));
end

% plotting
plot(N,W,"r")
xlabel("Boars")
ylabel("Wolves")
hold off

%% Include Roe deer --> 3 ODE's
clear all 
clearvars
clc
close all
% parameters
N0 = 100;
W0 = 25;
R0 = 2000;
c1 = 0.0001;
c2 = 0.02;
r1=0.48;
r2=0.48;
e = 0.0005;
d = 0.24;

% numerical parameters
dt=0.01;
time = [0:dt:100];
N = zeros(size(time));
W = zeros(size(time));
R = zeros(size(time));
N(1)=N0;
W(1) = W0;
R(1) = R0;

% model
for t = 1:numel(time)-1
    HB = 0.8*r1*N(t);
    HR = 0.1*r2*R(t);
    N(t+1) = N(t) + dt*(r1*N(t) - c1*N(t)*W(t) - HB);
    R(t+1) = R(t) + dt*(r1*R(t) - c1*R(t)*W(t) - HR);
    W(t+1) = W(t) + dt*(-d*W(t) + e*W(t)*(N(t) + R(t)));
end

% plotting
scatter3(N,R,W,2,time)
xlabel("Boars")
ylabel("Roe")
zlabel("Wolves")
c = colorbar;
c.Label.String = 'time (years)';

% Now for ODE45
tspan = [0 10];
y0 = [N0,W0,R0]; % initial population conditions.
options = odeset('RelTol', 1e-4, 'AbsTol', 1e-4); % if difference between a low acc integration and high accuracy integration is larger than tolerance, t-step is reduced.
[time,pop]=ode45(@(t,y) PPP45(y,r1,r2,c1,c2,e,d),tspan,y0,options); % have to write it like this if you want to add more arguments than t,y

%% Fitting to observations dataset w/ ode45
clear all 
close all

% Estimated simulation parameters

r = 0.48; % growth rate boars per capita
d = 0.24; % mortality rate wolves

% load in dataset of observations
location = "F:\grmIII\introles3\";
name = "DataBoarWolves.xlsx";
obs = loadboars(location,name);
boars = obs.N_S;
wolves = obs.W_S;

N0 = mean(boars);
W0 = mean(wolves);

% Additional constraints to parameter values can be derived from solving
% the ODE's for dW/dt = 0 and dN/dt = 0, given that you start from the
% equilibrium population.

c = r / W0; % hunting efficiency
e = d / N0; % reproduction efficiency per boar eaten
C(1) = r;
C(2) = d;
C(3) = c;
C(4) = e;
C(5) = N0;
C(6) = W0;

% optimization procedure
dt = 0.1;
tseries = 0.1:dt:obs.T_S(end); % for the ode run.
options = odeset('RelTol', 1e-4); % for the ode run.
fminOptions=optimset('MaxFunEvals',10e3,'Display','iter'); % Max 1000 iterations, Display every iteration the result

% You give an error function that is run MaxFunEvals times to optimize the
% parameter settings departing from the C given. This is done by running
% ode45 each time with new settings and calculating error with respect to
% the observations. (not done here).
[C,fval,exitflag] = fminsearch(@(C) error(C,tseries,options,boars,wolves,dt),C,fminOptions);

% Finally optimized parameters are found and the model runs with the
% conditions of that specific observational dataset.

tspan = tseries;
y0 = [N0,W0];
[time,pop]=ode45(@(t,y) PP45(y,r,c,e,d),tspan,y0,options);
