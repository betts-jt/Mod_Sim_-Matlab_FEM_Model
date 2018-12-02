function [ Phi ] = EvalBasis(lnid,GP)
%EvalBasis Evaluates linear Lagrange basis functions
% Given the local node id (lnid) for a linear Lagrange element, and a gauss point (GP), returns the correpsonding value of the
% basis function for that local node.

% CHECK LOCAL NODE POINT AND ASSIGN BASIS GRADIENT AT THAT POINT
if lnid == 1
    Phi = (GP*(GP-1))/2;
elseif lnid == 2
    Phi = 1-GP^2;
elseif lnid == 3
    Phi = (GP*(GP+1))/2;
end
    
end