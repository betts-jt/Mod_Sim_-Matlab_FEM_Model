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
Data.Ne = 600; % Numeber of elements in the mesh
Data. reactionNeeded = 1; % Value is either 1 is the problem needs the local element matracies due to reaction need to be calcualted or 0 is these are not needed
Data.SourceTermConstant = 1; % Value defining whether the source term is constant
Data.dt = timeStep; % Timestep for transient responce
total_t = 50; % Total time for analysis
N = total_t/Data.dt; % Number of timesteps

Data.VariedParamaters = 1; % Value is either 1 if the equation parameters vary with x or 0 if they dont

% SELECT SOLVING METHOD
% Check if the code if running once or though an optimiser
if optimise == 0 % No optimisation in taking place
    % Allow used to select solving method
    answer = questdlg('Select a sovling method','Solving Method Choice', 'Crank-Nicolson', 'Backwards Euler','Backwards Euler');
    % Handle response
    switch answer
        case 'Crank-Nicolson'
            disp('***********************************')
            disp([answer ' is the selected solving method'])
            Data.Theta = 0.5;
        case 'Backwards Euler'
            disp('***********************************')
            disp([answer '  is the selected solving method'])
            Data.Theta = 1;
    end
elseif optimise ==1 % Optimisation is taking place
    Data.Theta = 1; % Set the solving method used in the optimiser
else
    error('Enter either 0, or 1 for the variable optimise')
end

%SELECT N FOR GAUSSIAN QUADRITURE SCHEME
% Check if the code if running once or though an optimiser
if optimise == 0 % No optimisation in taking place
    % Allow used to select a value of n
    answer = questdlg('Select a value of N for Gaussian Quadriture' ,'Value of N','1', '2', '3','2');
    % Handle response
    switch answer
        case '1'
            disp(['The selected vaule of N for Gaussian Quadriture = ' answer])
            disp('***********************************')
            Data.GN = 1;
        case '2'
            disp(['The selected vaule of N for Gaussian Quadriture = ' answer])
            disp('***********************************')
            Data.GN =2;
        case '3'
            disp(['The selected vaule of N for Gaussian Quadriture = ' answer])
            disp('***********************************')
            Data.GN = 3;
    end
elseif optimise ==1 % Optimisation is taking place
    Data.GN = 2; % Set the solving method used in the optimiser
else
    error('Enter either 0, or 1 for the variable optimise')
end

% SET SOLVING PERAMATERS
if Data.VariedParamaters == 0
    Data.D = 1; % Set fixed value of D
    Data.lambda = 0; % Set fixed value of lambda
    Data.f = 0; % Set fixed value of f
elseif Data.VariedParamaters == 1
else
    error('Please enter either 0 or 1 for Data.VariedParamaters')
end

% INITIALISE DATA MESH
msh = OneDimLinearMeshGen(Data.xmin,Data.xmax,Data.Ne); % Generate the mesh

% SET UP BOUNDARY CONDITIONS
BC1T = 'D'; % Define type of BC 1
BC1V = SurfaceTemp; % Value of BC1
BC2T = 'D'; % Define type of BC 2
BC2V = 310.15; % Value of BC2

InitialCon = 310.15; % Initial condition of the problem in time

time  = 0:Data.dt:(total_t); % Calculte the time for each timestep
x = Data.xmin: (Data.xmax-Data.xmin)/Data.Ne:Data.xmax;

c_current=zeros(Data.Ne+1, 1);
c_current(:,1) = InitialCon;
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
    [Global_Mat, Global_Vec, SourceVec_next] = GlobalMat_GlobalVec_Assbemly(msh, c_current, Data, Global_Mat_K, Global_Mat_M, SourceVec_current, SourceVec_next);
    
    % APPLY BOUNDARY CONDITIONS
    [Global_Mat, Global_Vec] = ApplyBC(BC1T,BC1V,BC2T,BC2V, Data, Global_Mat, Global_Vec);
    
    c_next = Global_Mat\Global_Vec; % generate the solution at the next point
    
    c_current = c_next; % set current to calue of c next
    c_results(k,:) = c_current'; % Store c_current to file
    
    % FIND TEMPURATURE AT POINT E
    [E_point] =find(round(msh.nvec, 9)==0.001666667); % find when x = E (0.00166667)
    TempE(k-1) = c_results(k, E_point);
    
    SourceVec_current = SourceVec_next;
    
    % REINITIALISE MATRACIES
    Global_Mat_K = zeros(Data.Ne+1);
    Global_Mat_M = zeros(Data.Ne+1);
    Global_Mat = zeros(Data.Ne+1);
    Global_Vec = zeros(Data.Ne+1, 1);
    SourceVec_next = zeros(Data.Ne+1,1);
    
    % Check if optimisation is taking place
    if optimise == 0 % Answer is not being optimised. Plot graphs
        figure(1)
        plot(x,c_results(k,:)')
        ylabel('Tempurature, K')
        xlabel('Distance through skin, mm')
        legend(['Current Time ' num2str(time(k)) 's'], 'Location', 'NorthWest')
    elseif optimise ==1 % Answer is being optimised. Don't plot graphs
    else
        error('Enter either 0, or 1 for the variable optimise')
    end
    
    % DETERNIME IF BURNING OCCURS/WHEN
    [Gamma BurningStart]= TissueDamage(Data, TempE, time);
    
end
end