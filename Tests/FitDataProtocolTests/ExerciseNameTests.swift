//
//  ExerciseNameTests.swift
//  FitDataProtocolTests
//
//  Created by Kevin Hoogheem on 2/11/18.
//

import XCTest
@testable import FitDataProtocol

class ExerciseNameTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBenchPressDups() {

        let x = BenchPressExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: BenchPressExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("BenchPressExerciseName Count: \(BenchPressExerciseName.supportedExerciseNames.count)")
    }

    func testBenchPressCreate() {

        if BenchPressExerciseName.create(rawValue: 2) != BenchPressExerciseName.barbellBoardBenchPress {
            XCTFail("Wrong Exercise Name")
        }

        if BenchPressExerciseName.create(rawValue: 26) != BenchPressExerciseName.alternatingDumbbellChestPress {
            XCTFail("Wrong Exercise Name")
        }

        if BenchPressExerciseName.create(rawValue: 27) != nil {
            XCTFail("Past Current Max")
        }

    }


    func testCalfRaiseDups() {

        let x = CalfRaiseExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: CalfRaiseExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("CalfRaiseExerciseName Count: \(CalfRaiseExerciseName.supportedExerciseNames.count)")
    }

    func testCalfRaiseCreate() {

        if CalfRaiseExerciseName.create(rawValue: 2) != CalfRaiseExerciseName.threewaySingleLegCalfRaise {
            XCTFail("Wrong Exercise Name")
        }

        if CalfRaiseExerciseName.create(rawValue: 20) != CalfRaiseExerciseName.weightedStandingDumbbellCalfRaise {
            XCTFail("Wrong Exercise Name")
        }

        if CalfRaiseExerciseName.create(rawValue: 21) != nil {
            XCTFail("Past Current Max")
        }

    }


    static var allTests = [
        ("testBenchPressDups", testBenchPressDups),
        ("testBenchPressCreate", testCalfRaiseDups),
        ("testCalfRaiseDups", testCalfRaiseDups),
        ("testCalfRaiseCreate", testCalfRaiseCreate),
        ]

}
