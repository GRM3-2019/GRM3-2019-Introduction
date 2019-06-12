% make empty slopemap and preallocate
function slopemap = SlopeLoopFunction(DEM,dr)
slopemap=zeros(DEM);
dzdx=zeros(DEM);
dzdy=zeros(DEM);
for x=1:size(DEM,1)
    for y=1:size(DEM,2)
        dzdx(x,y)=(DEM(x+1)-DEM(x-1))/(2*dr)
        dzdy(x,y)=(DEM(y+1)-DEM(y-1))/(2*dr)
        slopemap(x,y)=sqrt((dzdx(x,y)*dzdx(x,y))+(dzdy(x,y)*dzdy(x,y)))
    end
end