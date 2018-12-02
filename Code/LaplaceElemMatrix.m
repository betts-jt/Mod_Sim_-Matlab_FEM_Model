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

% DEFINITION OF LIMITS OF THE STANDARD ELEMENT
Xi0 = -1; % The vlaue of Xi0
Xi1 = 1; % The vlaue of Xi1

% IMPLIMENTING GAUSSIAN QUADRATURE
N=GN;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature


J = msh.elem(eID).J; % Drawing in the Jacobian of the element ebing analysed

dXidx =1/J; % Calculating the value of dXi/dx

% Setting up initial values of the local element matrix
Int00 = 0;  Int01 = 0;  Int02 = 0;
Int10 = 0;  Int11 = 0;  Int12 = 0;
Int20 = 0;  Int21 = 0;  Int22 = 0;

for k=1:N
    % Set gauss weight and gauss points for loop
    GW = gq.wi(k);
    GP = gq.Xi(k);
    
    % Run function to get dPhi_dXi for all basis functions
    for i = 1:gq.npts
        dPsidXi(i) = EvalBasisGrad(i, GP);
    end

    % Calculating the first value (Int00) of the local element matrix
    Int00 = Int00 + GW*(D * dPsidXi(1) * dPsidXi(1) * dXidx^2 * J);
    Int01 = Int01 + GW*(D * dPsidXi(1) * dPsidXi(2) * dXidx^2 * J);
    Int02 = Int02 + GW*(D * dPsidXi(1) * dPsidXi(3) * dXidx^2 * J);
    Int10 = Int10 + GW*(D * dPsidXi(2) * dPsidXi(1) * dXidx^2 * J);
    Int11 = Int11 + GW*(D * dPsidXi(2) * dPsidXi(2) * dXidx^2 * J);
    Int12 = Int12 + GW*(D * dPsidXi(2) * dPsidXi(3) * dXidx^2 * J);
    Int20 = Int20 + GW*(D * dPsidXi(3) * dPsidXi(1) * dXidx^2 * J);
    Int21 = Int21 + GW*(D * dPsidXi(3) * dPsidXi(2) * dXidx^2 * J);
    Int22 = Int22 + GW*(D * dPsidXi(3) * dPsidXi(3) * dXidx^2 * J);
    
end

LocalElementMat = [Int00 Int01 Int02; Int10 Int11 Int12; Int20 Int21 Int22]; % For the lcoal element matrix

end