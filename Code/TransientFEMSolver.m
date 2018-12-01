function [c_results, Data] = TransientFEMSolver(Data)
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


% INITIALISE DATA MESH
msh = OneDimLinearMeshGen(Data.xmin,Data.xmax,Data.Ne); % Generate the mesh

% INITIALISE MATRACIES
Global_Mat_K = zeros(2*Data.Ne+1);
Global_Mat_M = zeros(2*Data.Ne+1);
Global_Mat = zeros(2*Data.Ne+1);
Global_Vec = zeros(2*Data.Ne+1, 1);
SourceVec = zeros(2*Data.Ne+1,1);

%RUN TRANSIENT SOLVER
% Set current time result based on the initial condition given in the problem
c_current=zeros(2*Data.Ne+1, 1);
c_next=zeros(2*Data.Ne+1, 1);
c_current(2*Data.Ne+1,1) = Data.InitialCon;
c_current(2*Data.Ne+1,1) = 310.15;
c_results = zeros(2*Data.N+1,2*Data.Ne+1);
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
    [Global_Mat, Global_Vec, SourceVec] = GlobalMat_GlobalVec_Assbemly(msh, c_current, Data, Global_Mat_K, Global_Mat_M, SourceVec);
    
    % APPLY BOUNDARY CONDITIONS
    [Global_Mat, Global_Vec] = ApplyBC(Data.BC1T,Data.BC1V,Data.BC2T,Data.BC2V, Data, Global_Mat, Global_Vec);
    
    c_next = Global_Mat\Global_Vec; % generate the solution at the next point
    
    c_current = c_next; % set current to calue of c next
    c_results(k,:) = c_current'; % Store c_current to file

    
    % REINITIALISE MATRACIES
    Global_Mat_K = zeros(2*Data.Ne+1);
    Global_Mat_M = zeros(2*Data.Ne+1);
    SourceVec_next = zeros(2*Data.Ne+1, 1);
    c_next=zeros(2*Data.Ne+1, 1);
    
    % Check if optimisation is taking place
    if Data.optimise == 0 % Answer is not being optimised. Plot graphs
        figure(1)
        plot(Data.x,c_results(k,:)')
        ylabel('Tempurature, K')
        xlabel('Distance through skin, mm')
        legend(['Current Time ' num2str(time(k)) 's'], 'Location', 'NorthWest')
    elseif Data.optimise ==1 % Answer is being optimised. Don't plot graphs
    else
        error('Enter either 0, or 1 for the variable optimise')
    end
end
end