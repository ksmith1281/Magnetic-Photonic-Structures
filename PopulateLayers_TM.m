function [Layer] = PopulateLayers_TM(Layer,X,SSopt)
%PopulateLayers_TM This generates all TM for specified layers in Structure.
%
%   [Layer] = PopulateLayers_TM(Layer,N_vec,X,SS)
%   This function takes in the Layerbank (labeled as Layer) in combination
%   with the N_vec and populates a Transfer Matrix for each layer. If a
%   structure string (SS) is specified, only those layers in the structure
%   string will be populated.
%   

% if isequal(SSopt,'all');
%     Layers_used = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
% else
    Layers_used = unique(SSopt);
% end
%%   Generate Cell Array of TM for only Layers_used

for k = 1:length(Layers_used);
    n = strfind([Layer.Hand], Layers_used(k));
    Layer(n).TM = Build_TM(Layer(n),X);
end
end

