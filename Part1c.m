function [] = Part1c()
% This code runs the FEM_BC FEM solver for two example cases and compares
% the results given to the analytical results for analysis.


% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 4; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = 1; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 0; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.

diff = (Data.xmax-Data.xmin)/Data.Ne; % Calculate the difference between the x positions of the nodes based to the numebr of nodes and xmin/xmax
x = [Data.xmin : diff: Data.xmax]; % Generate the array of nodal x positions

%% First problem of part 1c with 2 Dirichlet boundary conditions
C1_FEM = FEM_BC(1,2,1,0, Data); % Run FEM_BC for the laplace equation with 2 Dirichlet BC as in 1c part 1

figure(1)
hold on
plot(x,C1_FEM)
title('FEM - 2 Dirichlet')
xlabel('x')
ylabel('C')

C1_Ana = 2*(1-x);
figure(2)
hold on
plot(x,C1_FEM, 'r')
title('Analytical')
xlabel('x')
ylabel('C')

%% Second problem of part 1c with 1 Dirichlet and 1 Neumann boundary conditions
C2_FEM = FEM_BC(2,2,1,0, Data); % Run FEM_BC for the laplace equation with 2 Dirichlet BC as in 1c part 1
figure(3)
hold on
plot(x,C2_FEM)
title('FEM- 1 Dirichlet, 1 Neumann')
xlabel('x')
ylabel('C')
end

