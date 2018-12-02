clear
clc
close all

PathAdd(); % Add the correct folders to the path to allow all code to run
% SELECT SOLVING METHOD
% Allow user to select solving method
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

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 10; % Numeber of elements in the mesh
Data.dt = 0.01; % Timestep for transient responce
Data.GN = 3; % Set number of N from gausian quadriture
Data.optimise = 1; %No optimisation is taking place

total_t = 1; % Total time for analysis
Data.N = total_t/Data.dt; % Number of timesteps
time  = 0:Data.dt:(total_t); % Calculte the time for each timestep
Data.x = Data.xmin: (Data.xmax-Data.xmin)/(2*Data.Ne):Data.xmax; % Calculate the x position of each point

Data.VariedParamaters = 0; % Value is either 1 if the equation parameters vary with x or 0 if they dont


if Data.VariedParamaters == 0
    Data.D = 1; % Set fixed value of D
    Data.lambda = 0; % Set fixed value of lambda
    Data.f = 0; % Set fixed value of f
elseif Data.VariedParamaters ==1
else
    error('Please enter either 0 or 1 for Data.VariedParamaters')
end

% SET UP BOUNDARY CONDITIONS
Data.BC1T = 'D'; % Define type of BC 1
Data.BC1V = 0; % Value of BC1
Data.BC2T = 'D'; % Define type of BC 2
Data.BC2V = 1; % Value of BC2

Data.InitialCon = 0; % Initial condition of the problem in time


%% RUN TRANSIENT SOLVER
[c_results, ~] = TransientFEMSolver(Data);

%% PLOT RESULTS
% Plot T distribution at different time values
figure(1)
hold on
plot(Data.x(1:2:end), c_results(1+(0.05/0.01),(1:2:end)), '+-')
plot(Data.x(1:2:end), c_results(1+(0.1/0.01),(1:2:end)), '+-')
plot(Data.x(1:2:end), c_results(1+(0.3/0.01),(1:2:end)), '+-')
plot(Data.x(1:2:end), c_results((1+1/0.01),(1:2:end)), '+-')
title('Numberical Tempurature Distributions')
xlabel('x, mm')
ylabel('Tepturature, K')

c1  = TransientAnalyticSoln(Data.x(1:2:end),0.05);
c2  = TransientAnalyticSoln(Data.x(1:2:end),0.1);
c3  = TransientAnalyticSoln(Data.x(1:2:end),0.3);
c4  = TransientAnalyticSoln(Data.x(1:2:end),1);
plot(Data.x(1:2:end), c1, 'k--')
plot(Data.x(1:2:end), c2, 'k--')
plot(Data.x(1:2:end), c3, 'k--')
plot(Data.x(1:2:end), c4, 'k--')
title('Analytical Tempurature Distribution')
xlabel('x, mm')
ylabel('Tepturature, K')
legend('t=0.05','t=0.1','t=0.3','t=1', 'Analytical Solutions', 'Location', 'NorthWest')

%% Plot analytical solution vs numerical solution
for i=1:Data.N+1
    c(i)  = TransientAnalyticSoln(0.8,time(i));
end
figure(3)
hold on
plot(time(1:2:end), c_results((1:2:end),1+16), 'ro-')
plot(time, c, 'b-')
title('Numeric Vs Analytical')
xlabel('t, s')
ylabel('c(x,t)')
legend('Numerical Solution', 'Analytical solution', 'Location' , 'SouthEast')

%% Plot difference between numerical and analytical
figure(4)
hold on
plot(time(1:2:end),c(1:2:end)-c_results((1:2:end),1+16)')
title('Error Between Numerical and Analytical Solutions')
plot([0 1], [0 0], 'k-')
xlabel('t, s')
ylabel('c(x,t)')


%% Plot Unstability of crank nicolson method compared to Euler
%t=0.3
%x=0.5
timestep = [0.001:(0.25-0.001)/9:0.25];
cActual = TransientAnalyticSoln(0.8,0.3);

Data.Theta = 1;
for i = 1:length(timestep)
    Data.dt = timestep(i);
   [c_E, ~] = TransientFEMSolver(Data);
end
