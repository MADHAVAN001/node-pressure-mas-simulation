function A_cost = compute_path_cost( A,a,b )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A_cost = zeros(a,b);
for i=1:a
    for j=1:b
        imax = 999;
        tmp = randi(imax);
        binary_value = 50;
        A_cost(i,j) = mod(tmp,binary_value)*A(i,j);
        A_cost(j,i) = mod(tmp,binary_value)*A(j,i);
    end
end
end
