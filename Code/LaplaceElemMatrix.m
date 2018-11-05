function [LocalElementMat] = LaplaceElemMatrix(D, eID, msh)
%This fuction calculates the local 2-by-2 element matrix for the diffusion 
%operator, which can calculate this matrix for an arbitrary element eN 
%defined between the points x0 and x1
    %%Where D is the diffusion coefficient, En is the local element number
    %%and msh is the mesh data structure calcualted using
    %%OneDimLinearMeshGen. From this mesh each elements Jacobian and the
    %%nodal posisions x0 and x1 can be accesed.

% Run this msh = OneDimLinearMeshGen(0,1,3); to generate test mesh

x0 = msh.elem(eID).x(1); %First X value of element being analysed
x1 = msh.elem(eID).x(2); % Second X value of element being analysed

Xi0 = -1; % The vlaue of ?0
Xi1 = 1; % The vlaue of ?1

J = msh.elem(eID).J; % Drawing in the Jacobian of the element ebing analysed

dXi_dx =1/J; % Calculating the value of d?/dx
   
dPsi0_dXi = -0.5; % Calculating the value of d?0/d?
dPsi1_dXi = 0.5; % Calculating the value of d?1/d?

% Long forms of integrals for local element matrix
%{
Int00 = Integral(D*dPsi0_dXi*dXi_dx*dPsi0_dXi*dXi_dx*J*(Xi1-Xi0)) [-1,1]; % Calculating the first value (Int00) of the local element matrix
Int01 = Integral(D*dPsi0_dXi*dXi_dx*dPsi1_dXi*dXi_dx*J*(Xi1-Xi0)) [-1,1];  % Calculating the second and third value (Int10/Int01) of the local element matrix
Int11 = Integral(D*dPsi1_dXi*dXi_dx*dPsi1_dXi*dXi_dx*J*(Xi1-Xi0)) [-1,1]; % Calculating the final value (Int11) of the local element matrix
%}
%Short for of integrals for local element matrix (See report for
%derrivation)

Int00 = D/(x1-x0); % Calculating the first and final value (Int00/Int11) of the local element matrix
Int01 = -D/(x1-x0); % Calculating the second and third value (Int01/Int10) of the lcoal element matrix

LocalElementMat = [Int00 Int01; Int01 Int00];

end