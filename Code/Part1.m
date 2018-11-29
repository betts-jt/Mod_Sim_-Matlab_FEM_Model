PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 1; % Maximum vale of x for the elements
Data.Ne = 10; % Numeber of elements in the mesh
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction need to be calcualted or 0 is these are not needed
Data.SourceNeeded = 0; % Value is either 1 is the problem needs the local element vector due to source need to be calcualted or 0 is these are not needed.
Data.SourceTermConstant = 1; % Value defining whether the source term is constant

Data.dt = 0.1; % Timestep for transient responce
total_t = 5; % Total time for analysis
N = total_t/Data.dt; % Number of timesteps

Data.Theta = 0; % Value difining the method to be used to solve the transient resonce. 0.5 for Crank Nicolson. 1 for Backward Euler


BC1T = 'D'; % Define type of BC 1
BC1V = 0; % Value of BC1
BC2T = 'D'; % Define type of BC 2
BC2V = 1; % Value of BC2
InitialCon = 0; % Initial condition of the problem in time

time  = 0:Data.dt:(total_t); % Calculte the time for each timestep
x = Data.xmin: Data

c_results = zeros(N,Data.Ne)
c_results(1,:) = InitialCon; 

for k  = 2:N+1
    [c(k).time, Global_Mat(k).time, Global_Mat_K(k).time, Global_Mat_M(k).time, SourceGlobal_Vec(k).time] = Trans_FEM_BC(BC1T,BC1V,BC2T,BC2V, Data);
    
    % Calculate the matrix to multiply to the previous solution
    A = Global_Mat_M(k).time-((1-Data.Theta)*Data.dt*Global_Mat_K(k).time);
    
    % Multiply the above by the previous solution
    Ac = A*c(k-1).time;
    
    B = Data.dt*Data.Theta(SourceGlobal_Vec(k));
    
    C = Data.dt*(1-Data.Theta)(SourceGlobal_Vec(k-1))

    Global_Vector = Ac + B + C; % Caluclate the global source vector
end