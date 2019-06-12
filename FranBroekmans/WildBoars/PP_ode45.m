function yt=PP_ode45(t,y,r,c,e,d)
yt=zeros(2,1);
yt(1)=r.*y(1) - c.*y(1).*y(2); 
yt(2)=e.*y(1).*y(2) - d.*y(2);
end
