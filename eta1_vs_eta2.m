%Dijkstra Path test
num_nodes = 12;
max_capacity = 5;
alpha = 1;
num_iterations = 11;
traffic_A = zeros(11,1);
traffic_node_1 = zeros(num_iterations,1);

beta_AR = 0.5;
k_paths = 5;


total_num_vehicles = 150;

%initialization
A = formA(num_nodes,num_nodes);%formSingapore(182,182,Munich); %formA(num_nodes,num_nodes);
[node_incidence_matrix,num_paths] = node_incidence(A,num_nodes);
distance = compute_path_cost(A,num_nodes,num_nodes);
path_capacity_matrix = path_capacity(A,num_nodes,max_capacity);
node_capacity_matrix = node_capacity(num_nodes,max_capacity);
vehicle_positions = zeros(num_nodes,total_num_vehicles);
start_end = zeros(2,total_num_vehicles);
        
Xmatrix = zeros(num_paths,total_num_vehicles);    

eta_1 = 0.5;
eta_2 = 1;

%randomly generating start and end destinations
for j=1:total_num_vehicles
    [start,ending] = formB(num_nodes, node_incidence_matrix, num_paths);
    start_end(1,j) = start;
    start_end(2,j) = ending;
end

for eta_2 = 0.25:0.25:1
    for eta_1 = 0.1:0.1:1
        node_pressure_type1 = zeros(num_nodes,1);
        
        number_nodes_eta = floor((1-eta_1)*num_nodes);
        %Dijkstra with node pressure
        Xmatrix_1 = zeros(num_paths,total_num_vehicles);
        
        traffic_severity_1 = zeros(20,1);
        
        node_pressure = zeros(num_nodes,1);
        number_vehicles_eta = floor((1-eta_2)* total_num_vehicles);
        
        %plain Dijkstra for the vehicles not under control    
        for j=1:number_vehicles_eta
            [start,ending] = formB(num_nodes, node_incidence_matrix, num_paths);
            start_end(1,j) = start;
            start_end(2,j) = ending;
            path_planning = Dijkstra_path(A,distance,num_nodes,start,ending, node_pressure);
            vehicle_positions(:,j) = path_planning;
            Xmatrix(:,j) = calculate_matrix_i(node_incidence_matrix,path_planning,start, num_paths, num_nodes);
        end
        
        
        %     %A+ calculation
        A_plus_matrix = A_plus_calculation(node_incidence_matrix,num_nodes,num_paths);
        X_summation = sum(Xmatrix,2);
        %     traffic_severity_A = (A_plus_matrix * X_summation) - node_capacity_matrix;
        %     traffic_repulsion = (A_plus_matrix * X_summation);
        %
        
        node_pressure = zeros(num_nodes,1);
        vehicle_positions_pressure = zeros(num_nodes,total_num_vehicles);
        
        X_summation_1 = X_summation;
        Xmatrix_1 = Xmatrix;
        for j = 1:20
            X_summation_1 = sum(Xmatrix_1,2);
            %
            traffic_1 = A_plus_matrix * X_summation_1;
            traffic_1 = traffic_1 - node_capacity_matrix;
            %
            
            for k = number_nodes_eta+1:num_nodes
                node_pressure_type1(k,1) = node_pressure_type1(k,1) + alpha * traffic_1(k,1);
            end
            
            for k=number_vehicles_eta+1:total_num_vehicles
                start = start_end(1,k);
                ending = start_end(2,k);
                path_planning_1 = Dijkstra_path(A,distance,num_nodes,start,ending, node_pressure_type1);
                vehicle_positions_pressure(:,k) = path_planning_1;
                Xmatrix_1(:,k) = calculate_matrix_i(node_incidence_matrix,path_planning_1,start, num_paths, num_nodes);
            end
            
            %
            for tmp = 1: num_nodes
                if(traffic_1(tmp,1) > 0)
                    traffic_severity_1(j,1) = traffic_severity_1(j,1) + exp(traffic_1(tmp,1));
                end
            end
            
        end
        traffic_node_1(round(eta_1*10),round(eta_2*4)) = traffic_severity_1(20,1);
    end
    %
end

%Dijkstra affected nodes
Dijkstra_num_affected = zeros(num_nodes,1);
x_matrix = zeros(num_iterations,1);
for i=1:10
    %Dijkstra_num_affected(i,1) = traffic_initial;
    x_matrix(i,1) = i/10;
end

performance = zeros(200,1);

x = x_matrix;

y1 = 6 * log(traffic_node_1(:,1));
y2 = 6 * log(traffic_node_1(:,2));
y3 = 6 * log(traffic_node_1(:,3));
y4 = 6 * log(traffic_node_1(:,4));

% y1 = traffic_AR_total;
% y2 = traffic_rksp_total;
% y4 = traffic_ebrksp_total;
% y3 = traffic_node_1;

% y1 = traffic_node_1;
% y2 = traffic_node_2;
% y3 = traffic_node_3;

figure
plot(x,y1,x,y2,x,y3,x,y4)
% plot(x,log(y1),x,log(y2),x,log(y3))
