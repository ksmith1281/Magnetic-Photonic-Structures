function [Layer] = PopulateLayers_MO(Layer,X,N_vec,SSopt)
%PopulateLayers_MO This generates all MO for specified layers in Structure.
%
%   [Layer] = PopulateLayers_MO(Layer,N_vec,SS)
%   This function takes in the Layerbank (labeled as Layer) in combination
%   with the N_vec and populates a Maxwell Operator for each layer. If a
%   structure string (SS) is specified, only those layers in the structure
%   string will be populated.
%   

if isequal(SSopt,'all');
    Layers_used = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
else
    Layers_used = unique(SSopt);
end
%%   Generate Cell Array of MO for only Layers_used

for k = 1:length(Layers_used);
    n = strfind([Layer.Hand], Layers_used(k));
    Layer(n).MO = Build_MO(Layer(n),X,N_vec);
end
end

