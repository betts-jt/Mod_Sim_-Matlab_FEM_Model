function [] = Part1c_SourceVecTest()
%This fuction runs the nessusary codes cehck that the local source vector
%generator used in part 1c of the coursework runs correctly.

PathAdd(); % Run the funciton that adds all the nessusary folders to the path

% RUN TESTS TO ENSURE LocalElementVec_Source FUNCTIONS CORRECTLY
results = runtests('Part1cUnitTest_LocalSourceVector'); % This line runs the test designed to check LocalElementVec_Source runs correctly

% Part 1c of the course work is completes if all the tests in the above
% code run successfully and withoug fault.

% CHECK THAT ALL TESTS WERE PASSES
if results(1).Passed == 1 && results(2).Passed == 1
    disp('All tests passed. LocalElementVec_Source runs correctly') % If all were compelte display this
else
    error('not all tests in "Part1cUnitTest_LocalSourceVector" were passed. edit LocalElementVec_Source and try again') % If not all tests were complete give an error

end

