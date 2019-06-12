function slopemap = SlopeNonLoopFunction(DEM,dr)
% all done simultaneously, this is faster. But is not always possible
% (depends on complexity if it is or not, I think).
slopemap=zeros(DEM);
dzdx=zeros(DEM);
dzdy=zeros(DEM);
dzdx(:,2:-2)=(DEM(:,3:end)-DEM(:,1:-3))/(2*dr)
dzdy(2:-2,:)=(DEM(3:end,:)-DEM(1:-3,:)/(2*dr)
slopemap = sqrt((dzdx*dzdx)+(dzdy*dzdy))
