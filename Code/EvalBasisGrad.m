function [ dPsidXi ] = EvalBasisGrad(lnid, GP)
%EvalBasisGrad Returns gradient of basis functions
% Returns the gradients of the linear Lagrange basis functions for a
% specificed local node id (lnid = 0,1 or 3) and gauss point GP. For this case the
% differentials of tha basis gradient have been worked out by hand fomr the
% basis functions;
%   Phi(1) = (GP*(GP-1))/2;
%   Phi(2) = 1-GP^2;
%   Phi(3) = (GP*(GP+1))/2;

% CHECK LOCAL NODE POINT AND ASSIGN BASIS GRADIENT AT THAT POINT
if lnid == 1
    dPsidXi = GP-0.5;
elseif lnid == 2
    dPsidXi = -2*GP;
elseif lnid == 3
    dPsidXi = GP+0.5;
end
        
end