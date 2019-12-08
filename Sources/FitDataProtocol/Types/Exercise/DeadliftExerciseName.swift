//
//  DeadliftExerciseName.swift
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

/// Deadlift Exercise Name
public struct DeadliftExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = DeadliftExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .deadlift }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension DeadliftExerciseName: Hashable {}

public extension DeadliftExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [DeadliftExerciseName] {

        return [.barbellDeadlift,
                .barbellStraightLegDeadlift,
                .dumbbellDeadlift,
                .dumbbellSingleLegDeadliftToRow,
                .dumbbellStraightLegDeadlift,
                .kettlebellFloorToShelf,
                .oneArmOneLegDeadlift,
                .rackPull,
                .rotationalDumbbellStraightLegDeadlift,
                .singleArmDeadlift,
                .singleLegBarbellDeadlift,
                .singleLegBarbellStraightLegDeadlift,
                .singleLegDeadliftBarbell,
                .singleLegRdlCircuit,
                .singleLegRomanianDeadliftDumbbell,
                .sumoDeadlift,
                .sumoDeadliftHighPull,
                .trapBarDeadlift,
                .wideGripBarbellDeadlift,
        ]
    }
}

public extension DeadliftExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> DeadliftExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension DeadliftExerciseName {

    /// Barbell Deadlift
    static var barbellDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Barbell Deadlift", number: 0)
    }

    /// Barbell Straight Leg Deadlift
    static var barbellStraightLegDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Barbell Straight Leg Deadlift", number: 1)
    }

    /// Dumbbell Deadlift
    static var dumbbellDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Dumbbell Deadlift", number: 2)
    }

    /// Dumbbell Single Leg Deadlift to Row
    static var dumbbellSingleLegDeadliftToRow: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Dumbbell Single Leg Deadlift to Row", number: 3)
    }

    /// Dumbbell Straight Leg Deadlift
    static var dumbbellStraightLegDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Dumbbell Straight Leg Deadlift", number: 4)
    }

    /// Kettlebell Floor to Shelf
    static var kettlebellFloorToShelf: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Kettlebell Floor to Shelf", number: 5)
    }

    /// One Arm One Leg Deadlift
    static var oneArmOneLegDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "One Arm One Leg Deadlift", number: 6)
    }

    /// Rack Pull
    static var rackPull: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Rack Pull", number: 7)
    }

    /// Rotational Dumbbell Straight Leg Deadlift
    static var rotationalDumbbellStraightLegDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Rotational Dumbbell Straight Leg Deadlift", number: 8)
    }

    /// Single Arm Deadlift
    static var singleArmDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Single Arm Deadlift", number: 9)
    }

    /// Single Leg Barbell Deadlift
    static var singleLegBarbellDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Single Leg Barbell Deadlift", number: 10)
    }

    /// Single Leg Barbell Straight Leg Deadlift
    static var singleLegBarbellStraightLegDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Single Leg Barbell Straight Leg Deadlift", number: 11)
    }

    /// Single Leg Deadlift with Barbell
    static var singleLegDeadliftBarbell: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Single Leg Deadlift with Barbell", number: 12)
    }

    /// Single Leg RDL Circuit
    static var singleLegRdlCircuit: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Single Leg RDL Circuit", number: 13)
    }

    /// Single Leg Romanian Deadlift with Dumbbell
    static var singleLegRomanianDeadliftDumbbell: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Single Leg Romanian Deadlift with Dumbbell", number: 14)
    }

    /// Sumo Deadlift
    static var sumoDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Sumo Deadlift", number: 15)
    }

    /// Sumo Deadlift High Pull
    static var sumoDeadliftHighPull: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Sumo Deadlift High Pull", number: 16)
    }

    /// Trap Bar Deadlift
    static var trapBarDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Trap Bar Deadlift", number: 17)
    }

    /// Wide Grip Barbell Deadlift
    static var wideGripBarbellDeadlift: DeadliftExerciseName {
        return DeadliftExerciseName(name: "Wide Grip Barbell Deadlift", number: 18)
    }
}
