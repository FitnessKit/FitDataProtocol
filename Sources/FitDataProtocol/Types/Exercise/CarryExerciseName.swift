//
//  CarryExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/11/18.
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

/// Carry Exercise Name
public struct CarryExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = CarryExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension CarryExerciseName: Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(number)
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: CarryExerciseName, rhs: CarryExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension CarryExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [CarryExerciseName] {

        return [.barHolds,
                .farmersWalk,
                .farmersWalkOnToes,
                .hexDumbbellHold,
                .overheadCarry
        ]
    }
}

public extension CarryExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> CarryExerciseName? {

        for name in CarryExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension CarryExerciseName {

    /// Bar Holds
    static var barHolds: CarryExerciseName {
        return CarryExerciseName(name: "Bar Holds", number: 0)
    }

    /// Farmers Walk
    static var farmersWalk: CarryExerciseName {
        return CarryExerciseName(name: "Farmers Walk", number: 1)
    }

    /// Farmers Walk on Toes
    static var farmersWalkOnToes: CarryExerciseName {
        return CarryExerciseName(name: "Farmers Walk on Toes", number: 2)
    }

    /// Hex Dumbbell Hold
    static var hexDumbbellHold: CarryExerciseName {
        return CarryExerciseName(name: "Hex Dumbbell Hold", number: 3)
    }

    /// Overhead Carry
    static var overheadCarry: CarryExerciseName {
        return CarryExerciseName(name: "Overhead Carry", number: 4)
    }
}
