function [start,ending] = formB( b, node_incidence_matrix, num_paths )
% The matrix specifies the starting and the ending nodes 
% Forms the matrix with the required node values
start = randi(b);
ending = randi(b);
num_temp = 0;
while ( num_temp ==0)
    num_temp = 0;
    start = randi(b);
    for i= 1:num_paths
        if(node_incidence_matrix(start,i) == -1)
            num_temp = num_temp+1;
        end
    end
end

num_temp = 0;
while ( num_temp ==0)
    num_temp = 0;
    ending = randi(b);
    for i= 1:num_paths
        if(node_incidence_matrix(ending,i) == 1)
            num_temp = num_temp+1;
        end
    end
end


while(start == ending)
    start = randi(b);
    ending = randi(b);
end
%matrix_formation_B = zeroes(b,1);
%matrix_formation_B(start,1) = -1;
%matrix_formation_B(ending,1) = 1;
end

