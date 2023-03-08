function [ Ep_Co, X ] = Build_Ep_Co(X)
%Build_Ep_Co Permitivity of Cobalt for a variable input

%   At microwave frequencies, we assume the permittivity is purely 
%   imaginary and a function of only the frequency and conductivity. 
%
%   Build_Ep_Co(X)
%   This function takes a table input X, which contains variable
%   information. Namely, a series of vector arrays that can be used to
%   build Ep.
%   
%   This code only considers the frequency F and the conductivity C. If
%   frequency is not specified in X, an error will occur. If C is not
%   specified, a default value shall be used. 
%
%   The output is based on Ep_Cobalt(F,C) and gives a multidimensional cell
%   array of size [length(F),length(C)] when both are specified.
%   
%   Conductivity    - Hz
%   Frequency       - Hz

%% Define Frequency and Conductivity
%   Extract frequency F array (in units of GHz)
[ F ] = Extract_Vars(X,'F');
%   Extract conductivity C array
[ C ] = Extract_Vars(X,'C');

%% Check If Arrays Were Not Defined
%   Frequency default (not set)
if isempty(F)
    %   Frequency has no default
    error('Must specify frequency F in table X, no default F defined');
end
%   Conductivity default
if isempty(C);    
    C = 1.438E17;   % Hz
    X.C = C;
end
%% Output Obtained by Ep_Cobalt function
[Ep_Co] = Ep_Cobalt(F,C);
end

