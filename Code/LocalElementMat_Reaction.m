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
% Setting up initial values of the local element matrix
Int00 = 0;  Int01 = 0;  Int02 = 0;
Int10 = 0;  Int11 = 0;  Int12 = 0;
Int20 = 0;  Int21 = 0;  Int22 = 0;

for k=1:N
    GW = gq.wi(k);
    GP = gq.Xi(k);
    
    % Run function to get Phi at each node
    for i = 1:gq.npts
        Phi(i) = EvalBasis(i, GP);
    end
    
    % Calculating the first value (Int00) of the local element matrix
    Int00 = Int00 + GW*(Phi(1) * Phi(1) * lambda*J);
    Int01 = Int01 + GW*(Phi(1) * Phi(2) * lambda*J);
    Int02 = Int02 + GW*(Phi(1) * Phi(3) * lambda*J);
    Int10 = Int10 + GW*(Phi(2) * Phi(1) * lambda*J);
    Int11 = Int11 + GW*(Phi(2) * Phi(2) * lambda*J);
    Int12 = Int12 + GW*(Phi(2) * Phi(3) * lambda*J);
    Int20 = Int20 + GW*(Phi(3) * Phi(1) * lambda*J);
    Int21 = Int21 + GW*(Phi(3) * Phi(2) * lambda*J);
    Int22 = Int22 + GW*(Phi(3) * Phi(3) * lambda*J);
end

% Generate the local element reaction matrix
LocalElementMat_Reaction = [Int00 Int01 Int02; Int10 Int11 Int12; Int20 Int21 Int22]; 
end


