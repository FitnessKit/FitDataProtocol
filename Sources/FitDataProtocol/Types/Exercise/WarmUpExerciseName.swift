//
//  WarmUpExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/2/19.
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

/// Warm Up Exercise Name
public struct WarmUpExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = WarmUpExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .warmUp }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension WarmUpExerciseName: Hashable {}

public extension WarmUpExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [WarmUpExerciseName] {

        return [.quadrupedRocking,
                .neckTilts,
                .ankleCircles,
                .ankleDorsiflexionBand,
                .ankleInternalRotation,
                .armCircles,
                .bentOverReachToSky,
                .catCamel,
                .elbowToFootLunge,
                .forwardBackwardLegSwings,
                .groiners,
                .invertedHamstringStretch,
                .lateralDuckUnder,
                .neckRotations,
                .oppositeArmLegBalance,
                .reachRollLift,
                .scorpion,
                .shoulderCircles,
                .sideToSideLegSwings,
                .sleeperStretch,
                .slideOut,
                .swissBallHipCrossOver,
                .swissBallReachRollLift,
                .swissBallWindshieldWipers,
                .thoracicRotation,
                .walkingHighKicks,
                .walkingHighKnees,
                .walkingKneeHugs,
                .walkingLegCradles,
                .walkout,
                .walkoutFromPushUpPosition,
        ]
    }
}

public extension WarmUpExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> WarmUpExerciseName? {
        return Self.supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension WarmUpExerciseName {

    /// Quadruped Rocking
    static var quadrupedRocking: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Quadruped Rocking", number: 0)
    }

    /// Neck Tilts
    static var neckTilts: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Neck Tilts", number: 1)
    }

    /// Ankle Circles
    static var ankleCircles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Ankle Circles", number: 2)
    }

    /// Ankle Dorsiflexion with Band
    static var ankleDorsiflexionBand: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Ankle Dorsiflexion with Band", number: 3)
    }

    /// Ankle Internal Rotation
    static var ankleInternalRotation: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Ankle Internal Rotation", number: 4)
    }

    /// Arm Circles
    static var armCircles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Arm Circles", number: 5)
    }

    /// Bent Over Reach to Sky
    static var bentOverReachToSky: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Bent Over Reach to Sky", number: 6)
    }

    /// Cat Camel
    static var catCamel: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Cat Camel", number: 7)
    }

    /// Elbow to Foot Lunge
    static var elbowToFootLunge: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Elbow to Foot Lunge", number: 8)
    }

    /// Forward and Backward Leg Swings
    static var forwardBackwardLegSwings: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Forward and Backward Leg Swings", number: 9)
    }

    /// Groiners
    static var groiners: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Groiners", number: 10)
    }

    /// Inverted Hamstring Stretch
    static var invertedHamstringStretch: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Inverted Hamstring Stretch", number: 11)
    }

    /// Lateral Duck Under
    static var lateralDuckUnder: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Lateral Duck Under", number: 12)
    }

    /// Neck Rotations
    static var neckRotations: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Neck Rotations", number: 13)
    }

    /// Oppoaite Arm and Lege Balance
    static var oppositeArmLegBalance: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Oppoaite Arm and Lege Balance", number: 14)
    }

    /// Reach Roll and Lift
    static var reachRollLift: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Reach Roll and Lift", number: 15)
    }

    /// Scorpion
    static var scorpion: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Scorpion", number: 16)
    }

    /// Shoulder Circles
    static var shoulderCircles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Shoulder Circles", number: 17)
    }

    /// Side to Side Leg Swings
    static var sideToSideLegSwings: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Side to Side Leg Swings", number: 18)
    }

    /// Sleeper Stretch
    static var sleeperStretch: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Sleeper Stretch", number: 19)
    }

    /// Slide Out
    static var slideOut: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Slide Out", number: 20)
    }

    /// Swiss Ball Hip Crossover
    static var swissBallHipCrossOver: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Swiss Ball Hip Crossover", number: 21)
    }

    /// Swiss Ball Reach Roll and Lift
    static var swissBallReachRollLift: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Swiss Ball Reach Roll and Lift", number: 22)
    }

    /// Swiss Ball Windshield Wipers
    static var swissBallWindshieldWipers: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Swiss Ball Windshield Wipers", number: 23)
    }

    /// Thoracic Rotation
    static var thoracicRotation: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Thoracic Rotation", number: 24)
    }

    /// Walking High Kicks
    static var walkingHighKicks: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking High Kicks", number: 25)
    }

    /// Walking High Knees
    static var walkingHighKnees: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking High Knees", number: 26)
    }

    /// Walking Knee Hugs
    static var walkingKneeHugs: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking Knee Hugs", number: 27)
    }

    /// Walking Leg Cradles
    static var walkingLegCradles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking Leg Cradles", number: 28)
    }

    /// Walkout
    static var walkout: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walkout", number: 29)
    }

    /// Walkout from Push Up Position
    static var walkoutFromPushUpPosition: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walkout from Push Up Position", number: 30)
    }
}
