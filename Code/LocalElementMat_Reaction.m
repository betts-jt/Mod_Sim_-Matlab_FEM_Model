function [LocalElementMat_Reaction] = LocalElementMat_Reaction(llambda, eID, msh)
%This fuction calculates the local 2-by-2 element matrix for the reaction 
%operator, which can calculate this matrix for an arbitrary element eN 
%defined between the points x0 and x1
%   llambda = scalar coefficient
%   eID = local element number
%   msh = mesh data structure calcualted using
%       OneDimLinearMeshGen. From this mesh each elements Jacobian and the
%       nodal posisions x0 and x1 can be accesed.

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

% Calculate the value of Int00/Int11. See coursework assignment report, part 1b,
% for derrivation of this short hand integral.
Int00 = llambda*J*2/3; 
% Calculate the value of Int01/Int10. See courseworw assignment, part 1b,
% for derrivation of this short hand integral.
Int01 = llambda*J*1/3; 

LocalElementMat_Reaction = [Int00 Int01; Int01 Int00]; % Generate the local element reaction matrix
end

