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

for k=1:N
    % Calculating the first value (Int0) of the local element matrix
    Int0 = Int0 + gq.wi(k)*f*J * ((1+gq.Xi(k))/2);
    % Calculating the second value (Int1) of the local element matrix
    Int1 = Int1 + gq.wi(k)*f*J * ((1-gq.Xi(k))/2);
end

LocalVec_SourceTest = [Int0 Int1]; % Form the local source vector. 

LocalVec_Source = [f*J f*J];
assert(LocalVec_Source(1) == LocalVec_SourceTest(1))
end

