//
//  CrunchExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/17/18.
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

/// Crunch Exercise Name
public struct CrunchExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = CrunchExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .crunch }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension CrunchExerciseName: Hashable {}

public extension CrunchExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [CrunchExerciseName] {

        return [.bicycleCrunch,
                .cableCrunch,
                .circularArmCrunch,
                .crossedArmsCrunch,
                .weightedCrossedArmsCrunch,
                .crossLegReverseCrunch,
                .weightedCrossLegReverseCrunch,
                .crunchChop,
                .weightedCrunchChop,
                .doubleCrunch,
                .weightedDoubleCrunch,
                .elbowToKneeCrunch,
                .weightedElbowToKneeCrunch,
                .flutterKicks,
                .weightedFlutterKicks,
                .foamRollerReverseCrunchOnBench,
                .weightedFoamRollerReverseCrunchOnBench,
                .foamRollerReverseCrunchDumbbell,
                .foamRollerReverseCrunchMedicineBall,
                .frogPress,
                .hangingKneeRaiseObliqueCrunch,
                .weightedHangingKneeRaiseObliqueCrunch,
                .hipCrossover,
                .wightedHipCrossover,
                .hollowRock,
                .weightedHollowRock,
                .inclineReverseCrunch,
                .weightedInclineReverseCrunch,
                .kneelingCableCrunch,
                .kneelingCrossCrunch,
                .weightedKneelingCrossCrunch,
                .kneelingObliqueCableCrunch,
                .kneesToElbow,
                .legExtensions,
                .weightedLegExtensions,
                .legLevers,
                .mcgillCurlUp,
                .weightedMcgillCurlUp,
                .modifiedPilatesRollUpBall,
                .weightedModifiedPilatesRollUpBall,
                .pilatesCrunch,
                .weightedPilatesCrunch,
                .pilatesRollUpBall,
                .weightePilatesRollUpBall,
                .raisedLegsCrunch,
                .weightedRaisedLegsCrunch,
                .reverseCrunch,
                .weightedReverseCrunch,
                .reverseCrunchOnBench,
                .weightedReverseCrunchOnBench,
                .reverseCurlLift,
                .weightedReverseCurlLift,
                .rotationalLift,
                .weightedRotationalLift,
                .seatedAlternatingReverseCrunch,
                .weightedSeatedAlternatingReverseCrunch,
                .seatedLegU,
                .weightedSeatedLegU,
                .sideToSideCrunchWeave,
                .weightedSideToSideCrunchWeave,
                .singleLegReverseCrunch,
                .weightedSingleLegReverseCrunch,
                .skaterCrunchCross,
                .weightedSkaterCrunchCross,
                .standingCableCrunch,
                .standingSideCrunch,
                .stepClimb,
                .weightedStepClimb,
                .swissBallCrunch,
                .swissBallReverseCrunch,
                .weightedSwissBallReverseCrunch,
                .swissBallRussianTwist,
                .weightedSwissBallRussianTwist,
                .swissBallSideCrunch,
                .weightedSwissBallSideCrunch,
                .thoracicCrunchesOnFoamRoller,
                .weightedThoracicCrunchesOnFoamRoller,
                .tricepsCrunch,
                .weightedBicycleCrunch,
                .weightedCrunch,
                .weightedSwissBallCrunch,
                .toesToBar,
                .weightedToesToBar,
                .crunch
        ]
    }
}

public extension CrunchExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> CrunchExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension CrunchExerciseName {

