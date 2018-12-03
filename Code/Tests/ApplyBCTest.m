%% Test 1: Test for a given input matrix the dirichlet boundy is applied to it correctly
% Test that the top and botton column are set to zero apart from the first
% and last value

%Set up matrix and vector
tol = 1e-14;
matrix = [5 5 5 5; 5 5 5 5 ; 5 5 5 5];
vector = [5 5 5];

%set up BC
BC1T = 'D';
BC1V = 1;
BC2T = 'D';
BC2V = 1;

[Evalmatrix1, ~] = ApplyBC(BC1T,BC1V,BC2T,BC2V, 0,...
    matrix, vector);

Evalmatrix2 = [1 0 0 0; 5 5 5 5; 0 0 0 1];

assert(isequal(Evalmatrix1, Evalmatrix2) == 1);
