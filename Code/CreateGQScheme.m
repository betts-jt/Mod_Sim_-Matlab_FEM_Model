function [gq] = CreateGQScheme(N)
%CreateGQScheme Creates GQ Scheme of order N
%   Creates and initialises a data structure
gq.npts = N;
if (N > 0) && (N < 4)
    %order of quadrature scheme i.e. %number of Gauss points
    gq.wi = zeros(N,1); %array of Gauss weights
    gq.Xipt = zeros(N,1); %array of Gauss points
    switch N
        case 1
            gq.wi(1) = 2;
            gq.Xipt(1) = 0;
        case 2
            gq.wi(:) = 1;
            gq.Xipt(1) = -sqrt(1/3);
            gq.Xipt(2) = sqrt(1/3);
        case 3
            gq.wi(1) = 8/9;
            gq.wi(2) = 5/9;
            gq.wi(3) = 5/9;
            gq.Xipt(1) = 0.0;
            gq.Xipt(2) = -sqrt(3/5);
            gq.Xipt(3) = sqrt(3/5);
            
    end
    
else
    fprintf('Invalid number of Gauss points specified');
end
end

