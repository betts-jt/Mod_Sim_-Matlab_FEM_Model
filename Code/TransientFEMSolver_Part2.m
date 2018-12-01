function [c_results, Data] = TransientFEMSolver_Part2(Data)
% This function solves a transient FEM problem given an input data
%structure D. In this data structure;
%   Data.xmin = Minimum vale of x for the elements
%   Data.xmax = Maximum vale of x for the elements
%   Data.Ne = Number of elements in the mesh
%   Data.dt = Timestep for transient responce
%   Data.VariedParameters = Value is either 1 if the equation parameters vary with x or 0 if they dont
%   Data.GN = N value for gausian quadriture
%   Data.optimise = Add optimise value ot data structurre
%   Data.N = Number of timesteps
%   Data.time = Array of times for each timestep. Between 0 and max time
%       (length N)
%   Data.x = Array of x values between xmin and xmax. (length Ne)
%   Data.BC1T = Define type of BC 1. 'D' or dirichlet/'N' for Neumann
%   Data.BC1V = Value of BC1
%   Data.BC2T = Define type of BC 2. 'D' or dirichlet/'N' for Neumann
%   Data.BC2V = Value of BC2
%   Data.InitialCon = Initial condition of transient responce.

% SELECT SOLVING METHOD
% Check if the code if running once or though an optimiser
if Data.optimise == 0 % No optimisation in taking place
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
elseif Data.optimise ==1 % Optimisation is taking place
    Data.Theta = 1; % Set the solving method used in the optimiser
else
    error('Enter either 0, or 1 for the variable optimise')
end

% INITIALISE DATA MESH
msh = OneDimLinearMeshGen(Data.xmin,Data.xmax,Data.Ne); % Generate the mesh

% INITIALISE MATRACIES
Global_Mat_K = zeros(Data.Ne+1);
Global_Mat_M = zeros(Data.Ne+1);
Global_Mat = zeros(Data.Ne+1);
Global_Vec = zeros(Data.Ne+1, 1);
SourceVec_current = zeros(Data.Ne+1,1);
SourceVec_next = zeros(Data.Ne+1,1);

%RUN TRANSIENT SOLVER
% Set current time result based on the initial condition given in the problem
c_current=zeros(Data.Ne+1, 1);
c_current(:,1) = Data.InitialCon;
c_current(Data.Ne+1,1) = 310.15;
c_results = zeros(Data.N,Data.Ne+1);
c_results(1,:) = c_current;

%apply BC to this initial solution (only aplies to Dirichlet)
if Data.BC1T == 'D'
    c_current(1,1) = Data.BC1V; % Set start value to the value of BC1
end
if Data.BC2T == 'D'
    c_current(end,1) = Data.BC2V; % Set last value to that of BC2
end

for k  = 2:Data.N+1
    % CALCULATE THE GLOBAL MATRIX AND VECTOR
    [Global_Mat, Global_Vec] = GlobalMat_GlobalVec_Assbemly(msh, c_current, Data, Global_Mat_K, Global_Mat_M, SourceVec_current, SourceVec_next);
    
    % APPLY BOUNDARY CONDITIONS
    [Global_Mat, Global_Vec] = ApplyBC(Data.BC1T,Data.BC1V,Data.BC2T,Data.BC2V, Data, Global_Mat, Global_Vec);
    
    c_next = Global_Mat\Global_Vec; % generate the solution at the next point
    
    c_current = c_next; % set current to calue of c next
    c_results(k,:) = c_current'; % Store c_current to file
    
    
    % FIND TEMPURATURE AT POINT E
    E = 0.00166667; % The value of x at point E
    After_E = find(msh.nvec > 0.00166667, 1); % The x node position after E
    Before_E = After_E-1; % The E nodal position before E
    
    TempBefore_E = c_results(k, Before_E); % The temp at the node beofre E
    TempAfter_E = c_results(k, After_E); % The temp at the node after E
    
    %Linieary interpolate to fine the value at E
    TempE(k) = interp1([msh.nvec(Before_E) msh.nvec(After_E)], [TempBefore_E TempAfter_E], E);
    
    
    SourceVec_current = SourceVec_next;
    
    % REINITIALISE MATRACIES
    Global_Mat_K = zeros(Data.Ne+1);
    Global_Mat_M = zeros(Data.Ne+1);
    Global_Mat = zeros(Data.Ne+1);
    Global_Vec = zeros(Data.Ne+1, 1);
    
    % Check if optimisation is taking place
    if Data.optimise == 0 % Answer is not being optimised. Plot graphs
        figure(1)
        plot(Data.x,c_results(k,:)')
        ylabel('Tempurature, K')
        xlabel('Distance through skin, mm')
        legend(['Current Time ' num2str(Data.time(k)) 's'], 'Location', 'NorthWest')
    elseif Data.optimise ==1 % Answer is being optimised. Don't plot graphs
    else
        error('Enter either 0, or 1 for the variable optimise')
    end
end
Data.TempE = TempE;
end