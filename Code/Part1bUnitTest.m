%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
tol = 1e-14;
lambda = 1; % scalar coefficient 
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat = LocalElementMat_Reaction(lambda,eID,msh); 

assert(abs(elemat(1,2) - elemat(2,1)) <= tol)

%% Test 2: test 2 different elements of the same size produce same matrix
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element matrices calculated are the same
tol = 1e-14;
lambda = 1; % scalar coefficient 
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elemat1 = LocalElementMat_Reaction(lambda,eID,msh);

eID=2; %element ID

elemat2 = LocalElementMat_Reaction(lambda,eID,msh);

diff = elemat1 - elemat2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)

%% Test 3: test that one matrix is evaluted correctly
% % Test that element 1 of the three element mesh problem described in the lectures
% % the element matrix is evaluated correctly
tol = 1e-14;
eID=1; %element ID
lambda = 1; % scalar coefficient 
msh = OneDimLinearMeshGen(0,1,3);

elemat1 = LocalElementMat_Reaction(lambda,eID,msh);

elemat2 = [ 1/9 1/18; 1/18 1/9];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 4: Test that the elements of the matrix are of the correct magnitude in relating to eachother.
% test that elements 1 and 4 are double that of elements 2 and 3.
tol = 1e-14;
eID=1; %element ID
lambda = 1; % scalar coefficient 
msh = OneDimLinearMeshGen(0,1,3);

elemat = LocalElementMat_Reaction(lambda,eID,msh);

assert(abs(elemat(1) - 2*elemat(3) <= tol))
assert(abs(elemat(4) - 2*elemat(2) <= tol))
