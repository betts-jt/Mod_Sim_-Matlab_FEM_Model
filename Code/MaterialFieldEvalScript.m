%MaterialFieldEvalScript.m
%Script to help write solution for Tutorial 5, Part B.Q2

msh=OneDimLinearMeshGen(0,1,10); %Setup a 1D mesh with 10 elements
CreateGQScheme(1); %Create a Gaussian Quadrature scheme of order 1

%Create a linearly varying diffusion coefficient field and store it as a 
% vector, where each vector element corresponds to a global mesh node
msh.DCvec = 1 + msh.nvec;

xipt = gq.xi(1); %Select a Gauss point to test the function at
eID = 5; %Set an element ID to test the function for

%THIS IS THE FUNCTION YOU NEED TO WRITE - USE THESE INPUTS
val = EvalField(msh,msh.DCvec,eID,xi);