function [ Layer, X ] = LayerBanktest(X)
%LayerBank This function accesses all of the information for each layer.

%   The LayerBank function uses the structure format of MATLAB to house all
%   the information of a give layer. New layers can also be added to this
%   'Database' so as long as it includes the following in order:
%
%   Name, Sequence Number, Handle, Info, Thickness, Epsilon, Mu
%
%   The input X is a table that contains all the variables to be used. 
%   
%   Use the following line of code to create vector array for thickness:
%   
%   Layer(n).Size = Extract_Vars(X,'D');
%   
%   Where 'D' is referring to the label used from Runcode

%% Problems with Code

%   - Regarding thickness, how does Runcode know what labels corresponds to
%     what materials?

%% Error Check
% Is X a table?
if ~istable(X);
    error('Input X must be a table');
end
%% Define Thickness

%% LISTING

%   01 - A - Air
%   02 - B - Alumina
%   03 - C - Cobalt
%   04 - D - 
%   05 - E - 
%   06 - F - Ferrite (mu Cobalt)
%   07 - G - Glass (Substrate)
%   08 - H - High Dielectric (Ceramic)
%   09 - I -
%   10 - J -
%   11 - K - Aluminium Oxide (Optics)
%   12 - L - 
%   13 - M - Metal (ep Cobalt)
%   14 - N -
%   15 - O - Titanium Oxide (Optics)
%   16 - P - Platium (Optics)
%   17 - Q - Quartz
%   18 - R - Silicon (For THz)
%   19 - S - Substrate (Sapphire)
%   20 - T - Titanium
%   21 - U -
%   22 - V - Vanadium Oxide (For THz)
%   23 - W -
%   24 - X - TPX Low Dielectric (For THz)
%   25 - Y - GaAs
%   26 - Z - Zinc Oxide (Optics)

% -------------------------------------------------------------- %

%% 01 - A - Air
% Air is a simple dielectric with index of refraction equal to 1.
n = 01;

Layer(n).Name = 'Air';
Layer(n).Seqn = '01';
Layer(n).Hand = 'A';
Layer(n).Info = 'Dielectric';
Layer(n).Size = Extract_Vars(X,'D',3E-3);
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 02 - B - Alumina
% Alumina is a simple dielectric. 
% Index of refraction is 3.14
% Permittivity is 3.14^2 = 9.8596
% Permeability is  1. 
n = 02;

