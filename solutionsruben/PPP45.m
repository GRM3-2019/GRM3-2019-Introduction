function dpdt = PPP45(y,r1,r2,c1,c2,e,d)

dpdt = zeros(3,1);

dpdt(1)=r1.*y(1) - c1.*y(1).*y(2);

dpdt(2)=r2.*y(3) - c2.*y(3).*y(2);

dpdt(3)=e.*y(2)*(y(1) + y(3)) - d.*y(2);

end