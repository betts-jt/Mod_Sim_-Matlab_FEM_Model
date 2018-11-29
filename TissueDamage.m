function [Gamma, BurningStart] = TissueDamage(Data, TempE, time)
%   This function computes the level of tissue damage on the skin given a
%   tempurature input on the skins surface. In addition to this it
%   indicates whether a second degree burn has taken place.

TimestepBurn = find(TempE > 317.15); % find the point where burning starts to occur
TimeBurn = time(TimestepBurn); % Find that times where burning occurs
BurningStart = min(TimeBurn); % Find the time where burning starts to occur

gamma = trapz(2e98*exp(-(12017./(TempE-273.15))));

Gamma = gamma*Data.dt;

end