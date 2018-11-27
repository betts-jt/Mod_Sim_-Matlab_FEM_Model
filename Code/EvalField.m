function [ val ] = EvalField(msh,field,eID,xipts)
%EvalField Evaluates a nodally stored scalar field at a given xi point in an element
% Evaluates a scalar data field (stored in field) that is represented on a linear Lagrange
% finite element mesh (msh), when given a xi coordinate and an element id

psi = [EvalBasis(0,xipts) EvalBasis(1,xipts)]; % Get vector containing basis function values at xipt

dpsidxi = [EvalBasis(0,xipts) EvalBasis(1,xipts)]; % Get vector containing basis function gradients at xipt

vcoeff = [field(msh.elem(eID).n(1)); field(msh.elem(eID).n(2))];
%Get nodal values for element eID

val = psi*vcoeff; %Dot product the two together to sum up the coefficients*basis functions to give the final interpolated value
end