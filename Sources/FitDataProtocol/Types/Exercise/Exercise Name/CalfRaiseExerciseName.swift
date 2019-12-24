//
//  CalfRaiseExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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

/// Calf Raise Exercise Name
public struct CalfRaiseExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = CalfRaiseExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .calfRaise }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension CalfRaiseExerciseName: Hashable {}

public extension CalfRaiseExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [CalfRaiseExerciseName] {

        return [.threewayCalfRaise,
                .threewayWeightedCalfRaise,
                .threewaySingleLegCalfRaise,
                .threewaySingleWeightedLegCalfRaise,
                .donkeyCalfRaise,
                .weightedDonkeyCalfRaise,
                .seatedCalfRaise,
                .weightedSeatedCalfRaise,
                .seatedDumbbellToeRaise,
                .singleLegBentKneeCalfRaise,
                .weightedSingleLegBentKneeCalfRaise,
                .singleLegDeclinePushUp,
                .singleLegDonkeyCalfRaise,
                .weightedSingleLegDonkeyCalfRaise,
                .singleLegHipRaiseKneeHold,
                .singleLegStandingCalfRaise,
                .singleLegStandingDumbbellCalfRaise,
                .standingBarbellCalfRaise,
                .standingCalfRaise,
                .weightedStandingCalfRaise,
                .weightedStandingDumbbellCalfRaise
        ]
    }
}

public extension CalfRaiseExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> CalfRaiseExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension CalfRaiseExerciseName {

    /// 3-Way Calf Raise
    static var threewayCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "3-Way Calf Raise", number: 0)
    }

    /// 3-Way Weighted Calf Raise
    static var threewayWeightedCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "3-Way Weighted Calf Raise", number: 1)
    }

    /// 3-Way Single Leg Calf Raise
    static var threewaySingleLegCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "3-Way Single Leg Calf Raise", number: 2)
    }

    /// 3-Way Weighted Single Leg Calf Raise
    static var threewaySingleWeightedLegCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "3-Way Weighted Single Leg Calf Raise", number: 3)
    }

    /// Donkey Calf Raise
    static var donkeyCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Donkey Calf Raise", number: 4)
    }

    /// Weighted Donkey Calf Raise
    static var weightedDonkeyCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Weighted Donkey Calf Raise", number: 5)
    }

    /// Seated Calf Raise
    static var seatedCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Seated Calf Raise", number: 6)
    }

    /// Weighted Seated Calf Raise
    static var weightedSeatedCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Weighted Seated Calf Raise", number: 7)
    }

    /// Seated Dumbbell Toe Raise
    static var seatedDumbbellToeRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Seated Dumbbell Toe Raise", number: 8)
    }

    /// Single Leg Bent Knee Calf Raise
    static var singleLegBentKneeCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Single Leg Bent Knee Calf Raise", number: 9)
    }

    /// Weighted Single Leg Bent Knee Calf Raise
    static var weightedSingleLegBentKneeCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Weighted Single Leg Bent Knee Calf Raise", number: 10)
    }

    /// Single Leg Decline Push Up
    static var singleLegDeclinePushUp: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Single Leg Decline Push Up", number: 11)
    }

    /// Single Leg Donkey Calf Raise
    static var singleLegDonkeyCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Single Leg Donkey Calf Raise", number: 12)
    }

    /// Weighted Single Leg Donkey Calf Raise
    static var weightedSingleLegDonkeyCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Weighted Single Leg Donkey Calf Raise", number: 13)
    }

    /// Single Leg Hip Raise With Knee Hold
    static var singleLegHipRaiseKneeHold: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Single Leg Hip Raise With Knee Hold", number: 14)
    }

    /// Single Leg Standing Calf Raise
    static var singleLegStandingCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Single Leg Standing Calf Raise", number: 15)
    }

    /// Single Leg Standing Dumbbell Calf Raise
    static var singleLegStandingDumbbellCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Single Leg Standing Dumbbell Calf Raise", number: 16)
    }

    /// Standing Barbell Calf Raise
    static var standingBarbellCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Standing Barbell Calf Raise", number: 17)
    }

    /// Standing Calf Raise
    static var standingCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Standing Calf Raise", number: 18)
    }

    /// Weighted Standing Calf Raise
    static var weightedStandingCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Weighted Standing Calf Raise", number: 19)
    }

    /// Weighted Standing Dumbbell Calf Raise
    static var weightedStandingDumbbellCalfRaise: CalfRaiseExerciseName {
        return CalfRaiseExerciseName(name: "Weighted Standing Dumbbell Calf Raise", number: 20)
    }
}
