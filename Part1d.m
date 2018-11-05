function [] = Part1d()
%This funciton solves the equation outlines in the coursework part 1d and
%plots graphs to compare it to the analytical solution also given on the
%coursework sheet.

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 4; % Numeber of elements in the mesh
Data.D = 1; % Diffution coefficient used to calcualte the local element matracies for diffution
Data.llambda = -9; % scalar coefficient used to calcualte the lcoal element matracies for reaciton
Data.f = 0; % Coefficient used to calculate the local element source vector
Data. reactionNeeded = 1; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.

diff = (Data.xmax-Data.xmin)/Data.Ne; % Calculate the difference between the x positions of the nodes based to the numebr of nodes and xmin/xmax
x = [Data.xmin : diff: Data.xmax]; % Generate the array of nodal x positions

for i=2:10
    Data.Ne = i; % Set the mesh relolution to a value between 3 and 15
    C_FEM = FEM_BC(1,0,1,1, Data);
    diff = (Data.xmax-Data.xmin)/Data.Ne; % Calculate the difference between the x positions of the nodes based to the numebr of nodes and xmin/xmax
    x = [Data.xmin : diff: Data.xmax]; % Generate the array of nodal x positions
    C_ana = (exp(3)/(exp(6)-1))*(exp(3*x)-exp(-3*x));
    figure(i)
    plot(x, C_FEM, x , C_ana)
    xlabel('x')
    ylabel('C')
    title(['Mesh Resolution = ' num2str(i)])
end

end

