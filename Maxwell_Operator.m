function [ MO ] = Maxwell_Operator(Ep,Mu,Nv)
%Build_MO This function builds the Maxwell Operator with Epsilon and Mu.

% the Maxwell Operator is a 4 x 4 matrix that is a function of the epsilon
% and mu elements (both of each are ordinarily 3 x 3 matrices). The Maxwell
% Operator is also a function of the oblique angles; specifically by way of
% unit vector directions n_x, n_y, and n_z.

% In Vitebskiy's document Electrodynamics of Stratified Media, the second
% page shows this Maxwell Operator in 4 constituent 2 x 2 matrices. In this
% script, we shall use this same notation. We shall label them as the
% following: MO = [ M_11 , M_12 ; M_21 , M_22 ]

%% Define the Independent Variables of the Function

% Epsilon
ep_xx = Ep(1,1); ep_xy = Ep(1,2); ep_xz = Ep(1,3);
ep_yx = Ep(2,1); ep_yy = Ep(2,2); ep_yz = Ep(2,3);
ep_zx = Ep(3,1); ep_zy = Ep(3,2); ep_zz = Ep(3,3);

% Mu
mu_xx = Mu(1,1); mu_xy = Mu(1,2); mu_xz = Mu(1,3);
mu_yx = Mu(2,1); mu_yy = Mu(2,2); mu_yz = Mu(2,3);
mu_zx = Mu(3,1); mu_zy = Mu(3,2); mu_zz = Mu(3,3);

% Direction vector (Nv)
n_x=Nv(1); n_y=Nv(2); % n_z is not used

%% Find M_11

M_11(1,1) = -(ep_zx/ep_zz)*n_x-(mu_yz/mu_zz)*n_y;
M_11(1,2) = (-(ep_zy/ep_zz)+(mu_yz/mu_zz))*n_x;
M_11(2,1) = -((ep_zx/ep_zz)-(mu_xz/mu_zz))*n_y;
M_11(2,2) = -(ep_zy/ep_zz)*n_y-(mu_xz/mu_zz)*n_x;

%% Find M_12

M_12(1,1) = mu_yx-(mu_zx*mu_yz/mu_zz)+(n_y*n_x/ep_zz);
M_12(1,2) = mu_yy-(mu_zy*mu_yz/mu_zz)-(n_x*n_x/ep_zz);
M_12(2,1) = -mu_xx+(mu_zx*mu_xz/mu_zz)+(n_y*n_y/ep_zz);
M_12(2,2) = -mu_xy+(mu_zy*mu_xz/mu_zz)-(n_x*n_y/ep_zz);

%% Find M_21

M_21(1,1) = -ep_yx+(ep_zx*ep_yz/ep_zz)-(n_y*n_x/mu_zz);
M_21(1,2) = -ep_yy+(ep_zy*ep_yz/ep_zz)+(n_x*n_x/mu_zz);
M_21(2,1) = ep_xx-(ep_zx*ep_xz/ep_zz)-(n_y*n_y/mu_zz);
M_21(2,2) = ep_xy-(ep_zy*ep_xz/ep_zz)+(n_x*n_y/mu_zz);

%% Find M_22

M_22(1,1) = -(ep_yz/ep_zz)*n_y-(mu_zz/mu_zz)*n_x;
M_22(1,2) = ((ep_yz/ep_zz)-(mu_zy/mu_zz))*n_x;
M_22(2,1) = ((ep_xz/ep_zz)-(mu_zx/mu_zz))*n_y;
M_22(2,2) = -(ep_zx/ep_zz)*n_x-(mu_zy/mu_zz)*n_y;

%% Define Maxwell Operator

MO = [ M_11 , M_12 ; M_21 , M_22 ];

end
