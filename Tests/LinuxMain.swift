import XCTest
@testable import FitDataProtocolTests

XCTMain([
    testCase(FitDataProtocolTests.allTests),
    testCase(FitMessageTests.allTests),
    testCase(ExerciseNameTests.allTests),
    testCase(ResolutionTest.allTests)
])
