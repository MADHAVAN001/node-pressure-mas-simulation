function matrix_formation_A = formA(a,b)
%Function created for formation of the matrix A for solving the first order
%equation AX = B in the vehicle routing problems
%Forms matrix A of dimensions a*b
matrix_formation_A = zeros(a,b);
for i=1:a
    for j=1:b
        imax = 9999;
        tmp = randi(imax);
        binary_value = mod(tmp,2);
        matrix_formation_A(i,j) = binary_value;
        matrix_formation_A(j,i) = binary_value;
        if(i==j)
            matrix_formation_A(i,j) = 0;
            matrix_formation_A(j,i) = 0;
        end
    end
end
end

