% Solve the problem numerically and compare with analytic solution
clearvars
clc
close all

dt = 1;
t = 0:dt:10; %linspace(0,10,11);
r = 0.48;
N_0 = 50e3;
N_t = 11.35e6;

%% Numerical
N_n = zeros(1,length(t));
N_n(1)= N_0;N = N_0;
it = 2;
t = 0;
while N < N_t
    N_n(it) = N_n(it-1) + N_n(it-1) * r * dt;
    N = N_n(it);
    it = it + 1;
    t = t + dt;
end
time = 0:dt:t;

%% Analytical
popAtTime = @(r,N_0,t) N_0 .* exp(r.*t);
N_a = popAtTime(r,N_0,time);
%N_a = N_0 .* exp(r.*time);

%% Plot
figure(1);
plot(time,N_a)
hold on
plot(time,N_n)
xlabel('Years')
ylabel('Boar population')
title('Evolution boar population')
legend('Analytic', 'Numerical')