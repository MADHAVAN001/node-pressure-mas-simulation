function matrixA = formSingapore(a,b,Munich)
if nargin == 0
    Munich = evalin( 'base', 'Munich' );
end
matrixA = zeros(a,b);
for i = 1:216
    if(Munich(i,1)<=a && Munich(i,2)<=b)
        matrixA(Munich(i,1),Munich(i,2)) = 1;
    end
end