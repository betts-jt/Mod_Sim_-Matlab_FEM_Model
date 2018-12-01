function [LocalVec_Source] = LocalElementVec_Source(f, eID, msh, GN)
%This code will generate the local element vector from the source term for
%a given element number.
%   Where eID is the element number.
%   msh is the mesh data structure calcualted using OneDimLinearMeshGen
%   f = constant of the source term

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

LocalVec_Source = [f*J f*J]; % Form the local source vector. 
% The derrivation of this can be found in the corsework report part 1c.

J = msh.elem(eID).J; % Drawing in the Jacobian of the element being analysed

% IMPLIMENTING GAUSSIAN QUADRATURE
N=GN;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature

% Setting up initial values of the local element matrix
Int0 = 0; 
Int1 = 0; 
Int2 = 0;


for k=1:N
    GW = gq.wi(k); % Value of Gauss weight
    GP = gq.Xi(k); % Value of Gauss point
    % Calculating the new values by adding to the old ones
    Int0 = Int0 + GW * (f * J) * (GP*(GP-1))/2;
    Int1 = Int1 + GW * (f * J) * 1-GP^2;
    Int2 = Int2 + GW * (f * J) * (GP*(GP-1))/2;

end

LocalVec_Source = [Int0,Int1,Int2]; % Generate the local element reaction matrix
end

