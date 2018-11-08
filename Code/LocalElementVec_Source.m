function [LocalVec_Source] = LocalElementVec_Source(f, eID, msh)
%This code will generate the local element vector from the source term for
%a given element number.
%   Where eID is the element number.
%   msh is the mesh data structure calcualted using OneDimLinearMeshGen
%   f = constant of the source term

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

LocalVec_Source = [f*J f*J]; % Form the local source vector. 
% The derrivation of this can be found in the corsework report part 1c.

end

