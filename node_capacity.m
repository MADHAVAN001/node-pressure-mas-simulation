function node_capacity_matrix = node_capacity( a, max_capacity )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
node_capacity_matrix = zeros(a,1);
for j=1:a
    tmp = randi(max_capacity)+1;
    node_capacity_matrix(j,1) = tmp;
end
end

