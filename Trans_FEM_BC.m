function [] = Trans_FEM_BC()
% This function will solve a simple transient FEM model

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 10; % Numeber of elements in the mesh
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.
Data.D = 1; % Setting D to the value of d

Data.SourceTermConstant = 1; % Value defining whether the source term is constant



end