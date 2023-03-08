# NUMERICAL ANALYSIS FOR MULTIFUNCTIONAL METAL-DIELECTRIC PHOTONIC STRUCTURES USING MATLAB

This document serves as background and explanation of my general PhD research and corresponding
MATLAB code. The numerical analysis necessary for this research required high level matrix multiplication
and linear algebra, thus MATLAB was chosen as a suitable platform. I will outline the research and logic
of each Matlab function and file. 

# Research Background

My PhD research worked with 1-D Photonic Structures with defects made to the periodic structure.
Such structures showcase interesting localization effects in the energy distribution, specifically
with high transmission for a given frequency. When a normally non-transmissive metallic layer is
considered, no transmission could occur, but when such a layer is placed at the location of this
defect, transmission can occur. Furthermore, due to the unique energy distribution, such a composite
structure can enable large magnetic properties that would otherwise not be used due to high reflective
or absorptive properties of the original magnetic layer.

This work was done within the microwave and RF ranges, specifically from 2 - 10 GHz. But principally
works for all frequencies with the appropriate size and choice of materials.

# Transfer Matrix Methods

The numerical analysis was done using transfer matrix methods: Each layer can be tried as a matrix, 
and a composite of layers would just be the matrix multiplication of each layer's transfer matrix in order,
yielding the 'Total Transfer Matrix' of the structure. We can then simulate incident wave propagation on
this total structure by simple matrix multiplication.

# Transfer Matrix of a single layer

To determine the Transfer Matrix for a single layer, we need to consider the properties of each layer.
This is done by building a 'Maxwell Operator' from the layer's permittivity (Ep) and permeability (Mu).
Note that the Ep and Mu are both functions of frequency for select layers.

# PROCEDURE

# Step 1: Defining Independant Variables (X) and Incident Wave Propagation (N_vec)

If our goal is to determine the total transfer matrix, we can build a procedure given some initial
inputs. This includes the range and step size of frequencies (F) considered, but could be expanded 
to include other variables such as applied external magnetic field (H), angles of oblique incidence (P),
and thickness (D). In the runcode.m, we define a table X that contains all the variables in an array format.

X = table(F,H,P,D);

Also, we need to define the normal vector of the wave propagation, N_vec: 

[N_vec,ABC,X] = Build_N_Vector(X)

# Step 2: Defining parameters for each layer in a MATLAB Struct "Layer"

Each layer's initial parameters are stored in a MATLAB Struct call "Layer" 
and can be called using a function called LayerBanktest. Since some layer's
parameters are dependent on the independent variables in X, we nee to take
the input X. Once "Layer" is built but LayerBanktest, you can use a predefined
handle,a single letter A-Z, to call information for each layer. This initially
includes the Ep and Mu of each layer. We can also store further layer information 
such as the Maxwell Operator and individual Transfer Matrix here. The total
structure will eventually be defined using a "Super String" (SS) of these handles.

[ Layer, X ] = LayerBanktest(X)

Add the Maxwell Operator (MO) and Transfer Matrix (TM) to Layer by:

[Layer] = PopulateLayers_MO(Layer,X,N_vec,SSopt)
[Layer] = PopulateLayers_TM(Layer,X,SSopt)

Both of these 'PopulateLayer' functions use Build MO and TM internally:

[ MO ] = Build_MO(Layer,X,N_vector)
[ TM ] = Build_TM(Layer,X)

# Step 3: Define Total Structure with 'SS' & Examples of Photonic Structures

The "Super String" or SS is a string that represents the total layered structure.
If we consider a periodic structure comprised of two layers, A and B, we could define
a unit cell 'AB' that we repeat N times. For example, an N=7 structure with unit cell
'AB' or 'BA' would look like:

ABABABABABABAB or BABABABABABABA

Often we considered a structure which was symmetric, by adding a single A or B layer
at the end:

ABABABABABABABA or BABABABABABABAB

Defects are breaks to this periodicity. A principal structure I considered was:

BABABABBABABAB

Such a structure showcases an interesting energy distribution at the defect,
specifically where the electric field energy is greatly reduced, while the magnetic
energy is strongly enhanced. We considered metallic magnets such as Cobalt at 
the location of the defect:

SS = 'BABABABCBABABAB'

# Step 4: Build the Total Transfer Matrix (TTM) for our SS

With our inputs Layer, X, SS, we simply call all the individual Transfer Matrices
from the Layer Struct and perform matrix multiplication, the order specificed by
the super string SS.

[TTM] = TotalTM(Layer,X,SS)

This Total Transfer Matrix can be used to determine important output variables, 
such as Transmission, Reflection, and Phase, but also magnetophotonic properties
such as Faraday rotation.
