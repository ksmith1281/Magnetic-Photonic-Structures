function [TTM] = TotalTM(Layer,X,SS)
%TotalTM Builds the Total Transfer Matris from Structure String SS
%   Detailed explanation goes here

%% HELP

%   -   Sometime later, I wonder if using n = strfind([Layer.Hand], SS(k));
%       inside the deepest for loop is best versus running this code once to
%       determine a row array of numbers corresponding to the structure (That
%       is ABC would become 123). Then, the same deep for loop would not run
%       strfind everytime but instead just call the index value inside the
%       predefined number array

%% Defining the sub-variable lengths by Table X
%   All variables used in code are in Table X

%   Frequency [Hz]
nf = length(X.F);
%   Conductivity [Hz]
nc = length(X.C);
%   Magnetic Field [Tesla]
nh = length(X.H);
%   Absorption Coefficient [no units]
na = length(X.A);
%   Oblique Angle Theta [Degree]
nt = length(X.T);
%   Oblique Angle Phi [Degree]
np = length(X.P);

%% Define Thickness Array
DD = {Layer.Size}; Dchk = ones(26,1);
for d = 1:26;
    if gt(length(DD{d}),1);
    Dchk(d) = length(DD{d});
    end
end
%   Thickness size [meters]
nd = length(Layer(Dchk~=1).Size);
%% Pre-Allocation of Maxwell Operator MO
TTM = cell(nf,nc,nh,na,nt,np,nd);

%% The for loops
% Phi for loop
for pp=1:np;
    % Theta for loop
    for tt=1:nt;
        % Mangetic Absorption for loop
        for aa=1:na;
            % Magnetic Absorption for loop
            for hh=1:nh;
                % Conductivity for loop
                for cc=1:nc;
                    % Frequency for loop
                    for ff=1:nf;
                        for dd=1:nd;
                            %   The Total Transfer Matrix is a 4 x 4 Matrix
                            ttm = eye(4);
                            %% Building the Total Transfer Matrix
                            for k = length(SS):-1:1;                            % # of Layers in Seq.
                                n = strfind([Layer.Hand], SS(k));               % Seqn. corresponding to Layer
                                ttm = ttm*Layer(n).TM{ff,cc,hh,aa,tt,pp};    % Matrix Multiplication of TM
                            end
                            TTM{ff,cc,hh,aa,tt,pp} = ttm;
                        end
                    end
                end
            end
        end
    end
end
end






