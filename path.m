function Astar_path = path( A,B,a,b,path_cost )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
optimal_path = 0;
node_matrix = zeroes(b,1);

for i=1:a
    if(B(i,1) == 1)
        start_node = i;
for i = 1:a
    if(B(i,1) == -1)
        end_node = i;
path_length = 0;
path = zeros(b,1);
optimal_path = 0;
position = 0;
path(position,1) = start_node;
visited_nodes = zeroes(b,1);
next_node = 0;

while(optimal_path == 1)
    if(start_node==end_node)
        optimal_path = 1;
        path_length = 0;
    current_node = path(position,1);
    if(current_node == end_node)
        optimal_path = 1;
    visited_nodes(current_node,1);
    min_length = 0;
    for j=1:b
        if(min_length>path_cost(current_node,j) && visited_nodes(j,1) ~= 1)
            min_length = path_cost(current_node,j);
            position = position+1;
            path(position,1) = j;          
    path_length += min_length;
    
end

