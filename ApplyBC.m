function [Global_Mat, Global_Vec] = ApplyBC(BC1T,BC1V,BC2T,BC2V, Data, Global_Mat, Global_Vec)
% This function will apply  boundary conditions to a transient 1D FEM model
%   Where;
%   BC1T is the type of boundary condition 1 at the position x0. This will
%   either be 1 for Dirichlet or 2 for Neumann.
%
%   BC1V is the value that boundary condition 1 is set to. This is either
%   the direct value of Cfirst in the case of a Dirichlet boundary condition or
%   the value of D(dc/dx) in the case of a Neumann boundary condition.
%
%   BC2T is the type of boundary condition 2 at the position x1. This will
%   either be 1 for Dirichlet or 2 for Neumann.
%
%   BC2V is the value that boundary condition 2 is set to. This is either
%   the direct value of Clast in the case of a Dirichlet boundary condition or
%   the value of D(dc/dx) in the case of a Neumann boundary condition.
%
%   Global_Mat = problem global matrix
%   Global_Vec = problem global vector


%BOUNDARY CONDITION 1
if BC1T == 'D' % Check if the first boundary is a Dirichlet boundary
    Global_Mat(1,:) = 0; % Set the top row of the global matrix to 0
    Global_Mat(1) = 1; % Set the top diagonal of the global matrix to 1
    Global_Vec(1) = BC1V; % Set the top value of the global source vector to the input value of BC1
elseif BC1T == 'N' % Check if the first boundary is a Neumann boundary
    Global_Vec(1) = Global_Vec(1) + -BC1V; % add the value of -D(dc/dx)x=0 to the first element of the source term vector
else % If neither 1 or 2 are entered for BC1
    error('Incorrect boundary condition type entered for BC1. Enter either D for a Dirichlet boundary condition or N for a Neumann boundary condition')
end

%BOUNDARY CONDITION 2
if BC2T == 'D' % Check if the second boundary is a Dirichlet boundary
    Global_Mat(end,:) = 0; % Set the top row of the global matrix to 0
    Global_Mat(end) = 1; % Set the bottom diagonal of the global matrix to 1
    Global_Vec(end) = BC2V; % Set the top value of the global source vector to the input value of BC1
elseif BC2T == 'N' % Check if the second boundary is a Neumann boundary
    Global_Vec(end) = BC2V; % add the value of D(dc/dx)x=1 to the last element of the source term vector
else % If neither 1 or 2 are entered for BC1
    error('Incorrect boundary condition type entered for BC2. Enter either D for a Dirichlet boundary condition or N for a Neumann boundary condition')
end

end