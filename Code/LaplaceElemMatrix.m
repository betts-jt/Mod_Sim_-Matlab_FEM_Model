function [LocalElementMat] = LaplaceElemMatrix(D, eID, msh, GN)
%This fuction calculates the local 2-by-2 element matrix for the diffusion
%operator, which can calculate this matrix for an arbitrary element eN
%defined between the points x0 and x1
%   D = diffusion coefficient
%   eID is the local element number
%   msh is the mesh data structure calcualted using
%       OneDimLinearMeshGen. From this mesh each elements Jacobian and the
%       nodal posisions x0 and x1 can be accesed.
%   GD = N value for Gaussiam Quadriture scheme

x0 = msh.elem(eID).x(1); %First X value of element being analysed
x1 = msh.elem(eID).x(2); % Second X value of element being analysed
dx = x1 - x0;

% DEFINITION OF LIMITS OF THE STANDARD ELEMENT
Xi0 = -1; % The vlaue of Xi0
Xi1 = 1; % The vlaue of Xi1

% IMPLIMENTING GAUSSIAN QUADRATURE
N=GN;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature

dPsidXi = [-0.5 0.5]; % Get vector containing basis function gradients at xipt

J = msh.elem(eID).J; % Drawing in the Jacobian of the element ebing analysed

dXidx =2/J; % Calculating the value of dXi/dx

% Setting up initial values of the local element matrix
Int00 = 0; Int01 = 0; Int02 = 0;
Int10 = 0; Int11 = 0; Int12 = 0;
Int20 = 0; Int21 = 0; Int22 = 0;

for k=1:N
    GW = gq.wi(k); % Value of Gauss weight
    GP = gq.Xi(k); % Value of Gauss point
    
        
    Phi0 = (GP*(GP-1))/2;
    Phi1 = 1-GP^2;
    Phi2 = (GP*(GP+1))/2;
    
    % Calculating the new values by adding to the old ones
    Int00 = Int00+GW*D*J*Phi0*Phi0*dXidx^2;
    Int01 = Int01+GW*D*J*Phi0*Phi1*dXidx^2;
    Int02 = Int02+GW*D*J*Phi0*Phi2*dXidx^2;
    Int10 = Int01;
    Int11 = Int11+GW*D*J*Phi1*Phi1*dXidx^2;
    Int12 = Int12+GW*D*J*Phi1*Phi2*dXidx^2;
    Int20 = Int02;
    Int21 = Int12;
    Int22 = Int22+GW*D*J*Phi2*Phi2*dXidx^2;
end


LocalElementMat = [Int00,Int01,Int02;Int10,Int11,Int12;Int20,Int21,Int22]; % For the lcoal element matrix

end