function [LocalVec_Source] = LocalElementVec_Source(f, eID, msh, GN)
%This code will generate the local element vector from the source term for
%a given element number.
%   Where eID is the element number.
%   msh is the mesh data structure calcualted using OneDimLinearMeshGen
%   f = constant of the source term

% IMPLIMENTING GAUSSIAN QUADRATURE
N=GN;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

% Run function to get dPhi_dXi
for i = 1:gq.npts
    dPsidXi(i) = EvalBasisGrad(i-1, 0);
end

% Setting up initial values of the local element vector
Int0 = 0;
Int1= 0;
Int2=0;

for k=1:N
    GW = gq.wi(k);
    GP = gq.Xi(k);
    
    Phi(1) = (GP*(GP-1))/2;
    Phi(2) = 1-GP^2;
    Phi(3) = (GP*(GP+1))/2;
    
    % Calculating the first value (Int0) of the local element matrix
    Int0 = Int0 + GW*f*J * Phi(1);
    % Calculating the second value (Int1) of the local element matrix
    Int1 = Int1 + GW*f*J * Phi(2);
    % Calculating the second value (Int3) of the local element matrix
    Int2 = Int1 + GW*f*J * Phi(3);
end

LocalVec_Source = [Int0 Int1 Int2]; % Form the local source vector.

end

