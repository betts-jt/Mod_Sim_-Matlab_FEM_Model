N = 10; % Numebr of loops to be done

TempMax = 390;
TempMin = 310;
timeSteps = [0.5, 0.01, 0.005];

for k = 1:length(timeSteps)
    SkinTemp = [TempMin:(TempMax-TempMin)/(N-1):TempMax]
    
    parfor i = 1:N
        i
        [gamma(i), ~]=Part2_1b(SkinTemp(i), 1, timeSteps(k));
    end
    
    TempMin = SkinTemp(max(find(gamma<1)));
    Tempmax = SkinTemp(min(find(gamma>1)));
end