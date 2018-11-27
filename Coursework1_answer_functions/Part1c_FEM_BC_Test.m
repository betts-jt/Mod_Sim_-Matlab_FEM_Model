function [] = Part1c_FEM_BC_Test()
%This fuction runs the nessusary codes check that the FEM_BC solver
% used in part 1c of the coursework runs correctly.

PathAdd(); % Run the funciton that adds all the nessusary folders to the path

% RUN TESTS TO ENSURE FEM_BC FUNCTIONS CORRECTLY
results = runtests('Part1cUnitTest_FEM_BC'); % This line runs the test designed to check FEM_BC runs correctly

% Part 1c of the course work is completes if all the tests in the above
% code run successfully and withoug fault.

% CHECK THAT ALL TESTS WERE PASSES
if results(1).Passed == 1
    disp('All tests passed. FEM_BC runs correctly') % If all were compelte display this
else
    error('not all tests in "Part1cUnitTest_FEM_BC" were passed. edit FEM_BC and try again') % If not all tests were complete give an error

end

