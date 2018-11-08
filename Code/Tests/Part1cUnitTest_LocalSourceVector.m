%% Test 1: test the both values of the vector are equal
% Test that both values of the local source vector are equal as proved to
% be the case in the derrivation in part 1c of the coursework
f = 1; % Coefficient relating to source term
eID = 1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elevec = LocalElementVec_Source(f, eID, msh); 

assert(elevec(1) == elevec(2))

%% Test 2: Test that one vector is evaluated correctly
% % Test that for a known set of input variables the correct local element
% vector

tol = 1e-14;
eID=1; %element ID
f = 1; % Coefficient relationg to source term 
msh = OneDimLinearMeshGen(0,1,3);

elevec1 = LocalElementVec_Source(f, eID, msh);

elevec2 = [1/6 1/6];
diff = elevec1 - elevec2; %calculate the difference between the two matrices
diffnorm = sum(sum(diff.*diff)); %calculates the total squared error between the matrices
assert(abs(diffnorm) <= tol)

%% Test 2: test 2 different elements of the same size produce same vector
% % Test that for two elements of an equispaced mesh, as described in the
% % lectures, the element vectors calculated are the same
tol = 1e-14;
f = 3; %diffusion coefficient
eID=1; %element ID
msh = OneDimLinearMeshGen(0,1,10);

elevec1 = LocalElementVec_Source(f, eID, msh);%THIS IS THE FUNCTION YOU MUST WRITE

eID=2; %element ID

elevec2 = LocalElementVec_Source(f, eID, msh);%THIS IS THE FUNCTION YOU MUST WRITE

diff = elevec1 - elevec2;
diffnorm = sum(sum(diff.*diff));
assert(abs(diffnorm) <= tol)


