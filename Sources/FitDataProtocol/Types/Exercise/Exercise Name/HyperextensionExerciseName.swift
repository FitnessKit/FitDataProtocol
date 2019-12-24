//
//  HyperextensionExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/18/18.
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

/// Hyperextension Exercise Name
public struct HyperextensionExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = HyperextensionExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .hyperExtension }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension HyperextensionExerciseName: Hashable {}

public extension HyperextensionExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [HyperextensionExerciseName] {

        return [.backExtensionOppositeArmLegReach,
                .weightedBackExtensionOppositeArmLegReach,
                .baseRotations,
                .weightedBaseRotations,
                .bentKneeReverseHyperextension,
                .weightedBentKneeReverseHyperextension,
                .hollowHoldRoll,
                .weightedHollowHoldRoll,
                .kicks,
                .weightedKicks,
                .kneeRaises,
                .weightedKneeRaises,
                .kneelingSuperman,
                .weightedKneelingSuperman,
                .latPullDownRow,
                .medicineBallDeadliftToReach,
                .oneArmOneLegRow,
                .oneArmOneLegRowBand,
                .overheadLungeMedicineBall,
                .plankKneeTucks,
                .weightedPlankKneeTucks,
                .sideStep,
                .weightedSideStep,
                .singleLegBackExtension,
                .weightedSingleLegBackExtension,
                .spineExtension,
                .weightedSpineExtension,
                .staticBackExtension,
                .weightedStaticBackExtension,
                .supermanFromFloor,
                .weightedSupermanFromFloor,
                .swissBallBackExtension,
                .weightedSwissBallBackExtension,
                .swissBallHyperextension,
                .weightedSwissBallHyperextension,
                .swissBallOppositeArmLegLift,
                .weightedSwissBallOppositeArmLegLift
        ]
    }
}

public extension HyperextensionExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> HyperextensionExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension HyperextensionExerciseName {

    /// Back Extension with Opposite Arm and Leg Reach
    static var backExtensionOppositeArmLegReach: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Back Extension with Opposite Arm and Leg Reach", number: 0)
    }

    /// Weighted Back Extension with Opposite Arm and Leg Reach
    static var weightedBackExtensionOppositeArmLegReach: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Back Extension with Opposite Arm and Leg Reach", number: 1)
    }

    /// Base Rotations
    static var baseRotations: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Base Rotations", number: 2)
    }

    /// Weighted Base Rotations
    static var weightedBaseRotations: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Base Rotations", number: 3)
    }

    /// Bent Knee Reverse Hyperextension
    static var bentKneeReverseHyperextension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Bent Knee Reverse Hyperextension", number: 4)
    }

    /// Weighted Bent Knee Reverse Hyperextension
    static var weightedBentKneeReverseHyperextension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Bent Knee Reverse Hyperextension", number: 5)
    }

    /// Hollow Hold and Roll
    static var hollowHoldRoll: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Hollow Hold and Roll", number: 6)
    }

    /// Weighted Hollow Hold and Roll
    static var weightedHollowHoldRoll: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Hollow Hold and Roll", number: 7)
    }

    /// Kicks
    static var kicks: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Kicks", number: 8)
    }

    /// Weighted Kicks
    static var weightedKicks: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Kicks", number: 9)
    }

    /// Knee Raises
    static var kneeRaises: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Knee Raises", number: 10)
    }

    /// Weighted Knee Raises
    static var weightedKneeRaises: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Knee Raises", number: 11)
    }

    /// Kneeling Superman
    static var kneelingSuperman: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Kneeling Superman", number: 12)
    }

    /// Weighted Kneeling Superman
    static var weightedKneelingSuperman: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Kneeling Superman", number: 13)
    }

    /// Lat Pull Down with Row
    static var latPullDownRow: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Lat Pull Down with Row", number: 14)
    }

    /// Medicine Ball Deadlift to Reach
    static var medicineBallDeadliftToReach: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Medicine Ball Deadlift to Reach", number: 15)
    }

    /// One Arm One Leg Row
    static var oneArmOneLegRow: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "One Arm One Leg Row", number: 16)
    }

    /// One Arm One Leg Row with Band
    static var oneArmOneLegRowBand: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "One Arm One Leg Row with Band", number: 17)
    }

    /// Overhead Lunge with Medicine Ball
    static var overheadLungeMedicineBall: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Overhead Lunge with Medicine Ball", number: 18)
    }

    /// Plank Knee Tucks
    static var plankKneeTucks: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Plank Knee Tucks", number: 19)
    }

    /// Weighted Plank Knee Tucks
    static var weightedPlankKneeTucks: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Plank Knee Tucks", number: 20)
    }

    /// Side Step
    static var sideStep: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Side Step", number: 21)
    }

    /// Weighted Side Step
    static var weightedSideStep: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Side Step", number: 22)
    }

    /// Single Leg Back Extension
    static var singleLegBackExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Single Leg Back Extension", number: 23)
    }

    /// Weighted Single Leg Back Extension
    static var weightedSingleLegBackExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Single Leg Back Extension", number: 24)
    }

    /// Spine Extension
    static var spineExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Spine Extension", number: 25)
    }

    /// Weighted Spine Extension
    static var weightedSpineExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Spine Extension", number: 26)
    }

    /// Static Back Extension
    static var staticBackExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Static Back Extension", number: 27)
    }

    /// Weighted Static Back Extension
    static var weightedStaticBackExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Static Back Extension", number: 28)
    }

    /// Superman from Floor
    static var supermanFromFloor: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Superman from Floor", number: 29)
    }

    /// Weighted Superman from Floor
    static var weightedSupermanFromFloor: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Superman from Floor", number: 30)
    }

    /// Swiss Ball Back Extension
    static var swissBallBackExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Swiss Ball Back Extension", number: 31)
    }

    /// Weighted Swiss Ball Back Extension
    static var weightedSwissBallBackExtension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Swiss Ball Back Extension", number: 32)
    }

    /// Swiss Ball Hyperextension
    static var swissBallHyperextension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Swiss Ball Hyperextension", number: 33)
    }

    /// Weighted Swiss Ball Hyperextension
    static var weightedSwissBallHyperextension: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Swiss Ball Hyperextension", number: 34)
    }

    /// Swiss Ball Opposite Arm and Leg Lift
    static var swissBallOppositeArmLegLift: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Swiss Ball Opposite Arm and Leg Lift", number: 35)
    }

    /// Weighted Swiss Ball Opposite Arm and Leg Lift
    static var weightedSwissBallOppositeArmLegLift: HyperextensionExerciseName {
        return HyperextensionExerciseName(name: "Weighted Swiss Ball Opposite Arm and Leg Lift", number: 36)
    }
}
