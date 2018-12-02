function [Gamma, BurningStart] = Part2_1b(SurfaceTemp, optimise, timeStep)
% This function runs the code for part 1 fo the modilling and sinulation
% assignment 2
%   SurfaceTemp = initial condition on surface of skin
%   optimise = 1 is the code is being optimised. 0 is not.
%   timeStep = Timestep to use for transient solver

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 0.01; % Maximum vale of x for the elements
Data.Ne = 100; % Numeber of elements in the mesh
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
global c_results
[c_results, Data] = TransientFEMSolver_Part2(Data);

% DETERNIME IF BURNING OCCURS/WHEN
[Gamma, BurningStart]= TissueDamage(Data, Data.TempE, Data.time);

end