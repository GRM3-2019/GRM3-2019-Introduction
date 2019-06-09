% Solve the boar population with hunting!
clearvars
clc
close all

r = 0.48;
N_ini = 50e3;
N_store = [];
T_store = [];

N = N_ini;
time = 0;
iter = 0;
dt=1; %years

alpha = 0.98*r; % change this

while time<100
    iter = iter+1;
    time=time+dt;
    H=N*alpha;
    dN=r*N-H;
    N=N+dN*dt;
    N_store(iter)=N;
    T_store(iter)=time;
end

figure;
plot(T_store,N_store)