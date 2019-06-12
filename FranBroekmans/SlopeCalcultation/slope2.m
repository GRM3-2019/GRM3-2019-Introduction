
function slopematrix=slope(myDEM) 

sizerow=size(myDEM, 1);
sizecolumn=size(myDEM,2);
slopematrix=zeros(sizerow, sizecolumn);

%nestedforloopsslope
for row=2:sizerow-1; %nugaatgenaarbeneden
    for column=2:sizecolumn-1;
        xslope= myDEM(row,column+1)-myDEM(row,column-1);
        yslope= myDEM(row-1,column)-myDEM(row+1,column);
        slope=sqrt((xslope/180)^2+(yslope/180)^2);
        slopematrix(row,column)=slope;
    end
end
end
