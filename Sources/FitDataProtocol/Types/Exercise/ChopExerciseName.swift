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
    public typealias ExerciseNameType = ChopExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension ChopExerciseName: Hashable {

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
    public static func == (lhs: ChopExerciseName, rhs: ChopExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension ChopExerciseName {

    public static var supportedExerciseNames: [ChopExerciseName] {

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

    public static func create(rawValue: UInt16) -> ChopExerciseName? {

        for name in ChopExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension ChopExerciseName {

    /// Cable Pull Through
    public static var cablePullThrough: ChopExerciseName {
        return ChopExerciseName(name: "Cable Pull Through", number: 0)
    }

    /// Cable Rotational Lift
    public static var cableRotationalLift: ChopExerciseName {
        return ChopExerciseName(name: "Cable Rotational Lift", number: 1)
    }

    /// Cable Woodchop
    public static var cableWoodchop: ChopExerciseName {
        return ChopExerciseName(name: "Cable Woodchop", number: 2)
    }

    /// Cross Chop to Knee
    public static var crossChopToKnee: ChopExerciseName {
        return ChopExerciseName(name: "Cross Chop to Knee", number: 3)
    }

    /// Weighted Cross Chop to Knee
    public static var weightedCrossChopToKnee: ChopExerciseName {
        return ChopExerciseName(name: "Weighted Cross Chop to Knee", number: 4)
    }

    /// Dumbbell Chop
    public static var dumbbellChop: ChopExerciseName {
        return ChopExerciseName(name: "Dumbbell Chop", number: 5)
    }

    /// Half Kneeling Rotation
    public static var halfKneelingRotation: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Rotation", number: 6)
    }

    /// Weighted Half Kneeling Rotation
    public static var weightedHalfKneelingRotation: ChopExerciseName {
        return ChopExerciseName(name: "Weighted Half Kneeling Rotation", number: 7)
    }

    /// Half Kneeling Rotational Chop
    public static var halfKneelingRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Rotational Chop", number: 8)
    }

    /// Half Kneeling Rotational Reverse Chop
    public static var halfKneelingRotationalReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Rotational Reverse Chop", number: 9)
    }

    /// Half Kneeling Stability Chop
    public static var halfKneelingStabilityChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Stability Chop", number: 10)
    }

    /// Half Kneeling Stability Reverse Chop
    public static var halfKneelingStabilityReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Half Kneeling Stability Reverse Chop", number: 11)
    }

    /// Kneeling Rotational Chop
    public static var kneelingRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Rotational Chop", number: 12)
    }

    /// Kneeling Rotational Reverse Chop
    public static var kneelingRotationalReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Rotational Reverse Chop", number: 13)
    }

    /// Kneeling Rotational Stability Chop
    public static var kneelingRotationalStabilityChop: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Rotational Stability Chop", number: 14)
    }

    /// Kneeling Woodchopper
    public static var kneelingWoodchopper: ChopExerciseName {
        return ChopExerciseName(name: "Kneeling Woodchopper", number: 15)
    }

    /// Medicine Ball Wood Chops
    public static var medicineBallWoodChops: ChopExerciseName {
        return ChopExerciseName(name: "Medicine Ball Wood Chops", number: 16)
    }

    /// Power Squat Chops
    public static var powerSquatChops: ChopExerciseName {
        return ChopExerciseName(name: "Power Squat Chops", number: 17)
    }

    /// Weighted Power Squat Chops
    public static var weightedPowerSquatChops: ChopExerciseName {
        return ChopExerciseName(name: "Weighted Power Squat Chops", number: 18)
    }

    /// Standing Rotational Chop
    public static var standingRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Rotational Chop", number: 19)
    }

    /// Standing Split Rotational Chop
    public static var standingSplitRotationalChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Split Rotational Chop", number: 20)
    }

    /// Standing Split Rotational Reverse Chop
    public static var standingSplitRotationalReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Split Rotational Reverse Chop", number: 21)
    }

    /// Standing Stability Reverse Chop
    public static var standingStabilityReverseChop: ChopExerciseName {
        return ChopExerciseName(name: "Standing Stability Reverse Chop", number: 22)
    }
}
