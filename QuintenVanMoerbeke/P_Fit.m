% Real data
clearvars
clc
close all

[num,txt,raw] = xlsread('DataBoarWolves');
t = num(:,1);
N_data = num(:,2);
W_data = num(:,3);

data(:,1) = num(:,2); 
data(:,2) = num(:,3);

p0 = [0.48; 0.48/mean(W_data); 0.3; 0.3/mean(N_data); mean(N_data); mean(W_data)];
fminOptions=optimset('MaxFunEvals',10e3,'Display','iter');
[x,fval,exitflag] = fminsearch(@(p0)error_fun(p0,t,N_data,W_data),p0,fminOptions);
%B = lsqcurvefit(@test,p0,t,data);
[t,yfit] = ode45(@(t,y)ode_fit(t,y,x),t,x(5:6));

figure(7)
plot(t,N_data)
hold on
plot(t,W_data)
plot(t,yfit(:,1))
plot(t,yfit(:,2))
%plot(t,W_data)
%plot(t,yfit(:,1))