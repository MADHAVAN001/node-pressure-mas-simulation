function [final_path_final, entropy_final_path] = rksp( A_main, distance, b, start_node, end_node, node_pressure, k_paths, num_paths, node_incidence_matrix, summation_X_matrix_tmp)
%Dijkstra path planning
%Detailed explanation goes here
A = A_main;
final_path = zeros(b,k_paths);
for t = 1:k_paths
    b = int64(b);
    node_distance_matrix = zeros(b,1);
    previous_node = zeros(b,1);             %previous node for all the nodes are 0 in the beginning
    node_distance_matrix(start_node,1) = 0; %distance matrix is initialized
    previous_node(start_node,1) = -1;       %The previous node for the start node is undefined
    unvisited_nodes = ones(b,1);            %All nodes are unvisited in the beginning
    for i=1:b
        if(i ~= start_node)
            node_distance_matrix(i,1) = 99999;
            previous_node(i,1) = -1;
        end
    end
    num_iterations = b;
    while(num_iterations>0)
        min_distance = 999999; 
        current_node = 0;
        for i=1:b
            if(node_distance_matrix(i,1) < min_distance && unvisited_nodes(i,1)==1)
                min_distance = node_distance_matrix(i,1);
                current_node = i;
            end
        end
        unvisited_nodes(current_node,1) = 0;
        num_iterations = num_iterations-1;
        for i=1:b
            if(A(current_node,i) == 1 && unvisited_nodes(i,1) == 1)
                alt = node_distance_matrix(current_node,1)+ distance(current_node,i)+node_pressure(i,1);
                if(alt<node_distance_matrix(i,1))
                    node_distance_matrix(i,1) = alt;
                    previous_node(i,1) = current_node;
                end
            end
        end
    end
    path_planning = zeros(b,1);
    j = b-1;
    node_num = end_node;
    path_planning(b,1) = end_node;
    k = 1;
    while(node_num ~= -1)
        tmp_node = previous_node(node_num,1);
        node_num = tmp_node;
        if (tmp_node ==-1)
            break;
        end
        path_planning(j,1) = tmp_node;
        j = j-1;
        k = k+1;
    end
    for p=1:k
        final_path(p,t) = path_planning(b-k+p,1);
    end
    %tmp_node = final_path(2,t)
    %start_node
    %node_pressure(tmp_node,1) = 9999;
    %A(start_node,tmp_node) = 0;
    %iter = 1;
    %while iter == 1
    node_1 = final_path(2,t);
    node_2 = final_path(3,t);
%     min = 9999;
%     node_1 = 0;
%     node_2 = 0;
%     for p = 1:b-1
%         if final_path(p+1,t) ~= 0
%             if min > distance(p,p+1)
%                min = distance(p,p+1);
%                node_1 = p;
%                node_2 = p+1;
%             end
%         end
%     end
%     min2 = 9999;
%     if node_1 == 0 && node_2 == 0
%         for p = 1:b-1
%             if final_path(p+1,t) ~= 0
%                 if min2 > distance(p,p+1) && min2>min
%                     min2 = distance(p,p+1);
%                     node_1 = p;
%                     node_2 = p+1;
%                 end
%             end
%         end
%     end
%     min3 = 9999;
%     if node_1 == 0 && node_2 == 0
%         for p = 1:b-1
%             if final_path(p+1,t) ~= 0
%                 if min3 > distance(p,p+1) && min3>min2
%                     min3 = distance(p,p+1);
%                     node_1 = p;
%                     node_2 = p+1;
%                 end
%             end
%         end
%     end
    
    if node_1 ~= 0 && node_2 ~= 0
        A(node_1,node_2) = 0;
    end
end
%final_path;
imax = 9999;
tmp = randi(imax);
path_num = mod(tmp,k_paths);
final_path_final = final_path(:,path_num+1);
minimum_entropy = 90000;
minimum_entropy_path = 3;
for t = 1:k_paths
    i_matrix = calculate_matrix_i(node_incidence_matrix,final_path(:,t),start_node, num_paths, b);
    if minimum_entropy > sum(summation_X_matrix_tmp + i_matrix,1);
        minimum_entropy = sum(summation_X_matrix_tmp + i_matrix,1);
        minimum_entropy_path = t;
    end
end
%minimum_entropy_path
entropy_final_path = final_path(:,minimum_entropy_path)
end

