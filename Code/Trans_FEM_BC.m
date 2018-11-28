function [] = Trans_FEM_BC(BC1T,BC1V,BC2T,BC2V, Data)
% This function will solve a simple transient FEM model
% conditions.
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

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 10; % Numeber of elements in the mesh
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction need to be calcualted or 0 is these are not needed.
Data.D = 1; % Setting D to the value of d
Data.SourceNeeded = 0; % Value is either 1 is the problem needs the local element vector due to source need to be calcualted or 0 is these are not needed.
Data.SourceTermConstant = 1; % Value defining whether the source term is constant

% Run the code that generated the Global Stiffness Matrix, Global mass matrix and Source vector afor a given set of input variables.
[Global_Mat, Global_Mat_K, Global_Mat_M, SourceGlobal_Vec] = GlobalElementGen(Data); 

% Calculate the matrix to multiply to the previous solution
A = Global_Mat_M-((1-Data.Theta)*Data.Delta_t*Global_Mat_K);

% Multiply the above by the previous solution
AC = A*c;



%BOUNDARY CONDITION 1
if BC1T == 1 % Check if the first boundary is a Dirichlet boundary
    Global_Mat(1,:) = 0; % Set the top row of the global matrix to 0
    Global_Mat(1) = 1; % Set the top diagonal of the global matrix to 1
    SourceGlobal_Vec(1) = BC1V; % Set the top value of the global source vector to the input value of BC1
elseif BC1T == 2 % Check if the first boundary is a Neumann boundary
    SourceGlobal_Vec(1) = SourceGlobal_Vec(1) + -BC1V; % add the value of -D(dc/dx)x=0 to the first element of the source term vector 
else % If neither 1 or 2 are entered for BC1
    error('Incorrect boundary condition type entered for BC1. Enter either 1 for a Dirichlet boundary condition or 2 for a Neumann boundary condition')
end

%BOUNDARY CONDITION 2
if BC2T == 1 % Check if the second boundary is a Dirichlet boundary
    Global_Mat(end,:) = 0; % Set the top row of the global matrix to 0
    Global_Mat(end) = 1; % Set the bottom diagonal of the global matrix to 1
    SourceGlobal_Vec(end) = BC2V; % Set the top value of the global source vector to the input value of BC1
elseif BC2T == 2 % Check if the second boundary is a Neumann boundary
    SourceGlobal_Vec(end) = BC2V; % add the value of D(dc/dx)x=1 to the last element of the source term vector
else % If neither 1 or 2 are entered for BC1
    error('Incorrect boundary condition type entered for BC2. Enter either 1 for a Dirichlet boundary condition or 2 for a Neumann boundary condition')
end

% SOLVING THE DIFFUSION-REACTION EQUATION
c =  Global_Mat\SourceGlobal_Vec; % Solve the equations to find the vector C


end