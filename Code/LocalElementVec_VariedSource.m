function [LocalVec_Source] = LocalElementVec_VariedSource(f, eID, msh)
%This code will generate the local element vector from the source term for
%   a given element number. This code is to be applied when the sourve term
%   varies lineary with x. LocalElementVec_Source.m should be used if the
%   source term is fixed.

%   Where eID is the element number.
%   msh is the mesh data structure calcualted using OneDimLinearMeshGen
%   f = constant of the source term

% Run this msh = OneDimLinearMeshGen(0,1,3); to generate test mesh


J = msh.elem(eID).J; % rawing in the Jacobian of the element being analysed

x0 = msh.elem(eID).x(1);
x1 = msh.elem(eID).x(2);

% Form the local source vector. The derrivation of this can be found in the corsework report part 2b.
LocalVec_Source = [(f*J*(1+(8/3)*x0+(4/3)*x1)) (f*J*(1+(8/3)*x0+(4/3)*x1))]; 


end

