### ------

# Magnetic-Photonic-Structures
This repository houses all the MATLAB code I used for my research and Dissertation on Magnetic Photonic Structures.

# Research Background

In RF circuits and integrated photonics, it is important to effectively control an
electromagnetic signal. This includes protecting of the network from high power and/or
undesired signal flow, which is achieved with device functionalities such as isolation,
circulation, switching, and limiting. In an attempt to develop light-weight, small-footprint, better
protection devices, new designs have been sought utilizing materials that have been otherwise
avoided due to some primary downside. For example, ferromagnetic metals like Iron and Cobalt,
despite being powerful magnets, have been completely shunned for uses in nonreciprocal devices
due to their overwhelming electric losses and high reflectivity. How could we utilize lossy
materials in electromagnetic applications?
In this thesis research, we design and fabricate metal-dielectric photonic structures in
which metal can be highly transmissive, while the desired response (e.g., magneto-photonic
response) is strongly enhanced. Moreover, the metal-dielectric structures can be designed to
exhibit a sharp transition from the induced transmission to broadband opacity for oblique
incidence and/or due to a tiny alteration of the photonic structure (e.g., because of nonlinearity).
Thus, the photonic structures can be tailored to produce collimation and power-limiting
effects.

How to use this MATLAB codeRuncode
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