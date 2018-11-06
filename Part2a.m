function [] = Part2a()
%This fuction runs the FEM_BC solver with the nessusary data to compelete
%part 2a of the modelling and simulation.

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 0.01; % Maximum vale of x for the elements
Data.Ne = 6; % Numeber of elements in the mesh
Data. reactionNeeded = 1; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.

%GENERATE DATA RANGES NEEDED FOR PROBLEM
Q_Range = [0.5 1.5]; % Maximum and minimum values of Q. The liquid flow rate.
Q_numPoints = 5; % Number of values of Q between the range to be drawn.
Q_Range = [Q_Range(1):((Q_Range(2)-Q_Range(1))/(Q_numPoints-1)):Q_Range(2)]; % Generate an array with all of the Q values to be tested
Tl_Range = [294.15 322.154]; % MAximum and minimum values of Tl. The liquid tempurature
Tl_numPoints = 5; % Number of values of Tl between the range to be drawn.
Tl_Range = [Tl_Range(1):((Tl_Range(2)-Tl_Range(1))/(Tl_numPoints-1)):Tl_Range(2)]; % Generate an array with all of the Tl values to be tested

diff = (Data.xmax-Data.xmin)/Data.Ne; % Calculate the difference between the x positions of the nodes based to the numebr of nodes and xmin/xmax
x = [Data.xmin : diff: Data.xmax]; % Generate the array of nodal x positions

% SETUP BOUNDARY CONDITIONS
BC1T = 1; % Dirichlet boundary condition
BC1V = 323.15; % Tempurature boundary condition at x=0
BC2T = 1; % Dirichlet boundary condition
BC2V = 293.15; % Tempurature boundary condition at x=1

%GENERATE GRAPHS OF DIFFERENT VALUES OF Q FOR CONSTANT TL
for j = 1:Tl_numPoints
    Data.llambda = Tl_Range(j);
    for i = 1:Q_numPoints
        Data.D = Q_Range(i);
        Data.f = Q_Range(i)*Tl_Range(j);
        T = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);
        figure(j)
        hold on
        plot(x,T, 'o-')
        xlabel('T')
        ylabel('X')
        title(['Temputature distribution for fluid tempurature = ', num2str(Data.llambda)])
    end
end

end

