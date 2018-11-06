function [LocalVec_Source] = LocalElementVec_Source(f, eID, msh)
%This code will generate the local element vector from the source term for
%a given element number.
%   Where eID is the element number.
%   msh is the mesh data structure calcualted using OneDimLinearMeshGen
%   f = constant of the source term

% Run this msh = OneDimLinearMeshGen(0,1,3); to generate test mesh

J = msh.elem(eID).J; % rawing in the Jacobian of the element being analysed

LocalVec_Source = [f*J f*J]; % Form the local source vector. The derrivation of this can be found in the corsework report part 1c.


end

