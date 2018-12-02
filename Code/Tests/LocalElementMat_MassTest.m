%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
GN = 3;
tol = 1e-14;
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat = LocalElementMat_Mass(eID,msh, GN); 

assert(abs(elemat(1,2) - elemat(2,1)) <= tol)

%% Test 2: test 2 different elements of the same size produce same matrix
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element matrices calculated are the same
GN = 3;
tol = 1e-14;
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat1 = LocalElementMat_Mass(eID,msh, GN);

eID=2; %element ID

elemat2 = LocalElementMat_Mass(eID,msh, GN);

diff = elemat1 - elemat2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)

%% Test 3: test that one matrix is evaluted correctly
% % Test that element 1 of the three element mesh problem described in the lectures
% % the element matrix is evaluated correctly
GN = 3;
tol = 1e-14;
eID=1; %element ID
lambda = 1; % scalar coefficient 
msh = OneDimLinearMeshGen(0,1,3);

elemat1 = LocalElementMat_Mass(eID,msh, GN);

elemat2 = [ 1/9 1/18; 1/18 1/9];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 4: Test that the elements of the matrix are of the correct magnitude in relating to eachother.
% test that elements 1 and 4 are double that of elements 2 and 3.
GN = 3;
tol = 1e-14;
eID=1; %element ID
lambda = 1; % scalar coefficient 
msh = OneDimLinearMeshGen(0,1,3);

elemat = LocalElementMat_Mass(eID,msh, GN);

assert(elemat(1) == 2*elemat(3))
assert(elemat(4) == 2*elemat(2))

%% Test 5 : Check that the same answer if given for GN = 2 and GN = 3 becuase
%both should be able to exancly evaluate a second order function.

tol = 1e-14;
eID=1; %element ID
lambda = 1; % scalar coefficient 
msh = OneDimLinearMeshGen(0,1,10);
GN = 2;
elemat1 = LocalElementMat_Mass(eID,msh, GN);
GN = 3;
elemat2 = LocalElementMat_Mass(eID,msh, GN);

assert(abs(elemat1(1)-elemat2(1)) <= tol)
assert(abs(elemat1(2)-elemat2(2)) <= tol)
assert(abs(elemat1(3)-elemat2(3)) <= tol)
assert(abs(elemat1(4)-elemat2(4)) <= tol)