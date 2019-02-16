//
//  OlympicLiftExerciseName.swift
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

/// Olympic Lift Exercise Name
public struct OlympicLiftExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = OlympicLiftExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension OlympicLiftExerciseName: Hashable {

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
    public static func == (lhs: OlympicLiftExerciseName, rhs: OlympicLiftExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension OlympicLiftExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [OlympicLiftExerciseName] {

        return [.barbellHangPowerClean,
                .barbellHangSquatClean,
                .barbellPowerClean,
                .barbellPowerSnatch,
                .barbellSquatClean,
                .cleanJerk,
                .barbellHangPowerSnatch,
                .barbellHangPull,
                .barbellHighPull,
                .barbellSnatch,
                .barbellSplitJerk,
                .clean,
                .dumbbellClean,
                .dumbbellHangPull,
                .oneHandDumbbellSplitSnatch,
                .pushJerk,
                .singleArmDumbbellSnatch,
                .singleArmHangSnatch,
                .singleArmKettlebellSnatch,
                .splitJerk,
                .squatCleanJerk
        ]
    }
}

public extension OlympicLiftExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> OlympicLiftExerciseName? {

        for name in OlympicLiftExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension OlympicLiftExerciseName {

    /// Barbell Hang Power Clean
    public static var barbellHangPowerClean: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Hang Power Clean", number: 0)
    }

    /// Barbell Hang Squat Clean
    public static var barbellHangSquatClean: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Hang Squat Clean", number: 1)
    }

    /// Barbell Power Clean
    public static var barbellPowerClean: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Power Clean", number: 2)
    }

    /// Barbell Power Snatch
    public static var barbellPowerSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Power Snatch", number: 3)
    }

    /// Barbell Squat Clean
    public static var barbellSquatClean: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Squat Clean", number: 4)
    }

    /// Clean and Jerk
    public static var cleanJerk: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Clean and Jerk", number: 5)
    }

    /// Barbell Hang Power Snatch
    public static var barbellHangPowerSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Hang Power Snatch", number: 6)
    }

    /// Barbell Hang Pull
    public static var barbellHangPull: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Hang Pull", number: 7)
    }

    /// Barbell High Pull
    public static var barbellHighPull: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell High Pull", number: 8)
    }

    /// Barbell Snatch
    public static var barbellSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Snatch", number: 9)
    }

    /// Barbell Split Jerk
    public static var barbellSplitJerk: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Barbell Split Jerk", number: 10)
    }

    /// Clean
    public static var clean: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Clean", number: 11)
    }

    /// Dumbbell Clean
    public static var dumbbellClean: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Dumbbell Clean", number: 12)
    }

    /// Dumbbell Hang Pull
    public static var dumbbellHangPull: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Dumbbell Hang Pull", number: 13)
    }

    /// One Hand Dumbbell Split Snatch
    public static var oneHandDumbbellSplitSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "One Hand Dumbbell Split Snatch", number: 14)
    }

    /// Push Jerk
    public static var pushJerk: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Push Jerk", number: 15)
    }

    /// Single Arm Dumbbell Snatch
    public static var singleArmDumbbellSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Single Arm Dumbbell Snatch", number: 16)
    }

    /// Single Arm Hang Snatch
    public static var singleArmHangSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Single Arm Hang Snatch", number: 17)
    }

    /// Single Arm Kettelbell Snatch
    public static var singleArmKettlebellSnatch: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Single Arm Kettelbell Snatch", number: 18)
    }

    /// Split Jerk
    public static var splitJerk: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Split Jerk", number: 19)
    }

    /// Squat Clean and Jerk
    public static var squatCleanJerk: OlympicLiftExerciseName {
        return OlympicLiftExerciseName(name: "Squat Clean and Jerk", number: 20)
    }
}
