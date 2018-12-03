function [Gamma, BurningStart] = Part2(SurfaceTemp, optimise, timeStep)
% This function runs the code for part 1 fo the modilling and sinulation
% assignment 2
%   SurfaceTemp = initial condition on surface of skin
%   optimise = 1 is the code is being optimised. 0 is not.
%   timeStep = Timestep to use for transient solver

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 0.01; % Maximum vale of x for the elements
Data.Ne = 30; % Numeber of elements in the mesh
Data.dt = timeStep; % Timestep for transient responce
Data.VariedParamaters = 1; % Value is either 1 if the equation parameters vary with x or 0 if they dont
Data.GN = 3; % N value for gausian quadriture
Data.optimise = optimise; % Add optimise value ot data structurre

total_t = 50; % Total time for analysis
Data.N = total_t/Data.dt; % Number of timesteps
Data.time  = 0:Data.dt:(total_t); % Calculte the time for each timestep
Data.x = Data.xmin: (Data.xmax-Data.xmin)/(2*Data.Ne):Data.xmax;

% SET SOLVING PERAMATERS
if Data.VariedParamaters == 0
    Data.D = 1; % Set fixed value of D
    Data.lambda = 0; % Set fixed value of lambda
    Data.f = 0; % Set fixed value of f
elseif Data.VariedParamaters == 1
else
    error('Please enter either 0 or 1 for Data.VariedParamaters')
end


% SET UP BOUNDARY CONDITIONS
Data.BC1T = 'D'; % Define type of BC 1
Data.BC1V = SurfaceTemp; % Value of BC1
Data.BC2T = 'D'; % Define type of BC 2
Data.BC2V = 310.15; % Value of BC2
Data.InitialCon = 310.15; % Initial condition of the problem in time
Data.SurfaceTemp = SurfaceTemp; % Store the current surface temp

%RUN TRANSIENT FEM SOLVER
[c_results, Data] = TransientFEMSolver_Part2(Data);

% PLOT DISTRIBUTION OVER TIME
figure(2)
hold on
grid on
aa = find(Data.time >= 0, 1);
a = find(Data.time >= 0.05, 1);
b = find(Data.time >= 0.2, 1);
c = find(Data.time >= 0.5, 1);
d = find(Data.time >= 1, 1);
e = find(Data.time >= 2, 1);
f = find(Data.time >= 5, 1);
g = find(Data.time >= 50, 1);
plot(Data.x(1:2:end), c_results(aa,1:2:end));
plot(Data.x(1:2:end), c_results(a,1:2:end));
plot(Data.x(1:2:end), c_results(b,1:2:end));
plot(Data.x(1:2:end), c_results(c,1:2:end));
plot(Data.x(1:2:end), c_results(d,1:2:end));
plot(Data.x(1:2:end), c_results(e,1:2:end));
plot(Data.x(1:2:end), c_results(f,1:2:end));
plot(Data.x(1:2:end), c_results(g,1:2:end));
ylabel('Tempurature, K')
xlabel('Distance through skin, mm')
legend(['time = ' num2str(Data.time(a)) 's'], ['time = ' num2str(Data.time(b)) 's'], ['time = ' num2str(Data.time(c)) 's'], ['time = ' num2str(Data.time(d)) 's'], ['time = ' num2str(Data.time(e)) 's'], ['time = ' num2str(Data.time(f)) 's'], ['time = ' num2str(Data.time(g)) 's'])
% DETERNIME IF BURNING OCCURS/WHEN
[Gamma, BurningStart]= TissueDamage(Data, Data.TempE, Data.time);

end