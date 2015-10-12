function matrixA = formSingapore(a,b,ArcCon)
if nargin == 0
    ArcCon = evalin( 'base', 'ArcCon' );
end
matrixA = zeros(a,b);
for i = 1:37888
    if(ArcCon(i,1)<=a && ArcCon(i,2)<=b)
        matrixA(ArcCon(i,1),ArcCon(i,2)) = 1;
    end
end