function [N_vec,ABC] = N_vector(T,P)
%N_vector -  Gives a vector representation of the wave direction
%   
%   [N_vec]=N_vector(T,P)
%   This function has inputs of theta (T) and phi (P) as vector arrays and
%   outputs the N vector and various related components. Each output will
%   be a multi-dimensional cell array whose dimensions will be based on the
%   lengths of the theta and phi vector arrays.
%   Each entry of the cell will be a 3 x 1 vector matrix.
%
%   Currently, this code is only built to except units of degrees

%% Pre-Allocation of Cell Array
N_vec=cell(length(T),length(P));
ABC=cell(length(T),length(P));
%% For loops for N Vector
for tt = 1:length(T);
    theta = T(tt);      % Angle in degrees
    for pp = 1:length(P);
        phi = P(pp);  % Angle in degrees
        % Define the components
        n_x = sind(theta)*cosd(phi);
        n_y = sind(theta)*sind(phi);
        n_z = cosd(theta);
        % Put them in vector form
        n_v = [n_x,n_y,n_z];
        % Define the a,b,c's from the JDB Note
        a = n_x*n_y/n_z;
        b = (1-(n_x)^2)/n_z;
        c = (1-(n_y)^2)/n_z;
        % Define the abc vector
        abc = [a,b,c];
        % Put each vector in a cell array
        N_vec{tt,pp} = n_v;
        ABC{tt,pp} = abc;
    end
end
end

