% Solve the population problem with the carrying capacity
clearvars
clc
close all

dt = 1;
tMax = 30;
t = 0:dt:tMax;
r = 0.48;
N_0 = 50e3;
K = 20 * 305000; % density * A

%% Numerical
N_n = zeros(1,11);
N_n(1)= N_0;
for i=2:length(t)
    N_n(i) = N_n(i-1)+N_n(i-1)*r*(1-N_n(i-1)/K);
end

%% Time until eq pop
% Numerical
r = 0.48;
K = 11.3e6;
N_ini = 50e3;

N_store = [];
T_store = [];

N = N_ini;
time = 0;
iter = 0;
dt=1; %years

while N<0.99999*K
    iter = iter+1;
    time=time+dt;
    dN=r*N*(1-N/K);
    N=N+dN*dt;
    N_store(iter)=N;
    T_store(iter)=time;
end

% Analytical
A = (K - N_ini)/N_ini;
popAtTime = @(K,r,t) K./(A*exp(-r.*t)+1);

Na = popAtTime(K,r,T_store);

figure(1);
plot(T_store,N_store)
hold on
plot(T_store, Na);
xlabel('Time');
ylabel('N');
legend('Numerical','Analytic','location','southeast')
title('Evolution boar population')

%% Truncation error: error at the end = offset between both solutions
% Influence time
Error=((Na-N_store).^2/length(T_store)).^0.5;
figure(2);
plot(T_store,Error)
xlabel('Time');
ylabel('Error');
title('Error through time')

% Influence dt
steps=linspace(0.01,1,20);
RMSE=zeros(1,length(steps));
A = (K - N_ini)/N_ini;
popAtTime = @(K,r,t) K./(A*exp(-r.*t)+1);
for i=1:numel(steps)
    dt=steps(i);
    
    % Numerical
    r = 0.48;
    K = 11.3e6;
    N_ini = 50e3;

    N_store = [];
    T_store = [];

    N = N_ini;
    time = 0;
    iter = 0;

    while N<0.99999*K
        iter = iter+1;
        time=time+dt;
        dN=r*N*(1-N/K);
        N=N+dN*dt;
        N_store(iter)=N;
        T_store(iter)=time;
    end

    % Analytical
    N_ana=popAtTime(K,r,T_store);
    
    % RMSE
    RMSE(i)=(sum((N_ana-N_store).^2)/length(T_store)).^0.5;
end

figure(3);
plot(steps,RMSE)
xlabel('dt');
ylabel('RMSE');
title('RMSE for different dt') % linear