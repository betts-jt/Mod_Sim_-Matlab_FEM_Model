function [Global_Mat, Global_Vec, SourceVec_next] = GlobalMat_GlobalVec_Assbemly(msh, C_current, Data, Global_Mat_K, Global_Mat_M, SourceVec_Current, SourceVec_next)
% This is a fuction to generate the global matrix and global vector for a
% give mesh and intiial conditions.
%   msh = the mesh being investigated
%   C_current = current colution value
%   Data = Structure of probelem variables.


for i = 1:Data.Ne
    if Data.VariedParamaters == 1
        [Data] = EquationConstants(msh.nvec(i+1), Data);
    else
    end
    % LOCAL ELEMENT MATRACIES
    Mass_Local = LocalElementMat_Mass(i, msh, Data.GN); % Generate the local element mass matrix for element i
    
    Diffusion_Local = LaplaceElemMatrix(Data.D, i, msh, Data.GN); % Generate the local element diffution matrix for element i
    Source_Local_next = LocalElementVec_Source(Data.f, i, msh);
    
    
    Reaction_Local = LocalElementMat_Reaction(Data.lambda, i, msh, Data.GN); % Generate the local element reaction matrix for element i
    Stiffness_Local = Diffusion_Local - Reaction_Local;% Calculate the overall local element matrix of the left hand side of the equation if the reaction term is needed
    
    
    % GLOBAL MATRACIES
    % Form the global matrix by adding the local elements to the previous loops global element matrix.
    % This correctly sums the overlapping values on the diagonal.
    Global_Mat_K(i:i+1,i:i+1) =  Global_Mat_K(i:i+1,i:i+1)+Stiffness_Local;
    Global_Mat_M(i:i+1,i:i+1) =  Global_Mat_M(i:i+1,i:i+1)+Mass_Local;
    SourceVec_next(i:i+1,1) = SourceVec_next(i:i+1) + Source_Local_next';
end

SourceVecComponent_GV = Data.dt*(Data.Theta*SourceVec_next+(1-Data.Theta)*SourceVec_Current);

Global_Mat = Global_Mat_M + Data.Theta* Data.dt .* Global_Mat_K; % Caluclate the global matrix
Global_Vec = ((Global_Mat_M - ((1-Data.Theta) * Data.dt * Global_Mat_K)) * C_current)+SourceVecComponent_GV; % Calculate the global vector

end