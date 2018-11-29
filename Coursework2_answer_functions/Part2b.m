function [Gamma, BurningStart] = Part2b(SurfaceTemp)
% This function runs the code for part 1 fo the modilling and sinulation
% assignment 2

PathAdd(); % Add the correct folders to the path to allow all code to run

% GENERATE A STRUCTURE OF THE RELEVENT PROBLEM VARIABLES
Data.xmin = 0; % Minimum vale of x for the elements
Data.xmax = 0.01; % Maximum vale of x for the elements
Data.Ne = 600; % Numeber of elements in the mesh
Data. reactionNeeded = 0; % Value is either 1 is the problem needs the local element matracies due to reaction need to be calcualted or 0 is these are not needed
Data.SourceTermConstant = 1; % Value defining whether the source term is constant
Data.dt = 0.05; % Timestep for transient responce
total_t = 50; % Total time for analysis
N = total_t/Data.dt; % Number of timesteps

Data.VariedParamaters = 1; % Value is either 1 if the equation parameters vary with x or 0 if they dont
%{
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
%}
Data.Theta = 1;
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

for k  = 2:N+1
    % CALCULATE THE GLOBAL MATRIX AND VECTOR
    [Global_Mat, Global_Vec] = GlobalMat_GlobalVec_Assbemly(msh, c_current, Data, Global_Mat_K, Global_Mat_M);
    
    % APPLY BOUNDARY CONDITIONS
    [Global_Mat, Global_Vec] = ApplyBC(BC1T,BC1V,BC2T,BC2V, Data, Global_Mat, Global_Vec);
    
    c_next = Global_Mat\Global_Vec; % generate the solution at the next point
    
    c_current = c_next; % set current to calue of c next
    c_results(k,:) = c_current'; % Store c_current to file
    
    % FIND TEMPURATURE AT POINT E
    [E_point] =find(round(msh.nvec, 9)==0.001666667); % find when x = E (0.00166667)
    TempE(k-1) = c_results(k, E_point);
    
    % REINITIALISE MATRACIES
    Global_Mat_K = zeros(Data.Ne+1);
    Global_Mat_M = zeros(Data.Ne+1);
    Global_Mat = zeros(Data.Ne+1);
    Global_Vec = zeros(Data.Ne+1, 1);
    %{
    figure(1)
    plot(x,c_results(k,:)')
    ylabel('Tempurature, K')
    xlabel('Distance through skin, mm')
    legend(['Current Time ' num2str(time(k)) 's'], 'Location', 'NorthWest')
   %}
end

% DETERNIME IF BURNING OCCURS/WHEN
[Gamma BurningStart]= TissueDamage(Data, TempE, time)

end