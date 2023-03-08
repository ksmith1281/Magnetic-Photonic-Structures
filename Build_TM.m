function [ TM ] = Build_TM(Layer,X)
%Build_TM generates a cell array containing the Transfer Matrix for
%various Maxwell Operator, frequency, and thickness.

%   [TM] = Build_TM(Layer,X)
%   The Build_TM function takes the input structure Layer, which is
%   generated from the Layerbank, and the variables in the table X, and
%   generates a 7-D cell array of 4 x 4 Transfer Matrices.
%   Because the maxwell operator is in general a function of 6 variables,
%   it accounts for 6 of the 7 dimensions being frequency (f), conductivity
%   (c), magnetic field (h), magnetic absorption (a), angle theta (t),
%   angle phi (p). The 7th dimension is the thickness (d). For more
%   information of the sub-variables, see Build_MO function.
%   
%   Although not all of these variables will be used, we will still
%   organized them in a specific order where they are indexed the same. The
%   order will be: F,C,H,A,T,P,D. This means that if I select the Transfer
%   Matrix as TM{1,1,1,1,1,1,:}, I will call all the Transfer Matrices that
%   vary in thickness.
%   
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
%   Thickness size [meters]
nx = length(Layer.Size);

%% Is Size of Thickness Array Zero?
if eq(nx,0);
    error([Layer.Name,' must have its thickness defined by X or Layerbank']);
end
%% Pre-Allocation of Maxwell Operator MO
TM = cell(nf,nc,nh,na,nt,np,nx);
%% The for loops
% Frequency for loop
for ff=1:nf;
    % Conductivity for loop
    for cc=1:nc;
        % Mangetic Field for loop
        for hh=1:nh;
            % Magnetic Absorption for loop
            for aa=1:na;
                % Theta for loop
                for tt=1:nt;
                    % Phi for loop
                    for pp=1:np;
                        % Thickness for loop
                        for xx=1:nx;
                        %% Call Frequency, Thickness, and Maxwell Operator
                        f = X.F(ff);
                        x = Layer.Size(xx);
                        mo = Layer.MO{ff,cc,hh,aa,tt,pp};
                        %% Determine Transfer Matrix for each
                        TM{ff,cc,hh,aa,tt,pp,xx} = Transfer_Matrix(f,x,mo);
                        end
                    end
                end
            end
        end
    end
end
end

