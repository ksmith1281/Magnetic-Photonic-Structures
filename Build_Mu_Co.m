function [ Mu_Co, X ] = Build_Mu_Co(X)
%Build_Mu_Co Permeability of Cobalt for a variable input

%   At microwave frequencies, we assume the permeability will have the
%   form found in Gurevich and Melkov. 

%   Build_Mu_Co(X)
%   This function takes a table input X, which contains variable
%   information. Namely, a series of vector arrays that can be used to
%   build Mu.
%   
%   This code only considers the frequency F, the magnetic field H, and the
%   absorption coefficient A (alpha).
%   
%   If frequency is not specified, a error will occur. For all others, a
%   default value will be assumed.
%
%   The output is based on Mu_Cobalt(F,H,Alpha) and gives a 
%   multidimensional cell array of size [length(F),length(H),length(A)]
%   when all three are specified.
%   
%   Frequency               - Hz
%   Magnetic Field          - Tesla
%   Absorption Coefficient  - no units

%% Define Frequency, Magnetic Field, and Absorption Coefficient
%   Extract frequency F array (Hz)
[ F ] = Extract_Vars(X,'F');
%   Extract Magnetic Field H array (Tesla)
[ H ] = Extract_Vars(X,'H');
%   Extract Absorption Coefficient A array (no units)
[ A ] = Extract_Vars(X,'A');

%% Check If Arrays Were Not Defined
%   Frequency default (not set)
if isempty(F)
    %   Frequency has no default
    error('Must specify frequency F in table X, no default F defined');
end
%   Magnetic Field default
if isempty(H);    
    H = 1.8;   % tesla
    X.H = H;
end
%   Absorption default
if isempty(A);    
    A = 0.027;   % no units
    X.A = A;
end
%% Output Obtained by Mu_Cobalt function
[Mu_Co] = Mu_Cobalt(F,H,A);
end

