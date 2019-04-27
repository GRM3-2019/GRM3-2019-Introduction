function dydt=PP_ode45(t,y,r,c,e,d)
dydt=zeros(2,1);
dydt(1)=r.*y(1) - c.*y(1).*y(2);  %whereby y(1)=N y(2)=W
dydt(2)=e.*y(1).*y(2) - d.*y(2);
end