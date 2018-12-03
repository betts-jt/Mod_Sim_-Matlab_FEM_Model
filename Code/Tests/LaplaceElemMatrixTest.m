%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
tol = 1e-14;
D = 2; %diffusion coefficient
eID=1; %element ID
GN = 3;
msh = OneDimLinearMeshGen(0,1,10);

elemat = LaplaceElemMatrix(D,eID,msh, GN); 

assert(issymmetric(elemat) == 1);

%% Test 2: test 2 different elements of the same size produce same matrix
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element matrices calculated are the same
tol = 1e-14;
D = 5; %diffusion coefficient
eID=1; %element ID
GN = 3;
msh = OneDimLinearMeshGen(0,1,10);

elemat1 = LaplaceElemMatrix(D,eID,msh, GN);
eID=2; %element ID

elemat2 = LaplaceElemMatrix(D,eID,msh, GN);

diff = elemat1 - elemat2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)

%% Test 3: test that one matrix is evaluted correctly
% % Test that element 1 of the three element mesh problem described in the lectures
% % the element matrix is evaluated correctly
tol = 1e-14;
D = 1; % diffusion coefficient
eID = 1; % Element ID
GN = 3;

msh = OneDimLinearMeshGen(0,1,3);

elemat1 = LaplaceElemMatrix(D,eID,msh,GN);
elemat2 = [7,-8,1;-8,16,-8;1,-8,7];