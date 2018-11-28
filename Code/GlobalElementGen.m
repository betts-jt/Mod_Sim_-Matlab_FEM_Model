function [Global_Mat, SourceGlobal_Vec] = GlobalElementGen(xmin, xmax, Ne, D, llambda, f, reactionNeeded, SourceNeeded,SourceTermConstant)
% Given the relevent input paramenters this cod ewill generate the local
% element matracies for each element and combign these to form the global
% element matrix for both the diffution operator and the reaction operator
% if needed.
%   Where: xmin = the mimimum value of x to be used when generating the
%   mesh. xmax = the maxmum value of x to be used when generating the mesh.
%   Ne = Number of elements to be used when generating the mesh. D =
%   Diffution operator used when generating the local element matracies
%       for diffution.
%   llambda = Scalar coefficient used when generating the lcoal element
%             matracies for reaciton operator.
%   f = spacial coefficient for calculating the source term ReactionNeeded
%   = This is either 1 is the global element matrix for the
%                   reaction operator needs to be generatod or 0 if it does
%                   not need to be gerenated.
%   SourceTermConstant = 1 if the source term is constant and 0 if the
%                        source term is not fixed

msh = OneDimLinearMeshGen(xmin,xmax,Ne); % Generate the mesh

% GENERATE LOCAL ELEMENT MATRACIERS FOR ALL ELEMENTS
for i = 1:Ne
    Diffusion(i).Local = LaplaceElemMatrix(D, i, msh); % Generate the local element diffution matrix for element i
    if SourceNeeded == 1
        if SourceTermConstant == 1 % Check if the source term is constnat
            Source(i).Local = LocalElementVec_Source(f, i, msh); % Generate the local element source vector for element i
        elseif SourceTermConstant == 0 % Check if the sourceterm is not constant
            Source(i).Local = LocalElementVec_VariedSource(f, i, msh); % Generate the local element source vector for element i
        else
            error('Please enter either a value of 0 ro 1 for SourceTermConstant')
        end
    else
    end
    if reactionNeeded == 1 % Check if the reaction matrix is required
        Reaction(i).Local = LocalElementMat_Reaction(llambda, i, msh); % Generate the local element reaction matrix for element i
        Overall(i).Local = Diffusion(i).Local - Reaction(i).Local;% Calculate the overall local element matrix of the left hand side of the equation if the reaction term is needed
    else
        Overall(i).Local = Diffusion(i).Local; % Calculate the overall local element matrix of the left hand side of the equation if the reaction term isn't needed
    end
end

Global_Mat = zeros(Ne+1); % Generate blank global matrix for population.
SourceGlobal_Vec = zeros(Ne+1,1); % Generate blank global source vector for population.

% GENREATE THE GLOBAL MATRIX AND GLOBAL SOURCE VECTOR
for i = 1:Ne
    % Form the global matrix by adding the local elements to the previous loops global element matrix.
    % This correctly sums the overlapping values on the diagonal.
    Global_Mat(i:i+1,i:i+1) =  Global_Mat(i:i+1,i:i+1)+Overall(i).Local;
    % Form the global source vector by adding the local elements to the previous loops global source vector.
    % This correctly sums the overlapping values.
    if SourceNeeded == 1
        SourceGlobal_Vec(i:i+1) = SourceGlobal_Vec(i:i+1) + Source(i).Local';
    else
        SourceGlobal_Vec(i:i+1) = 0;
    end
end
end
    
