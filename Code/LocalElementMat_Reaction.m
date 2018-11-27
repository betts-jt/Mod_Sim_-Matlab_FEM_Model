function [LocalElementMat_Reaction] = LocalElementMat_Reaction(lambda, eID, msh)
%This fuction calculates the local 2-by-2 element matrix for the reaction 
%operator, which can calculate this matrix for an arbitrary element eN 
%defined between the points x0 and x1
%   llambda = scalar coefficient
%   En = local element number
%   msh = mesh data structure calcualted using
%       OneDimLinearMeshGen. From this mesh each elements Jacobian and the
%       nodal posisions x0 and x1 can be accesed.

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

% IMPLIMENTING GAUSSIAN QUADRATURE
N=2;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature

% Setting up initial values of the local element matrix
Int00 = 0;
Int01 = 0;
Int11 = 0;

for k=1:N
    Int00 = Int00 + gq.wi(k) * (lambda*J/4) * (1-gq.Xipt(k))^2;
    Int01 = Int01 + gq.wi(k) * (lambda*J/4) * (1-gq.Xipt(k))*(1+gq.Xipt(k));
    Int11 = Int11 + gq.wi(k) * (lambda*J/4) * (1+gq.Xipt(k))^2;
end

LocalElementMat_Reaction = [Int00 Int01; Int01 Int00]; % Generate the local element reaction matrix
end

