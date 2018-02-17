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
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    public static func ==(lhs: CarryExerciseName, rhs: CarryExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}


public extension CarryExerciseName {

    public static var supportedExerciseNames: [CarryExerciseName] {

        return [.barHolds,
                .farmersWalk,
                .farmersWalkOnToes,
                .hexDumbbellHold,
                .overheadCarry
        ]
    }
}

public extension CarryExerciseName {

    public static func create(rawValue: UInt16) -> CarryExerciseName? {

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
    public static var barHolds: CarryExerciseName {
        return CarryExerciseName(name: "Bar Holds", number: 0)
    }

    /// Farmers Walk
    public static var farmersWalk: CarryExerciseName {
        return CarryExerciseName(name: "Farmers Walk", number: 1)
    }

    /// Farmers Walk on Toes
    public static var farmersWalkOnToes: CarryExerciseName {
        return CarryExerciseName(name: "Farmers Walk on Toes", number: 2)
    }

    /// Hex Dumbbell Hold
    public static var hexDumbbellHold: CarryExerciseName {
        return CarryExerciseName(name: "Hex Dumbbell Hold", number: 3)
    }

    /// Overhead Carry
    public static var overheadCarry: CarryExerciseName {
        return CarryExerciseName(name: "Overhead Carry", number: 4)
    }
}
