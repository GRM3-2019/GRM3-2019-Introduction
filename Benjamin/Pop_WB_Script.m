% Analytical solution to exponential population growth
clearvars
clc
close all

r=0.48;
sizeC=50e3;
eqPop=4;
N_Ini=50e3;
tot_eq_pop=11e6;

T_Neq=1/r*(log(tot_eq_pop)-log(N_Ini));
disp(num2str(T_Neq))
