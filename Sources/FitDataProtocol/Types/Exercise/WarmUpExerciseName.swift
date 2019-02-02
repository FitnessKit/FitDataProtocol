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

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension WarmUpExerciseName: Hashable {

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: WarmUpExerciseName, rhs: WarmUpExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension WarmUpExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [WarmUpExerciseName] {

        return [.quadrupedRocking,
                .neckTilts,
                .ankleCircles,
                .ankleDorsiflexionWithBand,
                .ankleInternalRotation,
                .armCircles,
                .bentOverReachToSky,
                .catCamel,
                .elbowToFootLunge,
                .forwardAndBackwardLegSwings,
                .groiners,
                .invertedHamstringStretch,
                .lateralDuckUnder,
                .neckRotations,
                .oppositeArmAndLegBalance,
                .reachRollAndLift,
                .scorpion,
                .shoulderCircles,
                .sideToSideLegSwings,
                .sleeperStretch,
                .slideOut,
                .swissBallHipCrossOver,
                .swissBallReachRollAndLift,
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
    public static func create(rawValue: UInt16) -> WarmUpExerciseName? {

        for name in WarmUpExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension WarmUpExerciseName {

    /// Quadruped Rocking
    public static var quadrupedRocking: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Quadruped Rocking", number: 0)
    }

    /// Neck Tilts
    public static var neckTilts: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Neck Tilts", number: 1)
    }

    /// Ankle Circles
    public static var ankleCircles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Ankle Circles", number: 2)
    }

    /// Ankle Dorsiflexion with Band
    public static var ankleDorsiflexionWithBand: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Ankle Dorsiflexion with Band", number: 3)
    }

    /// Ankle Internal Rotation
    public static var ankleInternalRotation: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Ankle Internal Rotation", number: 4)
    }

    /// Arm Circles
    public static var armCircles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Arm Circles", number: 5)
    }

    /// Bent Over Reach to Sky
    public static var bentOverReachToSky: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Bent Over Reach to Sky", number: 6)
    }

    /// Cat Camel
    public static var catCamel: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Cat Camel", number: 7)
    }

    /// Elbow to Foot Lunge
    public static var elbowToFootLunge: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Elbow to Foot Lunge", number: 8)
    }

    /// Forward and Backward Leg Swings
    public static var forwardAndBackwardLegSwings: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Forward and Backward Leg Swings", number: 9)
    }

    /// Groiners
    public static var groiners: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Groiners", number: 10)
    }

    /// Inverted Hamstring Stretch
    public static var invertedHamstringStretch: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Inverted Hamstring Stretch", number: 11)
    }

    /// Lateral Duck Under
    public static var lateralDuckUnder: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Lateral Duck Under", number: 12)
    }

    /// Neck Rotations
    public static var neckRotations: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Neck Rotations", number: 13)
    }

    /// Oppoaite Arm and Lege Balance
    public static var oppositeArmAndLegBalance: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Oppoaite Arm and Lege Balance", number: 14)
    }

    /// Reach Roll and Lift
    public static var reachRollAndLift: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Reach Roll and Lift", number: 15)
    }

    /// Scorpion
    public static var scorpion: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Scorpion", number: 16)
    }

    /// Shoulder Circles
    public static var shoulderCircles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Shoulder Circles", number: 17)
    }

    /// Side to Side Leg Swings
    public static var sideToSideLegSwings: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Side to Side Leg Swings", number: 18)
    }

    /// Sleeper Stretch
    public static var sleeperStretch: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Sleeper Stretch", number: 19)
    }

    /// Slide Out
    public static var slideOut: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Slide Out", number: 20)
    }

    /// Swiss Ball Hip Crossover
    public static var swissBallHipCrossOver: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Swiss Ball Hip Crossover", number: 21)
    }

    /// Swiss Ball Reach Roll and Lift
    public static var swissBallReachRollAndLift: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Swiss Ball Reach Roll and Lift", number: 22)
    }

    /// Swiss Ball Windshield Wipers
    public static var swissBallWindshieldWipers: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Swiss Ball Windshield Wipers", number: 23)
    }

    /// Thoracic Rotation
    public static var thoracicRotation: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Thoracic Rotation", number: 24)
    }

    /// Walking High Kicks
    public static var walkingHighKicks: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking High Kicks", number: 25)
    }

    /// Walking High Knees
    public static var walkingHighKnees: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking High Knees", number: 26)
    }

    /// Walking Knee Hugs
    public static var walkingKneeHugs: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking Knee Hugs", number: 27)
    }

    /// Walking Leg Cradles
    public static var walkingLegCradles: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walking Leg Cradles", number: 28)
    }

    /// Walkout
    public static var walkout: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walkout", number: 29)
    }

    /// Walkout from Push Up Position
    public static var walkoutFromPushUpPosition: WarmUpExerciseName {
        return WarmUpExerciseName(name: "Walkout from Push Up Position", number: 30)
    }
}
