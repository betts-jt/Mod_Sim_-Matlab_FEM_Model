function [ dpsidxi ] = EvalBasisGrad(lnid, xi)
%EvalBasisGrad Returns gradient of basis functions
% Returns the gradients of the linear Lagrange basis functions for a
% specificed local node id (lnid = 0 or 1) and xipt (gradient is a constant
% value in this case, but for higher order basis functions, would vary
% with xi - and hence the argument is included for generality/future proofing)
%Use the node id to generate the sign of the basis gradient - ie.
%either + or -. when lnid=0, sign is -ve, when lnid=1, sign is +ve.

sign = (-1)^(lnid+1);
dpsidxi = 0.5 * sign; %Basis Function gradient at a given gauss point

end