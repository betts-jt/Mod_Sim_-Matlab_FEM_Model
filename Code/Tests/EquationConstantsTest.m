% Test 1: Test the values calculated correctly in the Epidermis reqion
% Test that the values of D, lambda and f are evalueated correctly in the
% Epidermis
tol = 1e-5;
msh = OneDimLinearMeshGen(0,0.01,30);
Data.i=1; % point in  mesh to be determined

[Data] = EquationConstants(msh,Data.i, Data);

% Expected values
D = 1/158400;
lambda =0;
f = 0;

assert(abs(D - Data.D) <= tol)
assert(abs(lambda - Data.lambda) <= tol)
assert(abs(f - Data.f) <= tol)

% Test 2: Test the values calculated correctly in the Dermis reqion
% Test that the values of D, lambda and f are evalueated correctly in the
% Dermis
tol = 1e-5;
msh = OneDimLinearMeshGen(0,0.01,30);
Data.i=14; % point in  mesh to be determined

[Data] = EquationConstants(msh,Data.i, Data);

% Expected values
D =1/99000;
lambda =-0.0378428;
f = 11.7369454;

assert(abs(D - Data.D) <= tol)
assert(abs(lambda - Data.lambda) <= tol)
assert(abs(f - Data.f) <= tol)

% Test 3: Test the values calculated correctly in the Sub cutaneous reqion
% Test that the values of D, lambda and f are evalueated correctly in the
% Sub cutaneous
tol = 1e-5;
msh = OneDimLinearMeshGen(0,0.01,30);
Data.i=25; % point in  mesh to be determined

[Data] = EquationConstants(msh,Data.i, Data);

% Expected values
D = 1/198000;
lambda =-0.0378428;
f = 11.7369454;

assert(abs(D - Data.D) <= tol)
assert(abs(lambda - Data.lambda) <= tol)
assert(abs(f - Data.f) <= tol)