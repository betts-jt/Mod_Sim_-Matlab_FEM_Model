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
% Setting up initial values of the local element matrix
Int00 = 0;  Int01 = 0;  Int02 = 0;
Int10 = 0;  Int11 = 0;  Int12 = 0;
Int20 = 0;  Int21 = 0;  Int22 = 0;

for k=1:N
    GW = gq.wi(k);
    GP = gq.Xi(k);
    
    Phi(1) = (GP*(GP-1))/2;
    Phi(2) = 1-GP^2;
    Phi(3) = (GP*(GP+1))/2;
    
    % Calculating the first value (Int00) of the local element matrix
    Int00 = Int00 + GW*(Phi(1) * Phi(1) * J);
    Int01 = Int01 + GW*(Phi(1) * Phi(2) * J);
    Int02 = Int02 + GW*(Phi(1) * Phi(3) * J);
    Int10 = Int10 + GW*(Phi(2) * Phi(1) * J);
    Int11 = Int11 + GW*(Phi(2) * Phi(2) * J);
    Int12 = Int12 + GW*(Phi(2) * Phi(3) * J);
    Int20 = Int20 + GW*(Phi(3) * Phi(1) * J);
    Int21 = Int21 + GW*(Phi(3) * Phi(2) * J);
    Int22 = Int22 + GW*(Phi(3) * Phi(3) * J);
    
end

LocalElementMat_Mass = [Int00 Int01 Int02; Int10 Int11 Int12; Int20 Int21 Int22]; % Generate the local element mass matrix

end