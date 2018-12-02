function [Data] = SolvingMethod(Data)

% Open box to allow user to select solving method
answer = questdlg('Select a sovling method','Solving Method Choice', ...
    'Crank-Nicolson', 'Backwards Euler','Backwards Euler');
% Handle response
switch answer
    case 'Crank-Nicolson'
        disp([answer ' is the selected solving method'])
        Data.Theta = 0.5; % Set theta to 0.05 if Crank-Nicolson is selected
    case 'Backwards Euler'
        disp([answer '  is the selected solving method'])
        Data.Theta = 1; % Set theta to 0.05 if Crank-Nicolson is selected
end