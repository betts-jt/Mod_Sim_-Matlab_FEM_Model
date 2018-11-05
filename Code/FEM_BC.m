function [] = FEM_BC(BC1T,BC1V,BC2T,BC2V)
% This code applies the FEM method and solved for a give set of boundary
% conditions.
%   Where;
%   BC1T is the type of boundary condition 1 at the position x0. This will
%   either be 'D' for Dirichlet or 'N' for Neumann.
%
%   BC1V is the value that boundary condition 1 is set to. This is either
%   the direct value of Cfirst in the case of a Dirichlet boundary condition or
%   the value of D(dc/dx) in the case of a Neumann boundary condition.
%
%   BC2T is the type of boundary condition 2 at the position x1. This will
%   either be 'D' for Dirichlet or 'N' for Neumann.
%
%   BC2V is the value that boundary condition 2 is set to. This is either
%   the direct value of Clast in the case of a Dirichlet boundary condition or
%   the value of D(dc/dx) in the case of a Neumann boundary condition.


end

