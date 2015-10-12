function matrix_i = calculate_matrix_i(node_incidence_matrix, path, start, num_paths, nodes)

matrix_i = zeros(num_paths,1);
for j = 1 : num_paths
    if(node_incidence_matrix(start,j) == -1 && node_incidence_matrix(path(1,1),j)==1)
        matrix_i(j,1) = 1;
    end
end
for i = 2:nodes
   for j = 1 : num_paths
       if(path(i,1) ~= 0) 
            if(node_incidence_matrix(path(i-1,1),j) == -1 && node_incidence_matrix(path(i,1),j)==1)
                matrix_i(j,1) = 1;
            end
       end
   end
end
end