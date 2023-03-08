function [ Var ] = Extract_Vars(X,Varname,varargin)
%Extract_Vars This function extracts a named variable from table X

%   The table X is a convenient way to store and view the variables (vector
%   arrays) used from the runcode. This function is made to extract any
%   named variable.
%   
%   If the specified Varname is not found in the table X, then the default
%   value will be used in it's place
%
%   The output will be a vector array, the same format as it is stored in
%   the Table X
%
%   If default value is not specified and the Varname is not found in X,
%   then the output Var will be []

% %% Is X a table?
% if ~istable(X);
%     error('Input X must be a table');
% end
%% Is Varname available in X?
% ind_X provides the index where Varname matches a VariableNames in table X
ind_X = strcmp(X.Properties.VariableNames,Varname);
% Convert X to a cell for reading.
XX=table2cell(X);
% Obtain Var as a vector array.
Var = cell2mat(XX(ind_X));
%% Default value
if isempty(Var)
    % varargin is a default setting
    Var = cell2mat(varargin);
end
end

