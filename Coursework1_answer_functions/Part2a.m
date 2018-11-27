function [] = Part2a(VarQ_FixTl, VarTl_FixQ)
%This fuction runs the FEM_BC solver with the nessusary data to compelete
%part 2a of the modelling and simulation.
%   Where;
%   VarQ_FixTl = 1 to display the graphs of fixed Tl varied Q or 0 to not
%   show the graphs
%
%   VarTl_FixQ = 1 to display the graphs of fixed Tl varied Q or 0 to not
%   show the graphs

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 0.01; % Maximum vale of x for the elements
Data.Ne = 6; % Numeber of elements in the mesh
Data. reactionNeeded = 1; % Value is either 1 is the problem needs the local element matracies due to reaction to be calcualted or 0 is these are not needed.
Data.D = 1.01e-5; % Setting D to the value of k from the coursework sheet
Data.SourceTermConstant = 1; % Value defining whether the source term is constant

%GENERATE DATA RANGES NEEDED FOR PROBLEM
Q_Range = [0.5 1.5]; % Maximum and minimum values of Q. The liquid flow rate.
Q_numPoints = 4; % Number of values of Q between the range to be drawn.
Q_Range = [Q_Range(1):((Q_Range(2)-Q_Range(1))/(Q_numPoints-1)):Q_Range(2)]; % Generate an array with all of the Q values to be tested
Tl_Range = [294.15 322.154]; % MAximum and minimum values of Tl. The liquid tempurature
Tl_numPoints = 4; % Number of values of Tl between the range to be drawn.
Tl_Range = [Tl_Range(1):((Tl_Range(2)-Tl_Range(1))/(Tl_numPoints-1)):Tl_Range(2)]; % Generate an array with all of the Tl values to be tested

diff = (Data.xmax-Data.xmin)/Data.Ne; % Calculate the difference between the x positions of the nodes based to the numebr of nodes and xmin/xmax
x = [Data.xmin : diff: Data.xmax]; % Generate the array of nodal x positions

% SETUP BOUNDARY CONDITIONS
BC1T = 1; % Dirichlet boundary condition
BC1V = 323.15; % Tempurature boundary condition at x=0
BC2T = 1; % Dirichlet boundary condition
BC2V = 293.15; % Tempurature boundary condition at x=1

FigureLab = 1; % Generate variable to correctly label figure
%GENERATE GRAPHS OF DIFFERENT VALUES OF Q FOR CONSTANT TL
for j = 1:Tl_numPoints
    for i = 1:Q_numPoints
        Data.llambda = -Q_Range(i);
        Data.f = Q_Range(i)*Tl_Range(j);
        T1 = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);
        if VarQ_FixTl ==1 % Plot graphs if required
            figure(FigureLab)
            hold on
            plot(x,T1, 'o-')
            xlabel('x')
            ylabel('T')
            title(['Temputature distribution for fluid tempurature (Tl) = ', num2str(Tl_Range(j))])
        end
    end
    FigureLab =FigureLab+1; % Add one to figure number
end

%GENERATE GRAPHS OF DIFFERENT VALUES OF Tl FOR CONSTANT Q
for j = 1:Q_numPoints
    for i = 1:Tl_numPoints
        Data.llambda = -Q_Range(j);
        Data.f = Q_Range(j)*Tl_Range(i);
        T2 = FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);
        if VarTl_FixQ == 1 % Plot graphs if required
            figure(FigureLab)
            hold on
            plot(x,T2, 'o-')
            xlabel('x')
            ylabel('T')
            title(['Temputature distribution for flow rate (Q) = ', num2str(Q_Range(j))])
        end
    end
    FigureLab =FigureLab+1; % Add one to figure number
end
hold off
end

