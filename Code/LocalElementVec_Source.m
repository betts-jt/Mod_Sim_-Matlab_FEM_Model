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

% Setting up initial values of the local element vector
Int0 = 0;
Int1= 0;
Int2=0;

for k=1:N
    GW = gq.wi(k);
    GP = gq.Xi(k);
    
    % Run function to get Phi at each node
    for i = 1:gq.npts
        Phi(i) = EvalBasis(i, GP);
    end
    
    % Calculating the first value (Int0) of the local element matrix
    Int0 = Int0 + GW*f*J * Phi(1);
    % Calculating the second value (Int1) of the local element matrix
    Int1 = Int1 + GW*f*J * Phi(2);
    % Calculating the second value (Int3) of the local element matrix
    Int2 = Int2 + GW*f*J * Phi(3);
end

LocalVec_Source = [Int0 Int1 Int2]; % Form the local source vector.

end

