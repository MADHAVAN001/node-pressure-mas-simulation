%test for rk

num_nodes = 5;
max_capacity = 4;
alpha = 0.2;
k_paths = 5;
total_num_vehicles = 100;

A = formA(num_nodes,num_nodes)
[node_incidence_matrix,num_paths] = node_incidence(A,num_nodes);
distance = compute_path_cost(A,num_nodes,num_nodes)
path_capacity_matrix = path_capacity(A,num_nodes,max_capacity);
node_capacity_matrix = node_capacity(num_nodes,max_capacity);
vehicle_positions = zeros(num_nodes,total_num_vehicles);
start_end = zeros(2,total_num_vehicles);
A_plus_calculation(node_incidence_matrix,num_nodes,num_paths)
node_pressure = zeros(num_nodes,1);

X_rksp = zeros(num_paths,total_num_vehicles);
X_ebrksp = zeros(num_paths,total_num_vehicles);
summation_X_matrix_tmp = zeros(num_paths, 1);
%A* with repulsion
for j=1:total_num_vehicles
    [start,ending] = formB(num_nodes, node_incidence_matrix, num_paths);
    start_end(1,j) = start;
    start_end(2,j) = ending;
    [path_planning_rksp, path_planning_ebrksp] = rksp( A, distance, num_nodes, start, ending, node_pressure, k_paths, num_paths, node_incidence_matrix, summation_X_matrix_tmp);
    %vehicle_positions(:,j) = path_planning;
    X_rksp(:,j) = calculate_matrix_i(node_incidence_matrix,path_planning_rksp,start, num_paths, num_nodes);
    X_ebrksp(:,j) = calculate_matrix_i(node_incidence_matrix,path_planning_ebrksp,start, num_paths, num_nodes);
    summation_X_matrix_tmp = sum(X_ebrksp,2)
    summation_X_matrix_tmp_1 = sum(X_rksp,2)
end