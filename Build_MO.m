function [ MO ] = Build_MO(Layer,X,N_vector)
%Build_MO generates a cell array containing the Maxwell Operator for
%various Epsilon, Mu, and N Vectors.

%   [MO] = Build_MO(Layer,N_vector)
%   The Build_MO function takes the input structure Layer, which is
%   generated from the Layerbank, and the N vector to generate and organize
%   a cell array of various Maxwell Operators. The maxwell operator in
%   general is a function of all elements of the epsilon and mu tensors as
%   well as the first two elements of the N vector (n_z is not used). 
%
%   This code considers that of these three variables: Epsilon, Mu, and the
%   N vector, there are a fixed number of "sub-variables" or
%   "nested-variables". For example, although the Maxwell Operator is a
%   function of Epsilon, since Epsilon could be a function of frequency, we
%   must show this here.
%
%   Here are the maximum assumed sub-variables from each of the three:
%   Epsilon:
%   F - Frequency
%   C - Conductivity (also called sigma)
%   Mu:
%   F - Frequency
%   H - External Magnetic Field
%   A - Magnetic Absorption
%   N Vector:
%   T - Theta 
%   P - Phi
%
%   Although not all of these variables will be used, we will still
%   organized them in a specific order where they are indexed the same. The
%   order will be: F,C,H,A,T,P. This means that if I select the Maxwell
%   Operator as MO{1,1,1,:,1,1}, I will call all the Maxwell Operators that
%   vary in magnetic absorption.
%   
%   PROTOCOL FOR ADDING SUB-VARIABLES:
%   
%   If more sub-variables are desired, the size of each sub-variable can be
%   called from the size function of each variable (epsilon, mu, etc.).
%   Then, a new for loop must be added and properly indexed.
%
%   A note about future Epsilon and Mu:
%
%   Suppose that we consider a new material whose epsilon varies due to
%   some parameter x. How will we account for this? currently, the code
%   must consider this always in addition to the frequency f and
%   conductivity c. This means that the parameter x will become the third
%   variable despite said epsilon being a function of only x. 
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

%% Pre-Allocation of Maxwell Operator MO
MO = cell(nf,nc,nh,na,nt,np);
%% The for loops
% Phi for loop
for pp=1:np;
    % Theta for loop
    for tt=1:nt;
        % Magnetic Absorption for loop
        for aa=1:na;
            % Magnetic Field for loop
            for hh=1:nh;
                % Conductivity for loop
                for cc=1:nc;
                    % Frequency for loop
                    for ff=1:nf;
                        %% Call Epsilon, Mu, and N Vector
                        % Epsilon
                        if eq(numel(Layer.Ep),1);
                            % if Ep is constant
                            ep = Layer.Ep{1};
                        else
                            % if Ep varys with frequency and conductivity
                            ep = Layer.Ep{ff,cc};
                        end
                        % Mu
                        if eq(numel(Layer.Ep),1);
                            % if Mu is constant
                            mu = Layer.Mu{1};
                        else
                            % if Mu varys with frequency, Mag. Field, or
                            % Absorption.
                            mu = Layer.Mu{ff,hh,aa};
                        end
                        % N_vector
                        nv = N_vector{tt,pp};
                        %% Determine Maxwell Operator for each
                        MO{ff,cc,hh,aa,tt,pp} = Maxwell_Operator(ep,mu,nv);
                    end
                end
            end
        end
    end
end
end

