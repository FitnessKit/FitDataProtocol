//
//  PlankExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/23/19.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// Plank Exercise Name
public struct PlankExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = PlankExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .plank }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension PlankExerciseName: Hashable {}

public extension PlankExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [PlankExerciseName] {

        return [.fortyFiveDegreePlan,
                .weightedFortyFiveDegreePlan,
                .nintyDegreeStaticHold,
                .weightedNintyDegreeStaticHold,
                .bearCrawl,
                .weightedBearCrawl,
                .crossBodyMountainClimber,
                .weightedCrossBodyMountainClimber,
                .elbowPlankPikeJacks,
                .weightedElbowPlankPikeJacks,
                .elevatedFeetPlank,
                .weightedElevatedFeetPlank,
                .elevatorAbs,
                .weightedElevatorAbs,
                .extendedPlank,
                .weightedExtendedPlank,
                .fullPlankPasseTwist,
                .weightedFullPlankPasseTwist,
                .inchingElbowPlank,
                .weightedInchingElbowPlank,
                .inchwormSidePlank,
                .weightedInchwormSidePlank,
                .kneelingPlank,
                .weightedKneelingPlank,
                .kneelingSidePlankLegLift,
                .weightedKneelingSidePlankLegLift,
                .lateralRoll,
                .weightedLateralRoll,
                .lyingReversePlank,
                .weightedLyingReversePlank,
                .medicineBallMountainClimber,
                .weightedMedicineBallMountainClimber,
                .modifiedMountainCimberExtension,
                .weightedModifiedMountainCimberExtension,
                .mountainCimber,
                .weightedMountainCimber,
                .mountainCimberSlidingDiscs,
                .weightedMountainCimberSlidingDiscs,
                .mountainClimberFeetBosuBall,
                .weightedMountainClimberFeetBosuBall,
                .mountainClimberHandsBench,
                .mountainClimberHandsSwissBall,
                .weightedMountainClimberHandsSwissBall,
                .plank,
                .plankJacksFeetSlidingDiscs,
                .weightedPlankJacksFeetSlidingDiscs,
                .plankKneeTwist,
                .weightedPlankKneeTwist,
                .plankPikeJumps,
                .weightedPlankPikeJumps,
                .plankPikes,
                .weightedPlankPikes,
                .plankStandUp,
                .weightedPlankStandUp,
                .plankArmRaise,
                .weightedPlankArmRaise,
                .plankKneeElbow,
                .weightedPlankKneeElbow,
                .plankObliqueCrunch,
                .weightedPlankObliqueCrunch,
                .plyometricSidePlank,
                .weightedPlyometricSidePlank,
                .rollingSidePlank,
                .weightedRollingSidePlank,
                .sideKickPlank,
                .weightedSideKickPlank,
                .sidePlank,
                .weightedSidePlank,
                .sidePlankRow,
                .weightedSidePlankRow,
                .sidePlankLift,
                .weightedSidePlankLift,
                .sidePlankElbowBosuBall,
                .weightedSidePlankElbowBosuBall,
                .sidePlankFeetBench,
                .weightedSidePlankFeetBench,
                .sidePlankKneedCircle,
                .weightedSidePlankKneedCircle,
                .sidePlankKneeTuck,
                .weightedSidePlankKneeTuck,
                .sidePlankLegLift,
                .weightedSidePlankLegLift,
                .sidePlankReachUnder,
                .weightedSidePlankReachUnder,
                .singleLegElevatedFeetPlank,
                .weightedSingleLegElevatedFeetPlank,
                .singleLegFlexExtend,
                .weightedSingleLegFlexExtend,
                .singleLegSidePlank,
                .weightedSingleLegSidePlank,
                .spidermanPlank,
                .weightedSpidermanPlank,
                .straightArmPlank,
                .weightedStraightArmPlank,
                .straightArmPlankShoulderTouch,
                .weightedStraightArmPlankShoulderTouch,
                .swissBallPlank,
                .weightedSwissBallPlank,
                .swissBallPlankLegLift,
                .weightedSwissBallPlankLegLift,
                .swissBallPlankLegLiftHold,
                .swissBallPlankFeetBench,
                .weightedSwissBallPlankFeetBench,
                .swissBallProneJackknife,
                .weightedSwissBallProneJackknife,
                .swissBallSidePlank,
                .weightedSwissBallSidePlank,
                .threeWayPlank,
                .weightedThreeWayPlank,
                .towelPlankKneeIn,
                .weightedTowelPlankKneeIn,
                .tStabilization,
                .weightedTStabilization,
                .turkishGetUpSidePlank,
                .weightedTurkishGetUpSidePlank,
                .twoPointPlank,
                .weightedTwoPointPlank,
                .weightedPlank,
                .wideStancePlankDiagonalArmLift,
                .weightedWideStancePlankDiagonalArmLift,
                .wideStancePlankDiagonalLegLift,
                .weightedWideStancePlankDiagonalLegLift,
                .wideStancePlankLegLift,
                .weightedWideStancePlankLegLift,
                .wideStancePlankOppositeArmLegLift,
                .weightedMountainClimberHandsBench,
                .weightedSwissBallPlankLegLiftHold,
                .weightedWideStancePlankOppositeArmLegLift,
                .plankFeetSwissBall,
                .sidePlankPlankReachUnder,
                .bridgeGluteLowerLift,
                .bridgeOneLegBridge,
                .plankArmVariations,
                .plankLegLift,
                .reversePlankLegPull
        ]
    }
}

