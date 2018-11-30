N = 10; % Numebr of loops to be done
SkinTemp = [310:(390-310)/(N-1):390];

parfor i = 1:N
    i
    [gamma(i), ~]=Part2_1b(SkinTemp(i), 1);
end