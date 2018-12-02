%% Test 1: test the both values of the vector are equal
% Test that both values of the local source vector are equal as proved to
% be the case in the derrivation in part 1c of the coursework
GN = 3;
f = 1; % Coefficient relating to source term
eID = 1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elevec = LocalElementVec_Source(f, eID, msh, GN); 

assert(elevec(1) == elevec(2))

%% Test 2: Test that one vector is evaluated correctly
% % Test that for a known set of input variables the correct local element
% vector

GN = 3;
tol = 1e-14;
eID=1; %element ID
f = 1; % Coefficient relationg to source term 
msh = OneDimLinearMeshGen(0,1,3);

elevec1 = LocalElementVec_Source(f, eID, msh, GN);

elevec2 = [1/6 1/6];
diff = elevec1 - elevec2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 3: test 2 different elements of the same size produce same vector
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element vectors calculated are the same
GN = 3;
tol = 1e-14;
f = 3; % Coefficient relating to source term
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elevec1 = LocalElementVec_Source(f, eID, msh, GN);%THIS IS THE FUNCTION YOU MUST WRITE

eID=2; %element ID

elevec2 = LocalElementVec_Source(f, eID, msh, GN);%THIS IS THE FUNCTION YOU MUST WRITE

diff = elevec1 - elevec2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)

%% Test 4 : Check that the same answer if given for GN = 2 and GN = 3 becuase
%both should be able to exancly evaluate a second order function.

tol = 1e-14;
f = 3; % Coefficient relating to source term
eID=1; %element ID
lambda = 1; % scalar coefficient 
msh = OneDimLinearMeshGen(0,1,10);
GN = 2;
elemat1 = LocalElementVec_Source(f, eID, msh, GN);
GN = 3;
elemat2 = LocalElementVec_Source(f, eID, msh, GN);

assert(abs(elemat1(1)-elemat2(1)) <= tol)
assert(abs(elemat1(2)-elemat2(2)) <= tol)


