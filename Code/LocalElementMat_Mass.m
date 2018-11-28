function [LocalElementMat_Mass] = LocalElementMat_Mass(eID, msh)
% This function generates the local element mass matrix for a linear basis
% function. This is caluclated using gausian quadriture
%   llambda = scalar coefficient
%   eID = local element number

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

% Calculate the value of Int00/Int11. See coursework assignment 2 report,
% for derrivation of these values using gaussian quadrature.
Int00 = (2*J)/3;

% Calculate the value of Int01/Int10. See coursework assignment 2 report,
% for derrivation of these values using gaussian quadrature.
Int01 = (J)/3;

LocalElementMat_Mass = [Int00 Int01; Int01 Int00]; % Generate the local element mass matrix

end