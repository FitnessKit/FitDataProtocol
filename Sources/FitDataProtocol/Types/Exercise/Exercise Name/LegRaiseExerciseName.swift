//
//  LegRaiseExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/19.
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

/// Leg Raise Exercise Name
public struct LegRaiseExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = LegRaiseExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .legRaise }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension LegRaiseExerciseName: Hashable {}

public extension LegRaiseExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [LegRaiseExerciseName] {

        return [.hangingKneeRaise,
                .hangingLegRaise,
                .weightedHangingLegRaise,
                .hangingSingleLegRaise,
                .weightedHangingSingleLegRaise,
                .kettlebellLegRaises,
                .legLoweringDrill,
                .weightedLegLoweringDrill,
                .lyingStraightLegRaise,
                .weightedLyingStraightLegRaise,
                .medicineBallLegDrops,
                .quadrupedLegRaise,
                .weightedQuadrupedLegRaise,
                .reverseLegRaise,
                .weightedReverseLegRaise,
                .reverseLegRaiseOnSwissBall,
                .weightedReverseLegRaiseOnSwissBall,
                .singleLegLoweringDrill,
                .weightedSingleLegLoweringDrill,
                .weightedHangingKneeRaise,
                .lateralStepover,
                .weightedLateralStepover
        ]
    }
}

public extension LegRaiseExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> LegRaiseExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension LegRaiseExerciseName {

    /// Hanging Knee Raise
    static var hangingKneeRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Hanging Knee Raise", number: 0)
    }

    /// Hanging Leg Raise
    static var hangingLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Hanging Leg Raise", number: 1)
    }

    /// Weighted Hanging Leg Raise
    static var weightedHangingLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Hanging Leg Raise", number: 2)
    }

    /// Hanging Single Leg Raise
    static var hangingSingleLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Hanging Single Leg Raise", number: 3)
    }

    /// Weighted Hanging Single Leg Raise
    static var weightedHangingSingleLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Hanging Single Leg Raise", number: 4)
    }

    /// Kettelbell Leg Raises
    static var kettlebellLegRaises: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Kettelbell Leg Raises", number: 5)
    }

    /// Leg Lowering Drill
    static var legLoweringDrill: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Leg Lowering Drill", number: 6)
    }

    /// Weighted Leg Lowering Drill
    static var weightedLegLoweringDrill: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Leg Lowering Drill", number: 7)
    }

    /// Lying Straight Leg Raise
    static var lyingStraightLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Lying Straight Leg Raise", number: 8)
    }

    /// Weighted Lying Straight Leg Raise
    static var weightedLyingStraightLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Lying Straight Leg Raise", number: 9)
    }

    /// Medicine Ball Leg Drops
    static var medicineBallLegDrops: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Medicine Ball Leg Drops", number: 10)
    }

    /// Quadruped Leg Raise
    static var quadrupedLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Quadruped Leg Raise", number: 11)
    }

    /// Weighted Quadruped Leg Raise
    static var weightedQuadrupedLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Quadruped Leg Raise", number: 12)
    }

    /// Reverse Leg Raise
    static var reverseLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Reverse Leg Raise", number: 13)
    }

    /// Weighted Reverse Leg Raise
    static var weightedReverseLegRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Reverse Leg Raise", number: 14)
    }

    /// Reverse Leg Raise on Swiss Ball
    static var reverseLegRaiseOnSwissBall: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Reverse Leg Raise on Swiss Ball", number: 15)
    }

    /// Weighted Reverse Leg Raise on Swiss Ball
    static var weightedReverseLegRaiseOnSwissBall: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Reverse Leg Raise on Swiss Ball", number: 16)
    }

    /// Single Leg Lowering Drill
    static var singleLegLoweringDrill: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Single Leg Lowering Drill", number: 17)
    }

    /// Weighted Single Leg Lowering Drill
    static var weightedSingleLegLoweringDrill: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Single Leg Lowering Drill", number: 18)
    }

    /// Weighted Hanging Knee Raise
    static var weightedHangingKneeRaise: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Hanging Knee Raise", number: 19)
    }

    /// Lateral Stepover
    static var lateralStepover: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Lateral Stepover", number: 20)
    }

    /// Weighted Lateral Stepover
    static var weightedLateralStepover: LegRaiseExerciseName {
        return LegRaiseExerciseName(name: "Weighted Lateral Stepover", number: 21)
    }
}
