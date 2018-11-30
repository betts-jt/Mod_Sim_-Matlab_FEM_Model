N = 10; % Numebr of loops to be done

TempMax = 390; % Maximum tempurature to be tested initially
TempMin = 310; % Minimum tempurature to be tested initially
timeSteps = [0.5, 0.5, 0.5, 0.5]; % Array of timesteps to be tested. Can be any legnth

for k = 1:length(timeSteps)
    % Generate array of legnth N of tempuratures to be tried
    SkinTemp = [TempMin:(TempMax-TempMin)/(N-1):TempMax];
    % DISPLAY CURRENT TESTING CONDITIONS
    disp('***********************************')
    disp(['Current Timestep = ' num2str(timeSteps(k)) 's'])
    disp(['Testing between ' num2str(TempMin) 'K and ' num2str(TempMax) 'K'])
    disp('***********************************')
    
    %RUN THROUGH CURRENT RANGE OF START TEMPS
    parfor i = 1:N
        [gamma(i), ~]=Part2_1b(SkinTemp(i), 1, timeSteps(k));
    end
    
    %SET UP VARIABLES FOR NEXT LOOP
    TempMin = SkinTemp(max(find(gamma<1)));
    TempMax = SkinTemp(min(find(gamma>1)));
end

% DISPLAYING OUTCOME OF OPTIMISER
disp('***********************************')
disp('***********************************')
disp(['The tempurature at which burning occurs = ' num2str(TempMin) 'K'])

% Find the required temp reduction of clothing to nearest 0.5K
TempReduction = 393.15-TempMin; % The actual required tempurature reduction

TempReduction_roundedDown = fix(TempReduction); % round down to the nearest integer

% Check is rounded answer is greater than x.5. this is to ensure that the
% burn temp is never exceeded
if TempReduction > TempReduction_roundedDown + 0.5
    TempReduction = TempReduction_roundedDown+1; % If it is add 1 to rounded answer 
else 
    TempReduction = TempReduction_roundedDown+0.5; % If it is add 0.5 to rounded answer 
end
disp(['The required tempurature reduction of the protective clothing is ' num2str(TempReduction) 'K to the nearest 0.5 K'])
disp('***********************************')
disp('***********************************')