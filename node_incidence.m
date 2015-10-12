function [node_incidence_matrix, num_paths] = node_incidence( matrixA, num_nodes )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

num_paths = 0;
for i = 1:num_nodes
    for j = 1:num_nodes
        if(matrixA(i,j)~=0)
            num_paths = num_paths + 1;
        end
    end
end

path_computed = 1;
node_incidence_matrix = zeros(num_nodes,num_paths);
for i = 1:num_nodes
    for j= 1:num_nodes
        if(matrixA(i,j)~=0)
            node_incidence_matrix(i,path_computed) = -1;
            node_incidence_matrix(j,path_computed) = 1;
            path_computed = path_computed + 1;
        end
    end
end

end

