//
//  TotalBodyExerciseName.swift
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

/// Total Body Exercise Name
public struct TotalBodyExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = TotalBodyExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension TotalBodyExerciseName: Hashable {

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
    public static func == (lhs: TotalBodyExerciseName, rhs: TotalBodyExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension TotalBodyExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [TotalBodyExerciseName] {

        return [.burpee,
                .weightedBurpee,
                .burpeeBoxJump,
                .weightedBurpeeBoxJump,
                .highPullBurpee,
                .manMakers,
                .oneArmBurpee,
                .squatThrusts,
                .weightedSquatThrusts,
                .squatPlankPushUp,
                .weightedSquatPlankPushUp,
                .standingTRotationBalance,
                .weightedStandingTRotationBalance
        ]
    }
}

public extension TotalBodyExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> TotalBodyExerciseName? {

        for name in TotalBodyExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension TotalBodyExerciseName {

    /// Burpee
    public static var burpee: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Burpee", number: 0)
    }

    /// Weighted Burpee
    public static var weightedBurpee: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Weighted Burpee", number: 1)
    }

    /// Burpee Box Jump
    public static var burpeeBoxJump: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Burpee Box Jump", number: 2)
    }

    /// Weighted Burpee Box Jump
    public static var weightedBurpeeBoxJump: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Weighted Burpee Box Jump", number: 3)
    }

    /// High Pull Burpee
    public static var highPullBurpee: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "High Pull Burpee", number: 4)
    }

    /// Man Makers
    public static var manMakers: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Man Makers", number: 5)
    }

    /// One Arm Burpee
    public static var oneArmBurpee: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "One Arm Burpee", number: 6)
    }

    /// Squat Thrusts
    public static var squatThrusts: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Squat Thrusts", number: 7)
    }

    /// Weighted Squat Thrusts
    public static var weightedSquatThrusts: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Weighted Squat Thrusts", number: 8)
    }

    /// Squat Plank Push Up
    public static var squatPlankPushUp: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Squat Plank Push Up", number: 9)
    }

    /// Weighted Squat Plank Push Up
    public static var weightedSquatPlankPushUp: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Weighted Squat Plank Push Up", number: 10)
    }

    /// Standing T Rotation Balance
    public static var standingTRotationBalance: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Standing T Rotation Balance", number: 11)
    }

    /// Weighted Standing T Rotation Balance
    public static var weightedStandingTRotationBalance: TotalBodyExerciseName {
        return TotalBodyExerciseName(name: "Weighted Standing T Rotation Balance", number: 12)
    }
}