    /// Bicycle Crunch
    static var bicycleCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Bicycle Crunch", number: 0)
    }

    /// Cable Crunch
    static var cableCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Cable Crunch", number: 1)
    }

    /// Circular Arm Crunch
    static var circularArmCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Circular Arm Crunch", number: 2)
    }

    /// Crossed Arms Crunch
    static var crossedArmsCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Crossed Arms Crunch", number: 3)
    }

    /// Weighted Crossed Arms Crunch
    static var weightedCrossedArmsCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Crossed Arms Crunch", number: 4)
    }

    /// Cross Leg Reverse Crunch
    static var crossLegReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Cross Leg Reverse Crunch", number: 5)
    }

    /// Weighted Cross Leg Reverse Crunch
    static var weightedCrossLegReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Cross Leg Reverse Crunch", number: 6)
    }

    /// Crunch Chop
    static var crunchChop: CrunchExerciseName {
        return CrunchExerciseName(name: "Crunch Chop", number: 7)
    }

    /// Weighted Crunch Chop
    static var weightedCrunchChop: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Crunch Chop", number: 8)
    }

    /// Double Crunch
    static var doubleCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Double Crunch", number: 9)
    }

    /// Weighted Double Crunch
    static var weightedDoubleCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Double Crunch", number: 10)
    }

    /// Elbow to Knee Crunch
    static var elbowToKneeCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Elbow to Knee Crunch", number: 11)
    }

    /// Weighted Elbow to Knee Crunch
    static var weightedElbowToKneeCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Elbow to Knee Crunch", number: 12)
    }

    /// Flutter Kicks
    static var flutterKicks: CrunchExerciseName {
        return CrunchExerciseName(name: "Flutter Kicks", number: 13)
    }

    /// Weighted Flutter Kicks
    static var weightedFlutterKicks: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Flutter Kicks", number: 14)
    }

    /// Foam Roller Reverse Crunch on Bench
    static var foamRollerReverseCrunchOnBench: CrunchExerciseName {
        return CrunchExerciseName(name: "Foam Roller Reverse Crunch on Bench", number: 15)
    }

    /// Weighted Foam Roller Reverse Crunch on Bench
    static var weightedFoamRollerReverseCrunchOnBench: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Foam Roller Reverse Crunch on Bench", number: 16)
    }

    /// Foam Roller Reverse Crunch with Dumbbell
    static var foamRollerReverseCrunchDumbbell: CrunchExerciseName {
        return CrunchExerciseName(name: "Foam Roller Reverse Crunch with Dumbbell", number: 17)
    }

    /// Foam Roller Reverse Crunch with Medicine Ball
    static var foamRollerReverseCrunchMedicineBall: CrunchExerciseName {
        return CrunchExerciseName(name: "Foam Roller Reverse Crunch with Medicine Ball", number: 18)
    }

    /// Frog Press
    static var frogPress: CrunchExerciseName {
        return CrunchExerciseName(name: "Frog Press", number: 19)
    }

    /// Hanging Knee Raise Oblique Crunch
    static var hangingKneeRaiseObliqueCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Hanging Knee Raise Oblique Crunch", number: 20)
    }

    /// Weighted Hanging Knee Raise Oblique Crunch
    static var weightedHangingKneeRaiseObliqueCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Hanging Knee Raise Oblique Crunch", number: 21)
    }

    /// Hip Crossover
    static var hipCrossover: CrunchExerciseName {
        return CrunchExerciseName(name: "Hip Crossover", number: 22)
    }

    /// Weighted Hip Crossover
    static var wightedHipCrossover: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Hip Crossover", number: 23)
    }

    /// Hollow Rock
    static var hollowRock: CrunchExerciseName {
        return CrunchExerciseName(name: "Hollow Rock", number: 24)
    }

    /// Weighted Hollow Rock
    static var weightedHollowRock: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Hollow Rock", number: 25)
    }

    /// Incline Reverse Crunch
    static var inclineReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Incline Reverse Crunch", number: 26)
    }

    /// Weighted Incline Reverse Crunch
    static var weightedInclineReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Incline Reverse Crunch", number: 27)
    }

    /// Kneeling Cable Crunch
    static var kneelingCableCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Kneeling Cable Crunch", number: 28)
    }

    /// Kneeling Cross Crunch
    static var kneelingCrossCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Kneeling Cross Crunch", number: 29)
    }

    /// Weighted Kneeling Cross Crunch
    static var weightedKneelingCrossCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Kneeling Cross Crunch", number: 30)
    }

    /// Kneeling Oblique Cable Crunch
    static var kneelingObliqueCableCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Kneeling Oblique Cable Crunch", number: 31)
    }

    /// Knees to Elbow
    static var kneesToElbow: CrunchExerciseName {
        return CrunchExerciseName(name: "Knees to Elbow", number: 32)
    }

    /// Leg Extensions
    static var legExtensions: CrunchExerciseName {
        return CrunchExerciseName(name: "Leg Extensions", number: 33)
    }

    /// Weighted Leg Extensions
    static var weightedLegExtensions: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Leg Extensions", number: 34)
    }

    /// Leg Levers
    static var legLevers: CrunchExerciseName {
        return CrunchExerciseName(name: "Leg Levers", number: 35)
    }

    /// McGill Curl Up
    static var mcgillCurlUp: CrunchExerciseName {
        return CrunchExerciseName(name: "McGill Curl Up", number: 36)
    }

    /// Weighted McGill Curl Up
    static var weightedMcgillCurlUp: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted McGill Curl Up", number: 37)
    }

    /// Modified Pilates Roll up with Ball
    static var modifiedPilatesRollUpBall: CrunchExerciseName {
        return CrunchExerciseName(name: "Modified Pilates Roll up with Ball", number: 38)
    }

    /// Weighted Modified Pilates Roll up with Ball
    static var weightedModifiedPilatesRollUpBall: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Modified Pilates Roll up with Ball", number: 39)
    }

    /// Pilates Crunch
    static var pilatesCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Pilates Crunch", number: 40)
    }

    /// Weighted Pilates Crunch
    static var weightedPilatesCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Pilates Crunch", number: 41)
    }

    /// Pilates Roll up with Ball
    static var pilatesRollUpBall: CrunchExerciseName {
        return CrunchExerciseName(name: "Pilates Roll up with Ball", number: 42)
    }

    /// Weighted Pilates Roll up with Ball
    static var weightePilatesRollUpBall: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Pilates Roll up with Ball", number: 43)
    }

    /// Raised Legs Crunch
    static var raisedLegsCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Raised Legs Crunch", number: 44)
    }

    /// Weighted Raised Legs Crunch
    static var weightedRaisedLegsCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Raised Legs Crunch", number: 45)
    }

    /// Reverse Crunch
    static var reverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Reverse Crunch", number: 46)
    }

    /// Weighted Reverse Crunch
    static var weightedReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Reverse Crunch", number: 47)
    }

    /// Reverse Crunch on a Bench
    static var reverseCrunchOnBench: CrunchExerciseName {
        return CrunchExerciseName(name: "Reverse Crunch on a Bench", number: 48)
    }

    /// Weighted Reverse Crunch on a Bench
    static var weightedReverseCrunchOnBench: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Reverse Crunch on a Bench", number: 49)
    }

    /// Reverse Curl and Lift
    static var reverseCurlLift: CrunchExerciseName {
        return CrunchExerciseName(name: "Reverse Curl and Lift", number: 50)
    }

    /// Weighted Reverse Curl and Lift
    static var weightedReverseCurlLift: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Reverse Curl and Lift", number: 51)
    }

    /// Rotational Lift
    static var rotationalLift: CrunchExerciseName {
        return CrunchExerciseName(name: "Rotational Lift", number: 52)
    }

    /// Weighted Rotational Lift
    static var weightedRotationalLift: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Rotational Lift", number: 53)
    }

    /// Seated Alternating Reverse Crunch
    static var seatedAlternatingReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Seated Alternating Reverse Crunch", number: 54)
    }

    /// Weighted Seated Alternating Reverse Crunch
    static var weightedSeatedAlternatingReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Seated Alternating Reverse Crunch", number: 55)
    }

    /// Seated Leg U
    static var seatedLegU: CrunchExerciseName {
        return CrunchExerciseName(name: "Seated Leg U", number: 56)
    }

    /// Weighted Seated Leg U
    static var weightedSeatedLegU: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Seated Leg U", number: 57)
    }

    /// Side to Side Crunch and Weave
    static var sideToSideCrunchWeave: CrunchExerciseName {
        return CrunchExerciseName(name: "Side to Side Crunch and Weave", number: 58)
    }

    /// Weighted Side to Side Crunch and Weave
    static var weightedSideToSideCrunchWeave: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Side to Side Crunch and Weave", number: 59)
    }

    /// Single Leg Reverse Crunch
    static var singleLegReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Single Leg Reverse Crunch", number: 60)
    }

    /// Weighted Single Leg Reverse Crunch
    static var weightedSingleLegReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Single Leg Reverse Crunch", number: 61)
    }

    /// Skater Crunch Cross
    static var skaterCrunchCross: CrunchExerciseName {
        return CrunchExerciseName(name: "Skater Crunch Cross", number: 62)
    }

    /// Weighted Skater Crunch Cross
    static var weightedSkaterCrunchCross: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Skater Crunch Cross", number: 63)
    }

    /// Standing Cable Crunch
    static var standingCableCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Standing Cable Crunch", number: 64)
    }

    /// Standing Side Crunch
    static var standingSideCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Standing Side Crunch", number: 65)
    }

    /// Step Climb
    static var stepClimb: CrunchExerciseName {
        return CrunchExerciseName(name: "Step Climb", number: 66)
    }

    /// Weighted Step Climb
    static var weightedStepClimb: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Step Climb", number: 67)
    }

    /// Swiss Ball Crunch
    static var swissBallCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Swiss Ball Crunch", number: 68)
    }

    /// Swiss Ball Reverse Crunch
    static var swissBallReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Swiss Ball Reverse Crunch", number: 69)
    }

    /// Weighted Swiss Ball Reverse Crunch
    static var weightedSwissBallReverseCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Swiss Ball Reverse Crunch", number: 70)
    }

    /// Swiss Ball Russian Twist
    static var swissBallRussianTwist: CrunchExerciseName {
        return CrunchExerciseName(name: "Swiss Ball Russian Twist", number: 71)
    }

    /// Weighted Swiss Ball Russian Twist
    static var weightedSwissBallRussianTwist: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Swiss Ball Russian Twist", number: 72)
    }

    /// Swiss Ball Side Crunch
    static var swissBallSideCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Swiss Ball Side Crunch", number: 73)
    }

    /// Weighted Swiss Ball Side Crunch
    static var weightedSwissBallSideCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Swiss Ball Side Crunch", number: 74)
    }

    /// Thoracic Crunches on Foam Roller
    static var thoracicCrunchesOnFoamRoller: CrunchExerciseName {
        return CrunchExerciseName(name: "Thoracic Crunches on Foam Roller", number: 75)
    }

    /// Weighted Thoracic Crunches on Foam Roller
    static var weightedThoracicCrunchesOnFoamRoller: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Thoracic Crunches on Foam Roller", number: 76)
    }

    /// Triceps Crunch
    static var tricepsCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Triceps Crunch", number: 77)
    }

    /// Weighted Bicycle Crunch
    static var weightedBicycleCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Bicycle Crunch", number: 78)
    }

    /// Weighted Crunch
    static var weightedCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Crunch", number: 79)
    }

    /// Weighted Swiss Ball Crunch
    static var weightedSwissBallCrunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Swiss Ball Crunch", number: 80)
    }

    /// Toes to Bar
    static var toesToBar: CrunchExerciseName {
        return CrunchExerciseName(name: "Toes to Bar", number: 81)
    }

    /// Weighted Toes to Bar
    static var weightedToesToBar: CrunchExerciseName {
        return CrunchExerciseName(name: "Weighted Toes to Bar", number: 82)
    }

    /// Crunch
    static var crunch: CrunchExerciseName {
        return CrunchExerciseName(name: "Crunch", number: 83)
    }

}
