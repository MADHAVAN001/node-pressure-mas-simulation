function final_path = AR_path( A, distance, b, start_node, end_node, beta, repulsive_force)
%Dijkstra path planning
%   Detailed explanation goes here
b = int64(b);
node_distance_matrix = zeros(b,1);
previous_node = zeros(b,1);             %previous node for all the nodes are 0 in the beginning
node_distance_matrix(start_node,1) = 0; %distance matrix is initialized
previous_node(start_node,1) = -1;       %The previous node for the start node is undefined
unvisited_nodes = ones(b,1);            %All nodes are unvisited in the beginning
h_force = zeros(b,1);
node_pressure = zeros(b,1);

for i = 1:b
    final_path = Dijkstra_path( A, distance, b, i, end_node, node_pressure);
    tmp = final_path'*distance;
    h_force(i,1) = tmp(1,1);
end

node_pressure = h_force;

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
            alt = (1-beta)*(node_distance_matrix(current_node,1)+ distance(current_node,i)+node_pressure(i,1))+ beta*repulsive_force(i,1);
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
final_path = zeros(b,1);
for p=1:k
    final_path(p,1) = path_planning(b-k+p,1);
end
%final_path = Dijkstra_path( A, distance, b, i, end_node, node_pressure);
    
end

