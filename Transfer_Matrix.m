function [ TM ] = Transfer_Matrix(f,d,MO)
%Transfer_Matrix is a function that takes the frequency, thickness, and
%Maxwell Operator in as inputs and outputs a 4 x 4 transfer matrix.

%   This function is based on the Vitebskiy's note on Electromagnetic Waves
%   in Stratified Media.
%
%   The inputs f and d are frequency and thickness; both of which must be
%   single array inputs (a single number). The input MO is the maxwell
%   operator and it must be a 4 x 4 matrix.
%
%   The units of f is Hz
%   The units of d is m

%% Defining the Transfer Matrix
%   The expm function as defined by MATLAB:
%   [V,D] = EIG(X) and EXPM(X) = V*diag(exp(diag(D)))/V

TM = expm((1i*2*pi*f/(3E8))*d*MO);
end
