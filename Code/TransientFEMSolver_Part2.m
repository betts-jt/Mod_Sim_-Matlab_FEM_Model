function [c_results, Data] = TransientFEMSolver_Part2(Data)

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
    [E_point] =find(round(msh.nvec, 9)==0.001666667); % find when x = E (0.00166667)
    TempE(k) = c_results(k, E_point);
    
    
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