public extension PlankExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> PlankExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension PlankExerciseName {

    /// 45 Degree Plank
    static var fortyFiveDegreePlan: PlankExerciseName {
        return PlankExerciseName(name: "45 Degree Plank", number: 0)
    }

    /// Weighted 45 Degree Plank
    static var weightedFortyFiveDegreePlan: PlankExerciseName {
        return PlankExerciseName(name: "Weighted 45 Degree Plank", number: 1)
    }

    /// 90 Degree Static Hold
    static var nintyDegreeStaticHold: PlankExerciseName {
        return PlankExerciseName(name: "90 Degree Static Hold", number: 2)
    }

    /// Weighted 90 Degree Static Hold
    static var weightedNintyDegreeStaticHold: PlankExerciseName {
        return PlankExerciseName(name: "Weighted 90 Degree Static Hold", number: 3)
    }

    /// Bear Crawl
    static var bearCrawl: PlankExerciseName {
        return PlankExerciseName(name: "Bear Crawl", number: 4)
    }

    /// Weighted Bear Crawl
    static var weightedBearCrawl: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Bear Crawl", number: 5)
    }

    /// Cross Body Mountain Climber
    static var crossBodyMountainClimber: PlankExerciseName {
        return PlankExerciseName(name: "Cross Body Mountain Climber", number: 6)
    }

    /// Weighted Cross Body Mountain Climber
    static var weightedCrossBodyMountainClimber: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Cross Body Mountain Climber", number: 7)
    }

    /// Elbow Plank Pike Jacks
    static var elbowPlankPikeJacks: PlankExerciseName {
        return PlankExerciseName(name: "Elbow Plank Pike Jacks", number: 8)
    }

    /// Weighted Elbow Plank Pike Jacks
    static var weightedElbowPlankPikeJacks: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Elbow Plank Pike Jacks", number: 9)
    }

    /// Elevated Feet Plank
    static var elevatedFeetPlank: PlankExerciseName {
        return PlankExerciseName(name: "Elevated Feet Plank", number: 10)
    }

    /// Weighted Elevated Feet Plank
    static var weightedElevatedFeetPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Elevated Feet Plank", number: 11)
    }

    /// Elevator Abs
    static var elevatorAbs: PlankExerciseName {
        return PlankExerciseName(name: "Elevator Abs", number: 12)
    }

    /// Weighted Elevator Abs
    static var weightedElevatorAbs: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Elevator Abs", number: 13)
    }

    /// Extended Plank
    static var extendedPlank: PlankExerciseName {
        return PlankExerciseName(name: "Extended Plank", number: 14)
    }

    /// Weighted Extended Plank
    static var weightedExtendedPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Extended Plank", number: 15)
    }

    /// Full Plank Passe Twist
    static var fullPlankPasseTwist: PlankExerciseName {
        return PlankExerciseName(name: "Full Plank Passe Twist", number: 16)
    }

    /// Weighted Full Plank Passe Twist
    static var weightedFullPlankPasseTwist: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Full Plank Passe Twist", number: 17)
    }

    /// Inching Elbow Plank
    static var inchingElbowPlank: PlankExerciseName {
        return PlankExerciseName(name: "Inching Elbow Plank", number: 18)
    }

    /// Weighted Inching Elbow Plank
    static var weightedInchingElbowPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Inching Elbow Plank", number: 19)
    }

    /// Inchworm to Side Plank
    static var inchwormSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Inchworm to Side Plank", number: 20)
    }

    /// Weighted Inchworm to Side Plank
    static var weightedInchwormSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Inchworm to Side Plank", number: 21)
    }

    /// Kneeling Plank
    static var kneelingPlank: PlankExerciseName {
        return PlankExerciseName(name: "Kneeling Plank", number: 22)
    }

    /// Weighted Kneeling Plank
    static var weightedKneelingPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Kneeling Plank", number: 23)
    }

    /// Kneeling Side Plank with Leg Lift
    static var kneelingSidePlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Kneeling Side Plank with Leg Lift", number: 24)
    }

    /// Weighted Kneeling Side Plank with Leg Lift
    static var weightedKneelingSidePlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Kneeling Side Plank with Leg Lift", number: 25)
    }

    /// Lateral Roll
    static var lateralRoll: PlankExerciseName {
        return PlankExerciseName(name: "Lateral Roll", number: 26)
    }

    /// Weighted Lateral Roll
    static var weightedLateralRoll: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Lateral Roll", number: 27)
    }
    
    /// Lying Reverse Plank
    static var lyingReversePlank: PlankExerciseName {
        return PlankExerciseName(name: "Lying Reverse Plank", number: 28)
    }

    /// Weighted Lying Reverse Plank
    static var weightedLyingReversePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Lying Reverse Plank", number: 29)
    }

    /// Medicine Ball Mountain Climber
    static var medicineBallMountainClimber: PlankExerciseName {
        return PlankExerciseName(name: "Medicine Ball Mountain Climber", number: 30)
    }

    /// Weighted Medicine Ball Mountain Climber
    static var weightedMedicineBallMountainClimber: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Medicine Ball Mountain Climber", number: 31)
    }

    /// Modified Mountain Climber and Extension
    static var modifiedMountainCimberExtension: PlankExerciseName {
        return PlankExerciseName(name: "Modified Mountain Climber and Extension", number: 32)
    }

    /// Weighted Modified Mountain Climber and Extension
    static var weightedModifiedMountainCimberExtension: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Modified Mountain Climber and Extension", number: 33)
    }

    /// Mountain Climber
    static var mountainCimber: PlankExerciseName {
        return PlankExerciseName(name: "Mountain Climber", number: 34)
    }

    /// Weighted Mountain Climber
    static var weightedMountainCimber: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Mountain Climber", number: 35)
    }

    /// Mountain Climber on Sliding Discs
    static var mountainCimberSlidingDiscs: PlankExerciseName {
        return PlankExerciseName(name: "Mountain Climber on Sliding Discs", number: 36)
    }

    /// Weighted Mountain Climber on Sliding Discs
    static var weightedMountainCimberSlidingDiscs: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Mountain Climber on Sliding Discs", number: 37)
    }

    /// Mountain Climber with Feet on Bosu Ball
    static var mountainClimberFeetBosuBall: PlankExerciseName {
        return PlankExerciseName(name: "Mountain Climber with Feet on Bosu Ball", number: 38)
    }

    /// Weighted Mountain Climber with Feet on Bosu Ball
    static var weightedMountainClimberFeetBosuBall: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Mountain Climber with Feet on Bosu Ball", number: 39)
    }
    
    /// Mountain Climber with Hands on Bench
    static var mountainClimberHandsBench: PlankExerciseName {
        return PlankExerciseName(name: "Mountain Climber with Hands on Bench", number: 40)
    }
    
    /// Mountain Climber with Hands on Swiss Ball
    static var mountainClimberHandsSwissBall: PlankExerciseName {
        return PlankExerciseName(name: "Mountain Climber with Swiss Ball", number: 41)
    }

    /// Weighted Mountain Climber with Hands on Swiss Ball
    static var weightedMountainClimberHandsSwissBall: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Mountain Climber with Swiss Ball", number: 42)
    }

    /// Plank
    static var plank: PlankExerciseName {
        return PlankExerciseName(name: "Plank", number: 43)
    }

    /// Plank Jacks with Feet on Sliding Discs
    static var plankJacksFeetSlidingDiscs: PlankExerciseName {
        return PlankExerciseName(name: "Plank Jacks with Feet on Sliding Discs", number: 44)
    }

    /// Weighted Plank Jacks with Feet on Sliding Discs
    static var weightedPlankJacksFeetSlidingDiscs: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank Jacks with Feet on Sliding Discs", number: 45)
    }

    /// Plank Knee Twist
    static var plankKneeTwist: PlankExerciseName {
        return PlankExerciseName(name: "Plank Knee Twist", number: 46)
    }

    /// Weighted Plank Knee Twist
    static var weightedPlankKneeTwist: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank Knee Twist", number: 47)
    }

    /// Plank Pike Jumps
    static var plankPikeJumps: PlankExerciseName {
        return PlankExerciseName(name: "Plank Pike Jumps", number: 48)
    }

    /// Weighted Plank Pike Jumps
    static var weightedPlankPikeJumps: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank Pike Jumps", number: 49)
    }

    /// Plank Pikes
    static var plankPikes: PlankExerciseName {
        return PlankExerciseName(name: "Plank Pikes", number: 50)
    }

    /// Weighted Plank Pikes
    static var weightedPlankPikes: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank Pikes", number: 51)
    }

    /// Plank to Stand Up
    static var plankStandUp: PlankExerciseName {
        return PlankExerciseName(name: "Plank to Stand Up", number: 52)
    }

    /// Weighted Plank to Stand Up
    static var weightedPlankStandUp: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank to Stand Up", number: 53)
    }

    /// Plank with Arm Raise
    static var plankArmRaise: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Arm Raise", number: 54)
    }

    /// Weighted Plank with Arm Raise
    static var weightedPlankArmRaise: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank with Arm Raise", number: 55)
    }
    
    /// Plank with Knee to Elbow
    static var plankKneeElbow: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Knee to Elbow", number: 56)
    }

    /// Weighted Plank with Knee to Elbow
    static var weightedPlankKneeElbow: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank with Knee to Elbow", number: 57)
    }

    /// Plank with Oblique Crunch
    static var plankObliqueCrunch: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Oblique Crunch", number: 58)
    }

    /// Weighted Plank with Oblique Crunch
    static var weightedPlankObliqueCrunch: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank with Oblique Crunch", number: 59)
    }

    /// Ploymetric Side Plank
    static var plyometricSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Ploymetric Side Plank", number: 60)
    }

    /// Weighted Ploymetric Side Plank
    static var weightedPlyometricSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Ploymetric Side Plank", number: 61)
    }

    /// Rolling Side Plank
    static var rollingSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Rolling Side Plank", number: 62)
    }

    /// Weighted Rolling Side Plank
    static var weightedRollingSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Rolling Side Plank", number: 63)
    }

    /// Side Kick Plank
    static var sideKickPlank: PlankExerciseName {
        return PlankExerciseName(name: "Side Kick Plank", number: 64)
    }

    /// Weighted Side Kick Plank
    static var weightedSideKickPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Kick Plank", number: 65)
    }

    /// Side Plank
    static var sidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank", number: 66)
    }

    /// Weighted Side Plank
    static var weightedSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank", number: 67)
    }

    /// Side Plank and Row
    static var sidePlankRow: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank and Row", number: 68)
    }

    /// Weighted Side Plank and Row
    static var weightedSidePlankRow: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank and Row", number: 69)
    }

    /// Side Plank Lift
    static var sidePlankLift: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank Lift", number: 70)
    }

    /// Weighted Side Plank Lift
    static var weightedSidePlankLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank Lift", number: 71)
    }

    /// Side Plank with Elbow on Bosu Ball
    static var sidePlankElbowBosuBall: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank with Elbow on Bosu Ball", number: 72)
    }

    /// Weighted Side Plank with Elbow on Bosu Ball
    static var weightedSidePlankElbowBosuBall: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank with Elbow on Bosu Ball", number: 73)
    }

    /// Side Plank with Feet on Bench
    static var sidePlankFeetBench: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank with Feet on Bench", number: 74)
    }

    /// Weighted Side Plank with Feet on Bench
    static var weightedSidePlankFeetBench: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank with Feet on Bench", number: 75)
    }

    /// Side Plank with Knee Circle
    static var sidePlankKneedCircle: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank with Knee Circle", number: 76)
    }

    /// Weighted Side Plank with Knee Circle
    static var weightedSidePlankKneedCircle: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank with Knee Circle", number: 77)
    }

    /// Side Plank with Knee Tuck
    static var sidePlankKneeTuck: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank with Knee Tuck", number: 78)
    }

    /// Weighted Side Plank with Knee Tuck
    static var weightedSidePlankKneeTuck: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank with Knee Tuck", number: 79)
    }

    /// Side Plank with Leg Lift
    static var sidePlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank with Leg Lift", number: 80)
    }

    /// Weighted Side Plank with Leg Lift
    static var weightedSidePlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank with Leg Lift", number: 81)
    }

    /// Side Plank with Reach Under
    static var sidePlankReachUnder: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank with Reach Under", number: 82)
    }

    /// Weighted Side Plank with Reach Under
    static var weightedSidePlankReachUnder: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Side Plank with Reach Under", number: 83)
    }

    /// Single Leg Elevated Feet Plank
    static var singleLegElevatedFeetPlank: PlankExerciseName {
        return PlankExerciseName(name: "Single Leg Elevated Feet Plank", number: 84)
    }

    /// Weighted Single Leg Elevated Feet Plank
    static var weightedSingleLegElevatedFeetPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Single Leg Elevated Feet Plank", number: 85)
    }

    /// Single Leg Flex and Extend
    static var singleLegFlexExtend: PlankExerciseName {
        return PlankExerciseName(name: "Single Leg Flex and Extend", number: 86)
    }

    /// Weighted Single Leg Flex and Extend
    static var weightedSingleLegFlexExtend: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Single Leg Flex and Extend", number: 87)
    }

    /// Single Leg Side Plank
    static var singleLegSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Single Leg Side Plank", number: 88)
    }

    /// Weighted Single Leg Side Plank
    static var weightedSingleLegSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Single Leg Side Plank", number: 89)
    }

    /// Spiderman Plank
    static var spidermanPlank: PlankExerciseName {
        return PlankExerciseName(name: "Spiderman Plank", number: 90)
    }

    /// Weighted Spiderman Plank
    static var weightedSpidermanPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Spiderman Plank", number: 91)
    }

    /// Straight Arm Plank
    static var straightArmPlank: PlankExerciseName {
        return PlankExerciseName(name: "Straight Arm Plank", number: 92)
    }

    /// Weighted Straight Arm Plank
    static var weightedStraightArmPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Straight Arm Plank", number: 93)
    }
 
    /// Straight Arm Plank with Shoulder Touch
    static var straightArmPlankShoulderTouch: PlankExerciseName {
        return PlankExerciseName(name: "Straight Arm Plank with Shoulder Touch", number: 94)
    }

    /// Weighted Straight Arm Plank with Shoulder Touch
    static var weightedStraightArmPlankShoulderTouch: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Straight Arm Plank with Shoulder Touch", number: 95)
    }

    /// Swiss Ball Plank
    static var swissBallPlank: PlankExerciseName {
        return PlankExerciseName(name: "Swiss Ball Plank", number: 96)
    }

    /// Weighted Swiss Ball Plank
    static var weightedSwissBallPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Swiss Ball Plank", number: 97)
    }
    
    /// Swiss Ball Plank Leg Lift
    static var swissBallPlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Swiss Ball Plank Leg Lift", number: 98)
    }

    /// Weighted Swiss Ball Plank Leg Lift
    static var weightedSwissBallPlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Swiss Ball Plank Leg Lift", number: 99)
    }

    /// Swiss Ball Plank Leg Lift and Hold
    static var swissBallPlankLegLiftHold: PlankExerciseName {
        return PlankExerciseName(name: "Swiss Ball Plank Leg Lift and Hold", number: 100)
    }

    /// Swiss Ball Plank with Feet on Bench
    static var swissBallPlankFeetBench: PlankExerciseName {
        return PlankExerciseName(name: "Swiss Ball Plank with Feet on Bench", number: 101)
    }

    /// Weighted Swiss Ball Plank with Feet on Bench
    static var weightedSwissBallPlankFeetBench: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Swiss Ball Plank with Feet on Bench", number: 102)
    }

    /// Swiss Ball Prone Jackknife
    static var swissBallProneJackknife: PlankExerciseName {
        return PlankExerciseName(name: "Swiss Ball Prone Jackknife", number: 103)
    }

    /// Weighted Swiss Ball Prone Jackknife
    static var weightedSwissBallProneJackknife: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Swiss Ball Prone Jackknife", number: 104)
    }

    /// Swiss Ball Side Plank
    static var swissBallSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Swiss Ball Side Plank", number: 105)
    }

    /// Weighted Swiss Ball Side Plank
    static var weightedSwissBallSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Swiss Ball Side Plank", number: 106)
    }
    
    /// Three Way Plank
    static var threeWayPlank: PlankExerciseName {
        return PlankExerciseName(name: "Three Way Plank", number: 107)
    }

    /// Weighted Three Way Plank
    static var weightedThreeWayPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Three Way Plank", number: 108)
    }

    /// Towel Plank and Knee In
    static var towelPlankKneeIn: PlankExerciseName {
        return PlankExerciseName(name: "Towel Plank and Knee In", number: 109)
    }

    /// Weighted Towel Plank and Knee In
    static var weightedTowelPlankKneeIn: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Towel Plank and Knee In", number: 110)
    }

    /// T Stabilization
    static var tStabilization: PlankExerciseName {
        return PlankExerciseName(name: "T Stabilization", number: 111)
    }

    /// Weighted T Stabilization
    static var weightedTStabilization: PlankExerciseName {
        return PlankExerciseName(name: "Weighted T Stabilization", number: 112)
    }

    /// Turkish Get Up to Side Plank
    static var turkishGetUpSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Turkish Get Up to Side Plank", number: 113)
    }

    /// Weighted Turkish Get Up to Side Plank
    static var weightedTurkishGetUpSidePlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Turkish Get Up to Side Plank", number: 114)
    }

    /// Two Point Plank
    static var twoPointPlank: PlankExerciseName {
        return PlankExerciseName(name: "Two Point Plank", number: 115)
    }

    /// Weighted Two Point Plank
    static var weightedTwoPointPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Two Point Plank", number: 116)
    }

    /// Weighted Plank
    static var weightedPlank: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Plank", number: 117)
    }

    /// Wide Stance Plank with Diagonal Arm Lift
    static var wideStancePlankDiagonalArmLift: PlankExerciseName {
        return PlankExerciseName(name: "Wide Stance Plank with Diagonal Arm Lift", number: 118)
    }

    /// Weighted Wide Stance Plank with Diagonal Arm Lift
    static var weightedWideStancePlankDiagonalArmLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Wide Stance Plank with Diagonal Arm Lift", number: 119)
    }

    /// Wide Stance Plank with Diagonal Leg Lift
    static var wideStancePlankDiagonalLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Wide Stance Plank with Diagonal Leg Lift", number: 120)
    }

    /// Weighted Wide Stance Plank with Diagonal Leg Lift
    static var weightedWideStancePlankDiagonalLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Wide Stance Plank with Diagonal Leg Lift", number: 121)
    }

    /// Wide Stance Plank with Leg Lift
    static var wideStancePlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Wide Stance Plank with Leg Lift", number: 122)
    }

    /// Weighted Wide Stance Plank with Leg Lift
    static var weightedWideStancePlankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Wide Stance Plank with Leg Lift", number: 123)
    }

    /// Wide Stance Plank with Opposite Arm and Leg Lift
    static var wideStancePlankOppositeArmLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Wide Stance Plank with Opposite Arm and Leg Lift", number: 124)
    }

    /// Weighted Mountain Climber with Hands on Bench
    static var weightedMountainClimberHandsBench: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Mountain Climber with Hands on Bench", number: 125)
    }

    /// Weighted Swiss Ball Plank Leg Lift and Hold
    static var weightedSwissBallPlankLegLiftHold: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Swiss Ball Plank Leg Lift and Hold", number: 126)
    }

    /// Weighted Wide Stance Plank with Opposite Arm and Leg Lift
    static var weightedWideStancePlankOppositeArmLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Weighted Wide Stance Plank with Opposite Arm and Leg Lift", number: 127)
    }

    /// Plank with Feet on Swiss Ball
    static var plankFeetSwissBall: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Feet on Swiss Ball", number: 128)
    }

    /// Side Plank to Plank with Reach Under
    static var sidePlankPlankReachUnder: PlankExerciseName {
        return PlankExerciseName(name: "Side Plank to Plank with Reach Under", number: 129)
    }

    /// Bridge with Glute Lower Lift
    static var bridgeGluteLowerLift: PlankExerciseName {
        return PlankExerciseName(name: "Bridge with Glute Lower Lift", number: 130)
    }

    /// Bridge One Leg Bridge
    static var bridgeOneLegBridge: PlankExerciseName {
        return PlankExerciseName(name: "Bridge One Leg Bridge", number: 131)
    }

    /// Plank with Arm Variations
    static var plankArmVariations: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Arm Variations", number: 132)
    }

    /// Plank with Leg Lift
    static var plankLegLift: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Arm Variations", number: 133)
    }

    /// Reverse Plank with Leg Pull
    static var reversePlankLegPull: PlankExerciseName {
        return PlankExerciseName(name: "Plank with Arm Variations", number: 134)
    }

}
