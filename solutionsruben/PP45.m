function dpdt = PP45(y,r,c,e,d)

dpdt = zeros(2,1);

dpdt(1)=r.*y(1) - c.*y(1).*y(2);  

dpdt(2)=e.*y(1).*y(2) - d.*y(2);

end