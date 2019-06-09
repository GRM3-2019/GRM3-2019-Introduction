function e = error_fun(p0,t,N_data,W_data)
%ERROR Summary of this function goes here
%   Detailed explanation goes here
y0 = p0(5:6);

[T,Y] = ode45(@(t,y)ode_fit(t,y,p0),t,y0);

err_N = N_data-Y(:,1);
err_W = W_data-Y(:,2);

e = err_N'*err_N + err_W'*err_W;

end

