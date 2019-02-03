//
//  ShrugExerciseName.swift
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

/// Shrug Exercise Name
public struct ShrugExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = ShrugExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension ShrugExerciseName: Hashable {

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
    public static func == (lhs: ShrugExerciseName, rhs: ShrugExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension ShrugExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [ShrugExerciseName] {

        return [.barbellJumpShrug,
                .barbellShrug,
                .barbellUprightRow,
                .behindTheBackSmithMachineShrug,
                .dumbbellJumpShrug,
                .dumbbellShrug,
                .dumbbellUprightRow,
                .inclineDumbbellShrug,
                .overheadBarbellShrug,
                .overheadDumbbellShrug,
                .scaptionAndShrug,
                .scapularRetraction,
                .serratusChairShurg,
                .weightedSerratusChairShurg,
                .serratusShurg,
                .weightedSerratusShurg,
                .wideGripJumpShrug
        ]
    }
}

public extension ShrugExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> ShrugExerciseName? {

        for name in ShrugExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension ShrugExerciseName {

    /// Barbell Jump Shrug
    public static var barbellJumpShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Barbell Jump Shrug", number: 0)
    }

    /// Barbell Shrug
    public static var barbellShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Barbell Shrug", number: 1)
    }

    /// Barbell Upright Row
    public static var barbellUprightRow: ShrugExerciseName {
        return ShrugExerciseName(name: "Barbell Upright Row", number: 2)
    }

    /// Behind the Back Smith Machine Shrug
    public static var behindTheBackSmithMachineShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Behind the Back Smith Machine Shrug", number: 3)
    }

    /// Dumbbell Jump Shrug
    public static var dumbbellJumpShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Dumbbell Jump Shrug", number: 4)
    }

    /// Dumbbell Shrug
    public static var dumbbellShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Dumbbell Shrug", number: 5)
    }

    /// Dumbbell Upright Row
    public static var dumbbellUprightRow: ShrugExerciseName {
        return ShrugExerciseName(name: "Dumbbell Upright Row", number: 6)
    }

    /// Incline Dumbbell Shrug
    public static var inclineDumbbellShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Incline Dumbbell Shrug", number: 7)
    }

    /// Overhead Barbell Shrug
    public static var overheadBarbellShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Overhead Barbell Shrug", number: 8)
    }

    /// Overhead Dumbbell Shrug
    public static var overheadDumbbellShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Overhead Dumbbell Shrug", number: 9)
    }

    /// Scaption And Shrug
    public static var scaptionAndShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Scaption And Shrug", number: 10)
    }

    /// Scapular Retraction
    public static var scapularRetraction: ShrugExerciseName {
        return ShrugExerciseName(name: "Scapular Retraction", number: 11)
    }

    /// Serratus Chair Shrug
    public static var serratusChairShurg: ShrugExerciseName {
        return ShrugExerciseName(name: "Serratus Chair Shrug", number: 12)
    }

    /// Weighted Serratus Chair Shrug
    public static var weightedSerratusChairShurg: ShrugExerciseName {
        return ShrugExerciseName(name: "Weighted Serratus Chair Shrug", number: 13)
    }

    /// Serratus Shrug
    public static var serratusShurg: ShrugExerciseName {
        return ShrugExerciseName(name: "Serratus Shrug", number: 14)
    }

    /// Weighted Serratus Shrug
    public static var weightedSerratusShurg: ShrugExerciseName {
        return ShrugExerciseName(name: "Weighted Serratus Shrug", number: 15)
    }

    /// Wide Grip Jump Shrug
    public static var wideGripJumpShrug: ShrugExerciseName {
        return ShrugExerciseName(name: "Wide Grip Jump Shrug", number: 16)
    }
}
