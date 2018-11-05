function [] = GlobalElementGen(xmin, xmax, Ne, D, llambda, reactionNeeded)
% Given the relevent input paramenters this cod ewill generate the local
% element matracies for each element and combign these to form the global
% element matrix for both the diffution operator and the reaction operator
% if needed.
%   Where:
%   xmin = the mimimum value of x to be used when generating the mesh.
%   xmax = the maxmum value of x to be used when generating the mesh.
%   Ne = Number of elements to be used when generating the mesh.
%   D = Diffution operator used when generating the local element matracies
%       for diffution.
%   llambda = Scalar coefficient used when generating the lcoal element
%             matracies for reaciton operator.
%   ReactionNeeded = This is either 1 is the global element matrix for the
%                   reaction operator needs to be generatod or 0 if it does not need to be
%                   gerenated.

msh = OneDimLinearMeshGen(xmin,xmax,Ne); % Generate the mesh

for i = 1:Ne
    DiffusionMat(i) = LaplaceElemMatrix(D, i, msh); % Generate the local element diffution matrix for element i 
    
    if reactionNeeded == 1 % Check if the reaction matrix is required
        ReactionMat(i) = LocalElementMat_Reaction(llambda, eID, msh); % Generate the local element reaction matrix for element i 
    else
    end
    
end

