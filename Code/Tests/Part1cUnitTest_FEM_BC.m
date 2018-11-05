%% Test 1: Test that the FEM_BC test generates the correct output for a known input condition
% Test that both values of the local source vector are equal as proved to
% % Test that the outout gives the corrent answer for a set of given input
% % conditions as described in lecure 8.

tol=1e-5;

Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 3; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = 1; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 0; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.

BC1T = 1; % Dirichlet BC
BC1V = 0;
BC2T = 1; % Dirichlet BC
BC2V = 1;

c1 = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);

c2 = [0 1/3 2/3 1]';

assert(abs(c1(1)-c2(1)) <=tol)
assert(abs(c1(2)-c2(2)) <=tol)
assert(abs(c1(3)-c2(3)) <=tol)
assert(abs(c1(4)-c2(4)) <=tol)

