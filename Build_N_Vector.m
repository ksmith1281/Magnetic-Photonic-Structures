function [N_vec,ABC,X] = Build_N_Vector(X)
%Build_N_Vector N Vector for variable Input

%   Build_N_Vector(X)
%   This function takes a table input X, which contains variable
%   information. Namely, a series of vector arrays that can be used to
%   build the N vector.
%   
%   This code only considers Theta (T) and Phi (P)
%% Define Theta and Phi
%   Extract angle theta T array
[ T ] = Extract_Vars(X,'T');
%   Extract angle phi P array
[ P ] = Extract_Vars(X,'P');

%% Check If Arrays Were Not Defined
%   Theta default
if isempty(T)
    T = 0;  % Degrees
    X.T = T;
end
%   Phi default
if isempty(P);    
    P = 0;  % Degrees
    X.P = P;
end
%% Output Obtained by Ep_Cobalt function
[N_vec,ABC] = N_vector(T,P);
end

