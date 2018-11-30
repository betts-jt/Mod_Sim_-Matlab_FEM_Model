function [LocalElementMat_Mass] = LocalElementMat_Mass(eID, msh, GN)
% This function generates the local element mass matrix for a linear basis
%   llambda = scalar coefficient
%   eID = local element number
%   msh = mesh data structure calcualted using
%       OneDimLinearMeshGen. From this mesh each elements Jacobian and the
%       nodal posisions x0 and x1 can be accesed.

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

% IMPLIMENTING GAUSSIAN QUADRATURE
N=GN;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature

% Setting up initial values of the local element matrix
Int00 = 0;
Int01 = 0;
Int11 = 0;

for k=1:N
    Int00 = Int00 + gq.wi(k) * (J/4) * (1-gq.Xi(k))^2;
    Int01 = Int01 + gq.wi(k) * (J/4) * (1-gq.Xi(k))*(1+gq.Xi(k));
    Int11 = Int11 + gq.wi(k) * (J/4) * (1+gq.Xi(k))^2;
end

LocalElementMat_Mass = [Int00 Int01; Int01 Int00]; % Generate the local element mass matrix

end