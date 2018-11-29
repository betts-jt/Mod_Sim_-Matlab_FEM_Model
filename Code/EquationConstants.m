function [Data] = EquationConstants(nvec, Data)
%   This funciton computes the values of lambda, f and D where they vary
%   across the x value of the material

% SETTING THE THINCKNESSES OF THE SKIN
E = 0.00166667; % Epidermis outer thickness
D = 0.0005; % Dermis outer thickness
B = 0.01; % Total skin thickness

% Setting the variables that make up D, lambda and f depending on position
% of the point through the skin

if nvec <= E % If the point is in the Epidermis
    k = 25; 
    G = 0; 
    rho = 1200; 
    c = 3300;
elseif nvec > E && nvec <= D % If the point is in the Epidermis
    k = 40;
    G = 0;
    rho = 1200;
    c = 3300;
    rho_b = 1060;
    c_b = 3770;
    T_b = 310.15;
elseif nvec >D && nvec <= B
    k = 20;
    G = 0; 
    rho = 1200;
    c = 3300; 
    rho_b = 1060;
    c_b = 3770;
    T_b = 310.15;
end

Data.D = k/(rho*c); % Calculate the diffution coefficient
Data.lambda = (G*rho_b*c_b)/(rho*c); % Calucalteing the reaction coefficient
Data.f = (G*rho_b*c_b)/(rho*c)*T_b; % Calculating the source term
end


