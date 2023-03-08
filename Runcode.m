%% Runcode
%   
%

%% NOTES:
%   - The Program works in SI units. All functions are made to expect this
%   - Use of Extract_Vars() function may lead to empty entries when not
%   properly defined
%   - TM for each layer may have a different size when layers are given a
%   variable thickness. This causes a problem when creating the Total TM.
%   - A possible solution for the thicknesses is in the recent fix for the
%   Extract_Vars code. We are able to label now each thicknesses with D_A,
%   D_B, etc; where the A or B here are the labels used in the Layerbank. 
%   - Make sure each multi-for loop function has the fchatp in reverse.
%
%% Define the Structure String (SS)
%   The Structure String is a string of capital alphabetic characters made
%   to resemble the combination of layers we want to test. Each letter
%   represents a different layer and can be altered from the LayerBank.

SS = 'BABABABCBABABAB';

%% Define the Table X with variables
%   In this section, variables are written as vector arrays and stored in a
%   Table X. These vector arrays can be populated by a certain stepsize or
%   by a number of points
%
%   For vector array A,
%
%   By Stepsize:            A = A_min:A_stepsize:A_max;
%
%   By number of points:    A = linspace(A_min,A_max,number of points);
%   
%   All variables must be row arrays.

% EXAMPLES

%   Frequency (Hz)
F = linspace(2,15,1001)*10^9;
%   Conductivity (Hz)
C = linspace(1,10,10);
%   Magnetic Field (tesla)
H = linspace(1.8,2.0,2);
%   Magnetic Absorption (no units)
A = linspace(0,0.027,4);
%   Theta   (degrees) for Oblique Incidence
T = linspace(0,60,4);
%   Phi     (degrees) for Oblique Incidence
P = linspace(0,90,3);

%% Variables: Thickness
% To run the program with variable thickness, you must only use one
% variable thickness. Recall that defining an array of thicknesses here
% doesn't unless the Table X has that same thickness add.

%   (A) Air Thickness  
D_A = 1:4;
%   (B) Alumina Thickness  
D_B = 200:50:300;
%   (C) Cobalt Thickness
D_C = linspace(10,20,2)*1E-9;
%   (?) ------ Thickness
%   (?) ------ Thickness
%   (?) ------ Thickness
D = D_C;
%% Define the table X
%   The table X takes a variable number of inputs and stores them in a sort
%   of cell array with labels. The labels are based on what the variable is
%   labeled as. Here are the assumed variable names 
%   
%   F - Frequency (Hz)
%   C - Conductivity (Hz)
%   H - Magnetic Field (tesla)
%   A - Absorption Coefficient (no units)
%   T - Theta for Oblique Incidence (degrees)
%   P - Phi for Oblique Incidence (degrees)
%   B - Beta for Oblique Incidence (degrees)

%   All variables except frequency have default values when they are not
%   specified. Frequency must be specified in Table X.

X = table(F,H,P,D);

%% Define the Layer Bank with table X
%   The Layer bank is built to read the variables provided by table X and
%   use them where needed. The Layer bank is initially built with all
%   thickness, epsilon, and mu information completed

[Layer,X] = LayerBanktest(X);
%% N Vector
%   The N vector is a 1 x 3 vector matrix containing information regarding
%   oblique incidence. 

[N_vec,ABC,X] = Build_N_Vector(X);

%% Maxwell Operator

%   The Mawell Operator is determined using a set of three functions which
%   are each a sub-routine inside the next.
%   
%   1. Maxwell_Operator(ep,mu,nv)           - Creates each Maxwell Operator
%   2. Build_MO(Layer,N_vec)                - Build cell array MO per layer 
%   3. PopulateLayers_MO(Layer,N_vec,SS)    - Populates Layers with MO by SS 

%   (The deepest sub-routine is 1, then 2, then 3)

[Layer] = PopulateLayers_MO(Layer,X,N_vec,SS);

%% Transfer Matrix

%   The Transfer Matrix is determined using the same set of routines as the
%   Maxwell Operators, Here is the order of routines:
%   
%   1. Transfer_Matrix(f,d,MO)          - Creates each Transfer Matrix
%   2. Build_TM(Layer,X)                - Build cell array TM per layer 
%   3. PopulateLayers_TM(Layer,X,SS)    - Populates Layers with TM by SS 

%   (The deepest sub-routine is 1, then 2, then 3)

[Layer] = PopulateLayers_TM(Layer,X,SS);

%% Total Transfer Matrix

%   The Total Transfer Matrix code takes the Structure String SS as
%   instruction on matrix multiplication.

[TTM] = TotalTM(Layer,X,SS);

%% Outputs
