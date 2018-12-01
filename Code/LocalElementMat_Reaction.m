function [LocalElementMat_Reaction] = LocalElementMat_Reaction(lambda, eID, msh, GN)
%This fuction calculates the local 2-by-2 element matrix for the reaction 
%operator, which can calculate this matrix for an arbitrary element eN 
%defined between the points x0 and x1
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
Int00 = 0; Int01 = 0; Int02 = 0;
Int10 = 0; Int11 = 0; Int12 = 0;
Int20 = 0; Int21 = 0; Int22 = 0;

for k=1:N
    GW = gq.wi(k); % Value of Gauss weight
    GP = gq.Xi(k); % Value of Gauss point
    % Calculating the new values by adding to the old ones
    Int00 = Int00 + GW * (lambda * J/4) * GP^2 * (GP-1)^2;
    Int01 = Int01 + GW * (lambda * J/2) * GP * (GP-1) * (1-GP^2);
    Int02 = Int02 + GW * (lambda * J/4) * GP^2 * (GP^2-1);
    Int10 = Int01;
    Int11 = Int11 + GW * (lambda * J) * (1-GP^2)^2;
    Int12 = Int21 + GW * (lambda * J/2) * GP * (GP+1) * (1-GP^2);
    Int20 = Int02;
    Int21 = Int12;
    Int22 = Int22 + GW * (lambda * J/4) * GP^2 * (GP+1)^2;
end

LocalElementMat_Reaction = [Int00,Int01,Int02;Int10,Int11,Int12;Int20,Int21,Int22]; % Generate the local element reaction matrix
end


