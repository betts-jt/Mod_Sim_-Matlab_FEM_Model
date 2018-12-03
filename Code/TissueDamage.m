function [Gamma, BurningStart] = TissueDamage(Data, TempE, time)
%   This function computes the level of tissue damage on the skin given a
%   tempurature input on the skins surface. In addition to this it
%   indicates whether a second degree burn has taken place.

TimestepBurn = find(TempE >= 317.15); % find the point where burning starts to occur
TimeBurn = time(TimestepBurn); % Find that times where burning occurs
BurningStart = min(TimeBurn); % Find the time where burning starts to occur

% An array of the tempuratures at E at all the times when burning occurs
TempE1 = TempE(TimestepBurn); 

% Integrate the equation given on the coursework sheet
gamma = trapz(2e98.*exp(-12017./(TempE1-273.15)));

% Multiply by the current timestep so the intergral is performed through
% the correct timestep
Gamma = gamma*Data.dt;

end