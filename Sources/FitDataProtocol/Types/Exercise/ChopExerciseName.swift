//
//  ChopExerciseName.swift
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

/// Chop Exercise Name
public struct ChopExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = ChopExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .chop }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension ChopExerciseName: Hashable {}

public extension ChopExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [ChopExerciseName] {

        return [.cablePullThrough,
                .cableRotationalLift,
                .cableWoodchop,
                .crossChopToKnee,
                .weightedCrossChopToKnee,
                .dumbbellChop,
                .halfKneelingRotation,
                .weightedHalfKneelingRotation,
                .halfKneelingRotationalChop,
                .halfKneelingRotationalReverseChop,
                .halfKneelingStabilityChop,
                .halfKneelingStabilityReverseChop,
                .kneelingRotationalChop,
                .kneelingRotationalReverseChop,
                .kneelingRotationalStabilityChop,
                .kneelingWoodchopper,
                .medicineBallWoodChops,
                .powerSquatChops,
                .weightedPowerSquatChops,
                .standingRotationalChop,
                .standingSplitRotationalChop,
                .standingSplitRotationalReverseChop,
                .standingStabilityReverseChop
        ]
    }
}

public extension ChopExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> ChopExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension ChopExerciseName {

    /// Cable Pull Through
    static var cablePullThrough: ChopExerciseName {
        return ChopExerciseName(name: "Cable Pull Through", number: 0)
    }

    /// Cable Rotational Lift
    static var cableRotationalLift: ChopExerciseName {
        return ChopExerciseName(name: "Cable Rotational Lift", number: 1)
    }

    /// Cable Woodchop
    static var cableWoodchop: ChopExerciseName {
        return ChopExerciseName(name: "Cable Woodchop", number: 2)
    }

    /// Cross Chop to Knee
    static var crossChopToKnee: ChopExerciseName {
        return ChopExerciseName(name: "Cross Chop to Knee", number: 3)
    }

    /// Weighted Cross Chop to Knee
    static var weightedCrossChopToKnee: ChopExerciseName {
        return ChopExerciseName(name: "Weighted Cross Chop to Knee", number: 4)
    }

    /// Dumbbell Chop
    static var dumbbellChop: ChopExerciseName {
        return ChopExerciseName(name: "Dumbbell Chop", number: 5)
    }

    /// Half Kneeling Rotation
    static var halfKneelingRotation: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Rotation", number: 6)
    }

    /// Weighted Half Kneeling Rotation
    static var weightedHalfKneelingRotation: ChopExerciseName {
        return ChopExerciseName(name: "Weighted Half Kneeling Rotation", number: 7)
    }

    /// Half Kneeling Rotational Chop
    static var halfKneelingRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Rotational Chop", number: 8)
    }

    /// Half Kneeling Rotational Reverse Chop
    static var halfKneelingRotationalReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Rotational Reverse Chop", number: 9)
    }

    /// Half Kneeling Stability Chop
    static var halfKneelingStabilityChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Stability Chop", number: 10)
    }

    /// Half Kneeling Stability Reverse Chop
    static var halfKneelingStabilityReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Stability Reverse Chop", number: 11)
    }

    /// Kneeling Rotational Chop
    static var kneelingRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Rotational Chop", number: 12)
    }

    /// Kneeling Rotational Reverse Chop
    static var kneelingRotationalReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Rotational Reverse Chop", number: 13)
    }

    /// Kneeling Rotational Stability Chop
    static var kneelingRotationalStabilityChop: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Rotational Stability Chop", number: 14)
    }

    /// Kneeling Woodchopper
    static var kneelingWoodchopper: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Woodchopper", number: 15)
    }

    /// Medicine Ball Wood Chops
    static var medicineBallWoodChops: ChopExerciseName {
        return ChopExerciseName(name: "Medicine Ball Wood Chops", number: 16)
    }

    /// Power Squat Chops
    static var powerSquatChops: ChopExerciseName {
        return ChopExerciseName(name: "Power Squat Chops", number: 17)
    }

    /// Weighted Power Squat Chops
    static var weightedPowerSquatChops: ChopExerciseName {
        return ChopExerciseName(name: "Weighted Power Squat Chops", number: 18)
    }

    /// Standing Rotational Chop
    static var standingRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Rotational Chop", number: 19)
    }

    /// Standing Split Rotational Chop
    static var standingSplitRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Split Rotational Chop", number: 20)
    }

    /// Standing Split Rotational Reverse Chop
    static var standingSplitRotationalReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Split Rotational Reverse Chop", number: 21)
    }

    /// Standing Stability Reverse Chop
    static var standingStabilityReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Stability Reverse Chop", number: 22)
    }
}
