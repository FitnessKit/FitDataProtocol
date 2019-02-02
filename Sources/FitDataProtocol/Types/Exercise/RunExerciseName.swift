//
//  RunExerciseName.swift
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

/// Run Exercise Name
public struct RunExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = RunExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension RunExerciseName: Hashable {

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
    public static func == (lhs: RunExerciseName, rhs: RunExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension RunExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [RunExerciseName] {

        return [.run,
                .walk,
                .jog,
                .sprint
        ]
    }
}

public extension RunExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> RunExerciseName? {

        for name in RunExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension RunExerciseName {

    /// Run
    public static var run: RunExerciseName {
        return RunExerciseName(name: "Run", number: 0)
    }

    /// Walk
    public static var walk: RunExerciseName {
        return RunExerciseName(name: "Walk", number: 1)
    }

    /// Jog
    public static var jog: RunExerciseName {
        return RunExerciseName(name: "Jog", number: 2)
    }

    /// Sprint
    public static var sprint: RunExerciseName {
        return RunExerciseName(name: "Sprint", number: 3)
    }
}
