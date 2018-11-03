function [mesh] = LaplaceElemMatrix(D, En, Mesh)
%This fuction calculates the local 2-by-2 element matrix for the diffusion 
%operator, which can calculate this matrix for an arbitrary element eN 
%defined between the points x0 and x1
    %%Where D is the diffusion coefficient, En is the local element number
    %%and Mesh is the mesh data structure calcualted using
    %%OneDimLinearMeshGen. From this mesh each elements Jacobian and the
    %%nodal posisions x0 and x1 can be accesed.

% Run this Mesh = OneDimLinearMeshGen(0,1,3); to generate test mesh


    
end