function path_capacity_matrix = path_capacity( A,a,imax )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
path_capacity_matrix = zeros(a,a);
for i=1:a
    for j=1:a
        tmp = randi(imax)+1;
        path_capacity_matrix(i,j) = tmp*A(i,j);
        path_capacity_matrix(j,i) = tmp*A(j,i);
    end
end
end

