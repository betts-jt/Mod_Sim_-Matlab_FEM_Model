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
Data.SourceNeeded = 1;
Data.SourceTermConstant = 0; % Value defining whether the source term is constant

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

%% Test 2: Check that the fuction gives a result of the correct size
%   This test check that for a given set of inpout variables the
%   corresponding answer from the FEM solver is the correct size 

Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 3; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = 1; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 0; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.
Data.SourceNeeded = 1;
Data.SourceTermConstant = 0; % Value defining whether the source term is constant

BC1T = 1; % Dirichlet BC
BC1V = 2;
BC2T = 1; % Dirichlet BC
BC2V = 0;

c1 = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);

ExpectedLen = Data.Ne+1; % This is the expected size of the answer
ActualLen = length(c1);

assert(ActualLen==ExpectedLen);

%% Test 3: Check that Dirichlet BC are applied correctly at each end.
%    This test checks that when a Dirichlet is applied to the FEM this is
%    reflected correctly in the given answer.

tol=1e-5;

Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 3; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = 1; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 0; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.
Data.SourceNeeded = 1;
Data.SourceTermConstant = 0; % Value defining whether the source term is constant

BC1T = 1; % Dirichlet BC
BC1V = 2;
BC2T = 1; % Dirichlet BC
BC2V = 4;

c1 = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);

assert(abs(c1(1)-BC1V) <= tol); % Check BC1
assert(abs(c1(end)-BC2V) <= tol); % Check BC1

%% Test 4 Check that the code can still function correctly with large mesh sided and BC
%   Check that when a large number of elements are used and teh boundary
%   conditions are far apart that the code generated real results and no
%   Nan or inf answers

tol=1e-5;

Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 1000; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = 1; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 0; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.
Data.SourceNeeded = 1;
Data.SourceTermConstant = 0; % Value defining whether the source term is constant

BC1T = 1; % Dirichlet BC
BC1V = 0;
BC2T = 1; % Dirichlet BC
BC2V = 5000;

c1 = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);

assert(all(isfinite(c1)) == 1); % Check all answers are finite
% The above also checks that all elements in the global reaction-diffution
% matrix anbd the source vector are finite as if any was infinate the
% answer would be infinate at that point
assert(all(isreal(c1)) == 1); % Check all answerrs are real
