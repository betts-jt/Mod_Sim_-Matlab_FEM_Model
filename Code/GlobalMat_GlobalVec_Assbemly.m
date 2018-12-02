function [Global_Mat, Global_Vec, SourceVec] = GlobalMat_GlobalVec_Assbemly(msh,...
    C_current, Data, SourceVec)
% This is a fuction to generate the global matrix and global vector for a
% give mesh and intiial conditions.
%   msh = the mesh being investigated
%   C_current = current colution value
%   Data = Structure of probelem variables.
%   Global_Mat_M = Value of the global mass matrix
%   Global_Mat_K = Value of the global stiffness matrix
%   SourceVec =

% Calcutare the component of the GV due to current source vector
SourceVecComponentCurent_GV = Data.dt*((1-Data.Theta).*SourceVec);

% INITIALISE MATRACIES
SourceVec = zeros(2*Data.Ne+1,1);
Global_Mat = zeros(2*Data.Ne+1);
Global_Vec = zeros(2*Data.Ne+1, 1);
Global_Mat_K = zeros(2*Data.Ne+1);
Global_Mat_M = zeros(2*Data.Ne+1);

for i = 1:msh.ne
    if Data.VariedParamaters == 1
        [Data] = EquationConstants(msh,i, Data);
    else
    end
    % LOCAL ELEMENT MATRACIES
    % Generate the local element mass matrix for element i
    Mass_Local = LocalElementMat_Mass(i, msh, Data.GN);
    
    % Generate the local element diffution matrix for element i
    Diffusion_Local = LaplaceElemMatrix(Data.D, i, msh, Data.GN);
    Source_Local_next = LocalElementVec_Source(Data.f, i, msh, Data.GN);
    
    % Generate the local element reaction matrix for element i
    Reaction_Local = LocalElementMat_Reaction(Data.lambda, i, msh, Data.GN);
    % Calculate the overall local element matrix of the left hand side of the
    %   equation if the reaction term is needed
    Stiffness_Local = Diffusion_Local - Reaction_Local;
    
    
    % GLOBAL MATRACIES
    % Form the global matrix by adding the local elements to the previous
    %   loops global element matrix.
    % This correctly sums the overlapping values on the diagonal.
    j=2*i-1;
    Global_Mat_K(j:j+2,j:j+2) =  Global_Mat_K(j:j+2,j:j+2)+Stiffness_Local;
    Global_Mat_M(j:j+2,j:j+2) =  Global_Mat_M(j:j+2,j:j+2)+Mass_Local;
    SourceVec(j:j+2,1) = SourceVec(j:j+2) + Source_Local_next';
end

SourceVecComponentNext_GV = Data.dt*((Data.Theta.*SourceVec));

% Caluclate the global matrix
Global_Mat = Global_Mat_M + (Data.Theta* Data.dt .* Global_Mat_K);
Global_Vec_Initial = Global_Mat_M - ((1-Data.Theta) * Data.dt).* Global_Mat_K;
% Calculate the global vector
Global_Vec =  Global_Vec_Initial*C_current + SourceVecComponentNext_GV+...
    SourceVecComponentCurent_GV;

end