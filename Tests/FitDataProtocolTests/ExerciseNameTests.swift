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


    func testCardioDups() {

        let x = CardioExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: CardioExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("CardioExerciseName Count: \(CardioExerciseName.supportedExerciseNames.count)")
    }

    func testCardioCreate() {

        if CardioExerciseName.create(rawValue: 2) != CardioExerciseName.cardioCoreCrawl {
            XCTFail("Wrong Exercise Name")
        }

        if CardioExerciseName.create(rawValue: 21) != CardioExerciseName.weightedTripleUnder {
            XCTFail("Wrong Exercise Name")
        }

        if CardioExerciseName.create(rawValue: 22) != nil {
            XCTFail("Past Current Max")
        }

    }

    func testCarryDups() {

        let x = CarryExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: CarryExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("CarryExerciseName Count: \(CarryExerciseName.supportedExerciseNames.count)")
    }

    func testCarryCreate() {

        if CarryExerciseName.create(rawValue: 2) != CarryExerciseName.farmersWalkOnToes {
            XCTFail("Wrong Exercise Name")
        }

        if CarryExerciseName.create(rawValue: 4) != CarryExerciseName.overheadCarry {
            XCTFail("Wrong Exercise Name")
        }

        if CarryExerciseName.create(rawValue: 5) != nil {
            XCTFail("Past Current Max")
        }

    }

    func testChopDups() {

        let x = ChopExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: ChopExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("ChopExerciseName Count: \(ChopExerciseName.supportedExerciseNames.count)")
    }

    func testChopCreate() {

        if ChopExerciseName.create(rawValue: 2) != ChopExerciseName.cableWoodchop {
            XCTFail("Wrong Exercise Name")
        }

        if ChopExerciseName.create(rawValue: 4) != ChopExerciseName.weightedCrossChopToKnee {
            XCTFail("Wrong Exercise Name")
        }

        if ChopExerciseName.create(rawValue: 23) != nil {
            XCTFail("Past Current Max")
        }

    }

    func testCoreDups() {

        let x = CoreExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: CoreExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("CoreExerciseName Count: \(CoreExerciseName.supportedExerciseNames.count)")
    }

    func testCoreCreate() {

        if CoreExerciseName.create(rawValue: 2) != CoreExerciseName.alternatingPlateReach {
            XCTFail("Wrong Exercise Name")
        }

        if CoreExerciseName.create(rawValue: 4) != CoreExerciseName.weightedBarbellRollout {
            XCTFail("Wrong Exercise Name")
        }

        if CoreExerciseName.create(rawValue: 46) != nil {
            XCTFail("Past Current Max")
        }

    }


    static var allTests = [
        ("testBenchPressDups", testBenchPressDups),
        ("testBenchPressCreate", testCalfRaiseDups),
        ("testCalfRaiseDups", testCalfRaiseDups),
        ("testCalfRaiseCreate", testCalfRaiseCreate),
        ("testCardioDups", testCardioDups),
        ("testCardioCreate", testCardioCreate),
        ("testCarryDups", testCarryDups),
        ("testCarryCreate", testCarryCreate),
        ("testChopDups", testChopDups),
        ("testChopCreate", testChopCreate),
        ("testCoreDups", testCoreDups),
        ("testCoreCreate", testCoreCreate),
        ]

}
