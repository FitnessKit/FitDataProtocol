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

    func testCrunchDups() {

        let x = CrunchExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: CrunchExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("CrunchExerciseName Count: \(CrunchExerciseName.supportedExerciseNames.count)")
    }

    func testCrunchCreate() {

        if CrunchExerciseName.create(rawValue: 2) != CrunchExerciseName.circularArmCrunch {
            XCTFail("Wrong Exercise Name")
        }

        if CrunchExerciseName.create(rawValue: 4) != CrunchExerciseName.weightedCrossedArmsCrunch {
            XCTFail("Wrong Exercise Name")
        }

        if CrunchExerciseName.create(rawValue: 84) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testCurlDups() {

        let x = CurlExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: CurlExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("CurlExerciseName Count: \(CurlExerciseName.supportedExerciseNames.count)")
    }

    func testCurlCreate() {

        if CurlExerciseName.create(rawValue: 2) != CurlExerciseName.alternatingInclineDumbbellBicepsCurl {
            XCTFail("Wrong Exercise Name")
        }

        if CurlExerciseName.create(rawValue: 4) != CurlExerciseName.barbellReverseWristCurl {
            XCTFail("Wrong Exercise Name")
        }

        if CurlExerciseName.create(rawValue: 44) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testDeadliftDups() {

        let x = DeadliftExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: DeadliftExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("DeadliftExerciseName Count: \(DeadliftExerciseName.supportedExerciseNames.count)")
    }

    func testDeadliftCreate() {

        if DeadliftExerciseName.create(rawValue: 2) != DeadliftExerciseName.dumbbellDeadlift {
            XCTFail("Wrong Exercise Name")
        }

        if DeadliftExerciseName.create(rawValue: 4) != DeadliftExerciseName.dumbbellStraightLegDeadlift {
            XCTFail("Wrong Exercise Name")
        }

        if DeadliftExerciseName.create(rawValue: 19) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testFlyeDups() {

        let x = FlyeExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: FlyeExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("FlyeExerciseName Count: \(FlyeExerciseName.supportedExerciseNames.count)")
    }

    func testFlyeCreate() {

        if FlyeExerciseName.create(rawValue: 2) != FlyeExerciseName.dumbbellFlye {
            XCTFail("Wrong Exercise Name")
        }

        if FlyeExerciseName.create(rawValue: 4) != FlyeExerciseName.kettlebellFlye {
            XCTFail("Wrong Exercise Name")
        }

        if FlyeExerciseName.create(rawValue: 8) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testHipRaiseDups() {

        let x = HipRaiseExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: HipRaiseExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("HipRaiseExerciseName Count: \(HipRaiseExerciseName.supportedExerciseNames.count)")
    }

    func testHipRaiseCreate() {

        if HipRaiseExerciseName.create(rawValue: 2) != HipRaiseExerciseName.bentKneeSwissBallReverseHipRaise {
            XCTFail("Wrong Exercise Name")
        }

        if HipRaiseExerciseName.create(rawValue: 4) != HipRaiseExerciseName.bridgeWithLegExtension {
            XCTFail("Wrong Exercise Name")
        }

        if HipRaiseExerciseName.create(rawValue: 43) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testHipStabilityDups() {

        let x = HipStabilityExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: HipStabilityExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("HipStabilityExerciseName Count: \(HipStabilityExerciseName.supportedExerciseNames.count)")
    }

    func testHipStabilityCreate() {

        if HipStabilityExerciseName.create(rawValue: 2) != HipStabilityExerciseName.weightedDeadBug {
            XCTFail("Wrong Exercise Name")
        }

        if HipStabilityExerciseName.create(rawValue: 4) != HipStabilityExerciseName.weightedExternalHipRaise {
            XCTFail("Wrong Exercise Name")
        }

        if HipStabilityExerciseName.create(rawValue: 34) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testHipSwingDups() {

        let x = HipSwingExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: HipSwingExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("HipSwingExerciseName Count: \(HipSwingExerciseName.supportedExerciseNames.count)")
    }

    func testHipSwingCreate() {

        if HipSwingExerciseName.create(rawValue: 2) != HipSwingExerciseName.stepOutSwing {
            XCTFail("Wrong Exercise Name")
        }

        if HipSwingExerciseName.create(rawValue: 1) != HipSwingExerciseName.singleArmDumbbellSwing {
            XCTFail("Wrong Exercise Name")
        }

        if HipSwingExerciseName.create(rawValue: 3) != nil {
            XCTFail("Past Current Max")
        }
    }


    func testHyperextensionDups() {

        let x = HyperextensionExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: HyperextensionExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("HyperextensionExerciseName Count: \(HyperextensionExerciseName.supportedExerciseNames.count)")
    }

    func testHyperextensionCreate() {

        if HyperextensionExerciseName.create(rawValue: 2) != HyperextensionExerciseName.baseRotations {
            XCTFail("Wrong Exercise Name")
        }

        if HyperextensionExerciseName.create(rawValue: 4) != HyperextensionExerciseName.bentKneeReverseHyperextension {
            XCTFail("Wrong Exercise Name")
        }

        if HyperextensionExerciseName.create(rawValue: 37) != nil {
            XCTFail("Past Current Max")
        }
    }

    func testLateralRaiseDups() {

        let x = LateralRaiseExerciseName.supportedExerciseNames

        let duplicates = Array(Set(x.filter({ (i: LateralRaiseExerciseName) in x.filter({ $0.number == i.number }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.number) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("LateralRaiseExerciseName Count: \(LateralRaiseExerciseName.supportedExerciseNames.count)")
    }

    func testLateralRaiseCreate() {

        if let nametype = ExerciseCategory.lateralRaise.exerciseName(from: 0) {
            if nametype is LateralRaiseExerciseName == false {
                XCTFail("Wrong Type, Make sure it is added to the Exercise Category")
            }
        }

        if LateralRaiseExerciseName.create(rawValue: 2) != LateralRaiseExerciseName.barMuscleUp {
            XCTFail("Wrong Exercise Name")
        }

        if LateralRaiseExerciseName.create(rawValue: 4) != LateralRaiseExerciseName.cableDiagonalRaise {
            XCTFail("Wrong Exercise Name")
        }

        if LateralRaiseExerciseName.create(rawValue: 32) != nil {
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

        ("testCrunchDups", testCrunchDups),
        ("testCrunchCreate", testCrunchCreate),

        ("testCurlDups", testCurlDups),
        ("testCurlCreate", testCurlCreate),

        ("testDeadliftDups", testDeadliftDups),
        ("testDeadliftCreate", testDeadliftCreate),

        ("testFlyeDups", testFlyeDups),
        ("testFlyeCreate", testFlyeCreate),

        ("testHipRaiseDups", testHipRaiseDups),
        ("testHipRaiseCreate", testHipRaiseCreate),

        ("testHipStabilityDups", testHipStabilityDups),
        ("testHipStabilityCreate", testHipStabilityCreate),

        ("testHipSwingDups", testHipSwingDups),
        ("testHipSwingCreate", testHipSwingCreate),

        ("testHyperextensionDups", testHyperextensionDups),
        ("testHyperextensionCreate", testHyperextensionCreate),

        ("testLateralRaiseDups", testLateralRaiseDups),
        ("testLateralRaiseCreate", testLateralRaiseCreate),

        ]

}
