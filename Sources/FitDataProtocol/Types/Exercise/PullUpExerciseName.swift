//
//  PullUpExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/16/19.
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

/// Pull Up Exercise Name
public struct PullUpExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = PullUpExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .pullUp }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension PullUpExerciseName: Hashable {}

public extension PullUpExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [PullUpExerciseName] {

        return [.bandedPullUp,
                .thirtyDegreeLatPulldown,
                .bandAssistedChinUp,
                .closeGripChinUp,
                .weightedCloseGripChinUp,
                .closeGripLatPulldown,
                .crossoverChinUp,
                .weightedCrossoverChinUp,
                .ezBarPullover,
                .hangingHurdle,
                .weightedHangingHurdle,
                .kneelingLatPulldown,
                .kneelingUnderhandGripLatPulldown,
                .latPulldown,
                .mixedGripChinUp,
                .weightedMixedGripChinUp,
                .mixedGripPullUp,
                .weightedMixedGripPullUp,
                .reverseGripPulldown,
                .standingCablePullover,
                .straightArmPulldown,
                .swissBallEzBarPullover,
                .towelPullUp,
                .weightedTowelPullUp,
                .weightedPullUp,
                .wideGripLatPulldown,
                .wideGripPullUp,
                .weightedWideGripPullUp,
                .burpeePullUp,
                .weightedBurpeePullUp,
                .jumpingPullUps,
                .kippingPullUp,
                .weightedKippingPullUp,
                .lPullUp,
                .weightedLPullUp,
                .suspendedChinUp,
                .weightedSuspendedChinUp,
                .pullUp,
        ]
    }
}

public extension PullUpExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> PullUpExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension PullUpExerciseName {

    /// Banded Pull Up
    static var bandedPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Banded Pull Up", number: 0)
    }

    /// 30 Degree Lat Pulldown
    static var thirtyDegreeLatPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "30 Degree Lat Pulldown", number: 1)
    }

    /// Band Assisted Chin Up
    static var bandAssistedChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Band Assisted Chin Up", number: 2)
    }

    /// Close Grip Chin Up
    static var closeGripChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Close Grip Chin Up", number: 3)
    }

    /// Weighted Close Grip Chin Up
    static var weightedCloseGripChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Close Grip Chin Up", number: 4)
    }

    /// Close Grip Lat Pulldown
    static var closeGripLatPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Close Grip Lat Pulldown", number: 5)
    }

    /// Crossover Chin Up
    static var crossoverChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Crossover Chin Up", number: 6)
    }

    /// Weighted Crossover Chin Up
    static var weightedCrossoverChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Crossover Chin Up", number: 7)
    }

    /// EZ Bar Pullover
    static var ezBarPullover: PullUpExerciseName {
        return PullUpExerciseName(name: "EZ Bar Pullover", number: 8)
    }

    /// Hanging Hurdle
    static var hangingHurdle: PullUpExerciseName {
        return PullUpExerciseName(name: "Hanging Hurdle", number: 9)
    }

    /// Weighted Hanging Hurdle
    static var weightedHangingHurdle: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Hanging Hurdle", number: 10)
    }

    /// Kneeling Lat Pulldown
    static var kneelingLatPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Kneeling Lat Pulldown", number: 11)
    }

    /// Kneeling Underhand Grip Lat Pulldown
    static var kneelingUnderhandGripLatPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Kneeling Underhand Grip Lat Pulldown", number: 12)
    }

    /// Lat Pulldown
    static var latPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Lat Pulldown", number: 13)
    }

    /// Mixed Grip Chin Up
    static var mixedGripChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Mixed Grip Chin Up", number: 14)
    }

    /// Weighted Mixed Grip Chin Up
    static var weightedMixedGripChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Mixed Grip Chin Up", number: 15)
    }

    /// Mixed Grip Pull Up
    static var mixedGripPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Mixed Grip Pull Up", number: 16)
    }

    /// Weighted Mixed Grip Pull Up
    static var weightedMixedGripPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Mixed Grip Pull Up", number: 17)
    }

    /// Reverse Grip Pulldown
    static var reverseGripPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Reverse Grip Pulldown", number: 18)
    }

    /// Standing Cable Pullover
    static var standingCablePullover: PullUpExerciseName {
        return PullUpExerciseName(name: "Standing Cable Pullover", number: 19)
    }

    /// Straight Arm Pulldown
    static var straightArmPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Straight Arm Pulldown", number: 20)
    }

    /// Swiss Ball EZ Bar Pullover
    static var swissBallEzBarPullover: PullUpExerciseName {
        return PullUpExerciseName(name: "Swiss Ball EZ Bar Pullover", number: 21)
    }

    /// Towel Pull Up
    static var towelPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Towel Pull Up", number: 22)
    }

    /// Weighted Towel Pull Up
    static var weightedTowelPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Towel Pull Up", number: 23)
    }

    /// Weighted Pull Up
    static var weightedPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Pull Up", number: 24)
    }

    /// Wide Grip Lat Pulldown
    static var wideGripLatPulldown: PullUpExerciseName {
        return PullUpExerciseName(name: "Wide Grip Lat Pulldown", number: 25)
    }

    /// Wide Grip Pull Up
    static var wideGripPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Wide Grip Pull Up", number: 26)
    }

    /// Weighted Wide Grip Pull Up
    static var weightedWideGripPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Wide Grip Pull Up", number: 27)
    }

    /// Burpee Pull Up
    static var burpeePullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Burpee Pull Up", number: 28)
    }

    /// Weighted Burpee Pull Up
    static var weightedBurpeePullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Burpee Pull Up", number: 29)
    }

    /// Jumping Pull Up
    static var jumpingPullUps: PullUpExerciseName {
        return PullUpExerciseName(name: "Jumping Pull Up", number: 30)
    }

    /// Weighted Jumping Pull Up
    static var weightedJumpingPullUps: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Jumping Pull Up", number: 31)
    }

    /// Kipping Pull Up
    static var kippingPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Kipping Pull Up", number: 32)
    }

    /// Weighted Kipping Pull Up
    static var weightedKippingPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Kipping Pull Up", number: 33)
    }

    /// L Pull Up
    static var lPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "L Pull Up", number: 34)
    }

    /// Weighted L Pull Up
    static var weightedLPullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted L Pull Up", number: 35)
    }

    /// Suspended Chin Up
    static var suspendedChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Suspended Chin Up", number: 36)
    }

    /// Weighted Suspended Chin Up
    static var weightedSuspendedChinUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Weighted Suspended Chin Up", number: 37)
    }

    /// Pull Up
    static var pullUp: PullUpExerciseName {
        return PullUpExerciseName(name: "Pull Up", number: 38)
    }
}
