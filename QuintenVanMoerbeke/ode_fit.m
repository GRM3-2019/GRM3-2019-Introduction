function dydt = ode_fit(t,y,p0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dydt = zeros(2,1);
dydt(1)=p0(1)*y(1)-p0(2)*y(2)*y(1);
dydt(2)=-p0(3)*y(2)+p0(4)*y(1)*y(2);
end

