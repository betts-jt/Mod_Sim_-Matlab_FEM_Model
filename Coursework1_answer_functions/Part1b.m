function [] = Part1b()
%This fuction runs the nessusary codes to complete part 1b of the
%coursework sheet. This can be found in the documents folder.

PathAdd(); % Run the funciton that adds all the nessusary folders to the path

% RUN TESTS TO ENSURE LocalElementMat_Reaction FUNCTIONS CORRECTLY
results = runtests('Part1bUnitTest.m'); % This line runs the test designed to check LocalElementMat_Reaction runs correctly

% Part 1b of the course work is completes if all the tests in the above
% code run successfully and withoug fault.

% CHECK THAT ALL TESTS WERE PASSES
if results(1).Passed == 1 && results(2).Passed == 1 && results(3).Passed==1 && results(4).Passed==1
    disp('All tests passed. Part 1b complete') % If all were compelte display this
else
    error('not all tests in "Part1bUnitTest" were passed. edit Part1bUnitTest.m and try again') % If not all tests were complete give an error

end

