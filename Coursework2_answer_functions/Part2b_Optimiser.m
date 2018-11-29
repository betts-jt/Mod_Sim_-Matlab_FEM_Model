N = 20; % Numebr of loops to be done
SkinTemp = [310:(330-310)/(N-1):330];

for i = 1:N
    i
    [gamma(i), ~]=Part2b(SkinTemp(i));
end