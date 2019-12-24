//
//  FlyeExerciseName.swift
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

/// Flye Exercise Name
public struct FlyeExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = FlyeExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .flye }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension FlyeExerciseName: Hashable {}

public extension FlyeExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [FlyeExerciseName] {

        return [.cableCrossover,
                .declineDumbbellFlye,
                .dumbbellFlye,
                .inclineDumbbellFlye,
                .kettlebellFlye,
                .kneelingRearFlye,
                .singleArmStandingCableReverseFlye,
                .swissBallDumbbellFlye
        ]
    }
}

public extension FlyeExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> FlyeExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension FlyeExerciseName {

    /// Cable Crossover
    static var cableCrossover: FlyeExerciseName {
        return FlyeExerciseName(name: "Cable Crossover", number: 0)
    }

    /// Decline Dumbbell Flye
    static var declineDumbbellFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Decline Dumbbell Flye", number: 1)
    }

    /// Dumbbell Flye
    static var dumbbellFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Dumbbell Flye", number: 2)
    }

    /// Incline Dumbbell Flye
    static var inclineDumbbellFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Incline Dumbbell Flye", number: 3)
    }

    /// Kettlebell Flye
    static var kettlebellFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Kettlebell Flye", number: 4)
    }

    /// Kneeling Rear Flye
    static var kneelingRearFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Kneeling Rear Flye", number: 5)
    }

    /// Single Arm Standing Cable Reverse Flye
    static var singleArmStandingCableReverseFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Single Arm Standing Cable Reverse Flye", number: 6)
    }

    /// Swiss Ball Dumbbell Flye
    static var swissBallDumbbellFlye: FlyeExerciseName {
        return FlyeExerciseName(name: "Swiss Ball Dumbbell Flye", number: 7)
    }

}
