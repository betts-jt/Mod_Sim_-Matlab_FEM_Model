%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
tol = 1e-14;
lambda = 1; % scalar coefficient 
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);
GN = 3;

elemat = LocalElementMat_Reaction(lambda,eID,msh, GN); 

assert(issymmetric(elemat) == 1)

%% Test 2: test 2 different elements of the same size produce same matrix
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element matrices calculated are the same
tol = 1e-14;
lambda = 1; % scalar coefficient 
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);
GN = 3;

elemat1 = LocalElementMat_Reaction(lambda,eID,msh, GN);

eID=2; %element ID

elemat2 = LocalElementMat_Reaction(lambda,eID,msh, GN);

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
GN = 3;

elemat1 = LocalElementMat_Reaction(lambda,eID,msh, GN);

elemat2 = [ 2/45 1/45 -1/90 ; 1/45 8/45 1/45; -1/90 1/45 2/45];
diff = elemat1 - elemat2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)
