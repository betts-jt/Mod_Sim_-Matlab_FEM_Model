function [Global_Mat, Global_Vec, SourceVec] = GlobalMat_GlobalVec_Assbemly(msh, C_current, Data, Global_Mat_K, Global_Mat_M, SourceVec)
% This is a fuction to generate the global matrix and global vector for a
% give mesh and intiial conditions.
%   msh = the mesh being investigated
%   C_current = current colution value
%   Data = Structure of probelem variables.

SourceVecComponentCurent_GV = Data.dt*((1-Data.Theta).*SourceVec);
SourceVec = zeros(2*Data.Ne+1,1);
Global_Mat = zeros(2*Data.Ne+1);
Global_Vec = zeros(2*Data.Ne+1, 1);
    
for i = 1:Data.Ne
    if Data.VariedParamaters == 1
        [Data] = EquationConstants(msh,i, Data);
    else
    end
    % LOCAL ELEMENT MATRACIES
    Mass_Local = LocalElementMat_Mass(i, msh, Data.GN); % Generate the local element mass matrix for element i
    
    Diffusion_Local = LaplaceElemMatrix(Data.D, i, msh, Data.GN); % Generate the local element diffution matrix for element i
    Source_Local_next = LocalElementVec_Source(Data.f, i, msh, Data.GN);
    
    
    Reaction_Local = LocalElementMat_Reaction(Data.lambda, i, msh, Data.GN); % Generate the local element reaction matrix for element i
    Stiffness_Local = Diffusion_Local - Reaction_Local;% Calculate the overall local element matrix of the left hand side of the equation if the reaction term is needed
    
    
    % GLOBAL MATRACIES
    % Form the global matrix by adding the local elements to the previous loops global element matrix.
    % This correctly sums the overlapping values on the diagonal.
    k = 2*1-1;
    Global_Mat_K(k:k+2,k:k+2) =  Global_Mat_K(k:k+2,k:k+2)+Stiffness_Local;
    Global_Mat_M(k:k+2,k:k+2) =  Global_Mat_M(k:k+2,k:k+2)+Mass_Local;
    SourceVec(k:k+2,1) = SourceVec(k:k+2) + Source_Local_next';
end

SourceVecComponentNext_GV = Data.dt*((Data.Theta.*SourceVec));

Global_Mat = Global_Mat_M + (Data.Theta* Data.dt .* Global_Mat_K); % Caluclate the global matrix
Global_Vec_Initial = Global_Mat_M - ((1-Data.Theta) * Data.dt).* Global_Mat_K;
Global_Vec =  Global_Vec_Initial*C_current + SourceVecComponentNext_GV+SourceVecComponentCurent_GV; % Calculate the global vector

end