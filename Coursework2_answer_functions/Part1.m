function [] = Part1()
% This function runs the code for part 1 fo the modilling and sinulation
% assignment 2

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 10; % Numeber of elements in the mesh
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction need to be calcualted or 0 is these are not needed
Data.SourceTermConstant = 1; % Value defining whether the source term is constant
Data.dt = 0.01; % Timestep for transient responce
Data.GN = 2; % Set number of N from gausian quadriture

total_t = 1; % Total time for analysis
N = total_t/Data.dt; % Number of timesteps

Data.VariedParamaters = 0; % Value is either 1 if the equation parameters vary with x or 0 if they dont
% Allow used to select solving method
answer = questdlg('Select a sovling method','Solving Method Choice', 'Crank-Nicolson', 'Backwards Euler','Backwards Euler');
% Handle response
switch answer
    case 'Crank-Nicolson'
        disp([answer ' is the selected solving method'])
        Data.Theta = 0.5;
    case 'Backwards Euler'
        disp([answer '  is the selected solving method'])
        Data.Theta = 1;
end

if Data.VariedParamaters == 0
    Data.D = 1; % Set fixed value of D
    Data.lambda = 0; % Set fixed value of lambda
    Data.f = 0; % Set fixed value of f
elseif Data.VariedParamaters ==1
else
    error('Please enter either 0 or 1 for Data.VariedParamaters')
end

% INITIALISE DATA MESH
msh = OneDimLinearMeshGen(Data.xmin,Data.xmax,Data.Ne); % Generate the mesh

% SET UP BOUNDARY CONDITIONS
BC1T = 'D'; % Define type of BC 1
BC1V = 0; % Value of BC1
BC2T = 'D'; % Define type of BC 2
BC2V = 1; % Value of BC2

InitialCon = 0; % Initial condition of the problem in time

time  = 0:Data.dt:(total_t); % Calculte the time for each timestep
x = Data.xmin: (Data.xmax-Data.xmin)/Data.Ne:Data.xmax;

c_current(Data.Ne+1, 1) = InitialCon;
c_results = zeros(N,Data.Ne+1);
c_results(1,:) = c_current;

% INITIALISE MATRACIES
Global_Mat_K = zeros(Data.Ne+1);
Global_Mat_M = zeros(Data.Ne+1);
Global_Mat = zeros(Data.Ne+1);
Global_Vec = zeros(Data.Ne+1, 1);
SourceVec_current = zeros(Data.Ne+1,1);
SourceVec_next = zeros(Data.Ne+1,1);

for k  = 2:N+1
    % CALCULATE THE GLOBAL MATRIX AND VECTOR
    [Global_Mat, Global_Vec] = GlobalMat_GlobalVec_Assbemly(msh, c_current, Data, Global_Mat_K, Global_Mat_M, SourceVec_current, SourceVec_next);
    
    % APPLY BOUNDARY CONDITIONS
    [Global_Mat, Global_Vec] = ApplyBC(BC1T,BC1V,BC2T,BC2V, Data, Global_Mat, Global_Vec);
    
    c_next = Global_Mat\Global_Vec; % generate the solution at the next point
    
    c_current = c_next; % set current to calue of c next
    c_results(k,:) = c_current'; % Store c_current to file
    
    % REINITIALISE MATRACIES
    Global_Mat_K = zeros(Data.Ne+1);
    Global_Mat_M = zeros(Data.Ne+1);
    Global_Mat = zeros(Data.Ne+1);
    Global_Vec = zeros(Data.Ne+1, 1);
    
end

%% PLOT RESULTS
% Plot T distribution at different time values
figure(1)
hold on
plot(x, c_results(1+0.05/0.01,:), '+-')
plot(x, c_results(1+0.1/0.01,:), '+-')
plot(x, c_results(1+0.3/0.01,:), '+-')
plot(x, c_results(1+1/0.01,:), '+-')
title('Numberical Tempurature Distributions')
xlabel('x, mm')
ylabel('Tepturature, K')

c1  = TransientAnalyticSoln(x,0.05);
c2  = TransientAnalyticSoln(x,0.1);
c3  = TransientAnalyticSoln(x,0.3);
c4  = TransientAnalyticSoln(x,1);
plot(x, c1, 'k--')
plot(x, c2, 'k--')
plot(x, c3, 'k--')
plot(x, c4, 'k--')
title('Analytical Tempurature Distribution')
xlabel('x, mm')
ylabel('Tepturature, K')
legend('t=0.05','t=0.1','t=0.3','t=1', 'Analytical Solutions', 'Location', 'NorthWest')

%% Plot analytical solution vs numerical solution
for i=1:N+1
    c(i)  = TransientAnalyticSoln(0.8,time(i));
end
figure(3)
hold on
plot(time, c_results(:,1+8), 'ro-')
plot(time, c, 'b-')
title('Numeric Vs Analytical')
xlabel('t, s')
ylabel('c(x,t)')
legend('Numerical Solution', 'Analytical solution', 'Location' , 'SouthEast')

%% Plot difference between numerical and analytical
figure(4)
plot(time,c-c_results(:,1+8)')
title('Error Between Numerical and Analytical Solutions')
xlabel('t, s')
ylabel('c(x,t)')


%% Plot Unstability of crank nicolson method compared to Euler


end