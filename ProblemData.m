function [Data] = ProblemData()
% This code contains the relevent variables relating the the FEM solver and
% outputs these as a structure called Data.
%   
% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 3; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = 1; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 1; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.

end

