function yt=PP_ode45_H(t,y,r,c,e,d,alfa)
yt=zeros(2,1);
yt(1)=r.*y(1) - c.*y(1).*y(2)-alfa*r;  %whereby y(1)=N y(2)=W
yt(2)=e.*y(1).*y(2) - d.*y(2);
end
% 
% dN=r.*N-alpha*N;
% N=N+dN*dt;