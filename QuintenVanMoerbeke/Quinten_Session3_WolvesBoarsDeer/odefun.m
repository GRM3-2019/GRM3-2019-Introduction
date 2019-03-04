function dydt = odefun(t,y,r,c,d,e)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dydt = zeros(2,1);
dydt(1)=r*y(1)-c*y(2)*y(1);
dydt(2)=-d*y(2)+e*y(1)*y(2);

end