Layer(n).Name = 'Alumina';
Layer(n).Seqn = '02';
Layer(n).Hand = 'B';
Layer(n).Info = 'Dielectric';
Layer(n).Size = 4E-3;
Layer(n).MSiz = 1;
Layer(n).Ep = {9.8596*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 03 - C - Cobalt
%   Cobalt is setup for Microwave Frequencies.
%   Epsilon is a function of Frequency (F) and Conductivity (C).
%   Mu is a function of Frequency (F), Magnetic Field (H), and Magnetic
%   Absorption (A).

n = 03;

Layer(n).Name = 'Cobalt';
Layer(n).Seqn = '03';
Layer(n).Hand = 'C';
Layer(n).Info = 'Ferromagnetic';
Layer(n).Size = 100E-9;
Layer(n).MSiz = 1;
[Layer(n).Ep, X] = Build_Ep_Co(X);
[Layer(n).Mu, X] = Build_Mu_Co(X);
%% 04 - D - 
% Description Here
n = 04;

Layer(n).Name = '';
Layer(n).Seqn = '04';
Layer(n).Hand = 'D';
Layer(n).Info = '';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 05 - E - 
% Description Here
n = 05;

Layer(n).Name = '';
Layer(n).Seqn = '05';
Layer(n).Hand = 'E';
Layer(n).Info = '';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 06 - F - Ferrite
% Ferrite is a template for a ferromagnet with little to no losses coming
% from the permittivity. We simulate this with a Permeability of Cobalt but
% with a permittivity at about 12.
n = 06;

Layer(n).Name = 'Ferrite';
Layer(n).Seqn = '06';
Layer(n).Hand = 'F';
Layer(n).Info = 'Ferrite';
Layer(n).Size = 100E-9;
Layer(n).MSiz = 1;
Layer(n).Ep = {12*eye(3)};
Layer(n).Mu = {1*eye(3)};%Cobalt_Mu(f,h,alpha);

%% 07 - G - Glass (Substrate)
% This is a simple dielectric used as a substrate. This means the layer
% small ( < 1 mm). We used the parameters of Fused Silica (Quartz) whose
% permitivity is about 3.75, permeability is 1.
n = 07;

Layer(n).Name = 'Glass (Substrate)';
Layer(n).Seqn = '07';
Layer(n).Hand = 'G';
Layer(n).Info = 'Substrate';
Layer(n).Size = 518E-6;
Layer(n).MSiz = 1;
Layer(n).Ep = {3.75*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 08 - H - Ceramic (High Dielectric)
% Ceramic refers to a high dielectric ceramic material. This material was
% used in our visit to Grenoble in Fall 2013. The material is has a
% permittivity of 38.09 with a loss tangent of about 0.00025. This loss
% tangent implies an imaginary epsilon of ~0.0095. 
n = 08;

Layer(n).Name = 'Ceramic (High Dielectric)';
Layer(n).Seqn = '08';
Layer(n).Hand = 'H';
Layer(n).Info = 'Dielectric';
Layer(n).Size = 1.018E-3;
Layer(n).MSiz = 1;
Layer(n).Ep = {(38.09+0.0095*1i)*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 09 - I - 
% Description Here
n = 09;

Layer(n).Name = '';
Layer(n).Seqn = '09';
Layer(n).Hand = 'I';
Layer(n).Info = '';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 10 - J - 
% Description Here
n = 10;

Layer(n).Name = '';
Layer(n).Seqn = '10';
Layer(n).Hand = 'J';
Layer(n).Info = '';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 11 - K - Aluminium Oxide (Optics)
% Aluminium Oxide or Alumina used for Optics. Alumina in optical
% frequencies is slightly Birefringent (no considered here) with an index
% of refraction of about 1.8.
% The permittivity is 1.8^2 = 3.24
n = 11;

Layer(n).Name = 'Aluminium Oxide (Optics)';
Layer(n).Seqn = '11';
Layer(n).Hand = 'K';
Layer(n).Info = 'Dielectric';
Layer(n).Size = 138.9E-9;
Layer(n).MSiz = 1;
Layer(n).Ep = {3.24*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 12 - L - 
% Description Here
n = 12;

Layer(n).Name = '';
Layer(n).Seqn = '12';
Layer(n).Hand = 'L';
Layer(n).Info = '';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 13 - M - Metal (Cobalt)
% This is a basic metal simulating only the epsilon component of Cobalt. We
% use this to remove the magnetic component (mu) from Cobalt.
n = 13;

Layer(n).Name = 'Metal';
Layer(n).Seqn = '13';
Layer(n).Hand = 'M';
Layer(n).Info = 'Metal';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 14 - N - 
% Description Here
n = 14;

Layer(n).Name = '';
Layer(n).Seqn = '14';
Layer(n).Hand = 'N';
Layer(n).Info = '';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 15 - O - Titanium Oxide (Optics)
% Titanium Oxide is a high dielectric material in optics with an index of
% refraction of 2.5. 
% Permittivity is 2.5^2 = 6.25
n = 15;

Layer(n).Name = 'Titanium Oxide';
Layer(n).Seqn = '15';
Layer(n).Hand = 'O';
Layer(n).Info = 'Dielectric';
Layer(n).Size = 100E-9;
Layer(n).MSiz = 1;
Layer(n).Ep = {6.25*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 16 - P - Platinum (Optics)
% Platinum is a metal used for optics regime. For a wavelength of 633 nm, the
% index of refraction is about 2.3229+4.1761*1i. These values are of course
% subject to change with changing wavelength (Frequency).
n = 16;

Layer(n).Name = 'Platinum';
Layer(n).Seqn = '16';
Layer(n).Hand = 'P';
Layer(n).Info = 'Metal';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = (2.3229+4.1761*1i)^2; 
Layer(n).Mu = 1*eye(3);

%% 17 - Q - Quartz
% Description Here
n = 17;

Layer(n).Name = 'Quartz';
Layer(n).Seqn = '17';
Layer(n).Hand = 'Q';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 18 - R - Name
% Description Here
n = 18;

Layer(n).Name = 'Name';
Layer(n).Seqn = '18';
Layer(n).Hand = 'R';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 19 - S - Name
% Description Here
n = 19;

Layer(n).Name = 'Name';
Layer(n).Seqn = '19';
Layer(n).Hand = 'S';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 20 - T - Name
% Description Here
n = 20;

Layer(n).Name = 'Name';
Layer(n).Seqn = '20';
Layer(n).Hand = 'T';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = 1*eye(3);
Layer(n).Mu = 1*eye(3);

%% 21 - U - Name
% Description Here
n = 21;

Layer(n).Name = 'Name';
Layer(n).Seqn = '21';
Layer(n).Hand = 'U';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 22 - V - Name
% Description Here
n = 22;

Layer(n).Name = 'Name';
Layer(n).Seqn = '22';
Layer(n).Hand = 'V';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 23 - W - Name
% Description Here
n = 23;

Layer(n).Name = 'Name';
Layer(n).Seqn = '23';
Layer(n).Hand = 'W';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 24 - X - Name
% Description Here
n = 24;

Layer(n).Name = 'Name';
Layer(n).Seqn = '24';
Layer(n).Hand = 'X';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 25 - Y - Name
% Description Here
n = 25;

Layer(n).Name = 'Name';
Layer(n).Seqn = '25';
Layer(n).Hand = 'Y';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};

%% 26 - Z - Name
% Description Here
n = 26;

Layer(n).Name = 'Name';
Layer(n).Seqn = '26';
Layer(n).Hand = 'Z';
Layer(n).Info = 'Type';
Layer(n).Size = 1;
Layer(n).MSiz = 1;
Layer(n).Ep = {1*eye(3)};
Layer(n).Mu = {1*eye(3)};



%% LOOP BASED ADDITIONS TO LAYERBANK
% Zero4=zeros(4,4);
% for j=1:26;
% %% Pre-Allocation for Maxwell Operator and Transfer Matrix
% % might be unnecessary
%     Layer(j).MO = Zero4;
%     Layer(j).TM = Zero4;
% end
%% Check DataBank
% clear LBName LBSeqn LBHand  LBType LBSize LBMSiz
% 
% for j=1:26;
%     LBName(j,:) = cellstr(Layer(j).Name);
%     LBSeqn(j,:) = cellstr(Layer(j).Seqn);
%     LBHand(j,:) = cellstr(Layer(j).Hand);
%     LBType(j,:) = cellstr(Layer(j).Info);
%     LBSize(j,:) = (Layer(j).Size);
%     %LBEp(j,:) = (Layer(j).Ep);
% end
% 
% LBTable = table(LBSeqn,LBHand,LBName,LBType,LBSize);
% LBTable.Properties.VariableNames = {'Num' 'Hand' 'Name' 'Type' 'Epsilon'};
% LBTable.Properties.VariableUnits = {'' '' '' '' 'm'};
% 


