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

