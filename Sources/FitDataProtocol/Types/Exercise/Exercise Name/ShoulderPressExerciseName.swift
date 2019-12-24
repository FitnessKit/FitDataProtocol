//
//  ShoulderPressExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/16/19.
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

/// Shoulder Press Exercise Name
public struct ShoulderPressExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = ShoulderPressExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .shoulderPress }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension ShoulderPressExerciseName: Hashable {}

public extension ShoulderPressExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [ShoulderPressExerciseName] {

        return [.alternatingDumbbellShoulderPress,
                .arnoldPress,
                .barbellFrontSquatPushPress,
                .barbellPushPress,
                .barbellShoulderPress,
                .deadCurlPress,
                .dumbbellAlternatingShoulderPressTwist,
                .dumbbellHammerCurlLungePress,
                .dumbbellPushPress,
                .floorInvertedShoulderPress,
                .weightedFloorInvertedShoulderPress,
                .invertedShoulderPress,
                .weightedInvertedShoulderPress,
                .oneArmPushPress,
                .overheadBarbellPress,
                .overheadDumbbellPress,
                .seatedBarbellShoulderPress,
                .seatedDumbbellShoulderPress,
                .singleArmDumbbellShoulderPress,
                .singleArmStepUpPress,
                .smithMachineOverheadPress,
                .splitStanceHammerCurlPress,
                .swissBallDumbbellShoulderPress,
                .weightPlateFrontRaise,
        ]
    }
}

public extension ShoulderPressExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> ShoulderPressExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension ShoulderPressExerciseName {

    /// Alternating Dumbbell Shoulder Press
    static var alternatingDumbbellShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Alternating Dumbbell Shoulder Press", number: 0)
    }

    /// Arnold Press
    static var arnoldPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Arnold Press", number: 1)
    }

    /// Barbell Front Squat to Push Press
    static var barbellFrontSquatPushPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Barbell Front Squat to Push Press", number: 2)
    }

    /// Barbell Push Press
    static var barbellPushPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Barbell Push Press", number: 3)
    }

    /// Barbell Shoulder Press
    static var barbellShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Barbell Shoulder Press", number: 4)
    }

    /// Dead Curl Press
    static var deadCurlPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Dead Curl Press", number: 5)
    }

    /// Dumbbell Alternating Shoulder Press and Twist
    static var dumbbellAlternatingShoulderPressTwist: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Dumbbell Alternating Shoulder Press and Twist", number: 6)
    }

    /// Dumbbell Hammer Curl to Lunge to Press
    static var dumbbellHammerCurlLungePress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Dumbbell Hammer Curl to Lunge to Press", number: 7)
    }

    /// Dumbbell Push Press
    static var dumbbellPushPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Dumbbell Push Press", number: 8)
    }

    /// Floor Inverted Shoulder Press
    static var floorInvertedShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Floor Inverted Shoulder Press", number: 9)
    }

    /// Weighted Floor Inverted Shoulder Press
    static var weightedFloorInvertedShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Weighted Floor Inverted Shoulder Press", number: 10)
    }

    /// Inverted Shoulder Press
    static var invertedShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Inverted Shoulder Press", number: 11)
    }

    /// Weighted Inverted Shoulder Press
    static var weightedInvertedShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Weighted Inverted Shoulder Press", number: 12)
    }

    /// One Arm Push Press
    static var oneArmPushPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "One Arm Push Press", number: 13)
    }

    /// Overhead Barbell Press
    static var overheadBarbellPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Overhead Barbell Press", number: 14)
    }

    /// Overhead Dumbbell Press
    static var overheadDumbbellPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Overhead Dumbbell Press", number: 15)
    }

    /// Seated Barbell Shoulder Press
    static var seatedBarbellShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Seated Barbell Shoulder Press", number: 16)
    }

    /// Seated Dumbbell Shoulder Press
    static var seatedDumbbellShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Seated Dumbbell Shoulder Press", number: 17)
    }

    /// Single Arm Dumbbell Shoulder Press
    static var singleArmDumbbellShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Single Arm Dumbbell Shoulder Press", number: 18)
    }

    /// Single Arm Step Up and Press
    static var singleArmStepUpPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Single Arm Step Up an Press", number: 19)
    }

    /// Smith Machine Overhead Press
    static var smithMachineOverheadPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Smith Machine Overhead Press", number: 20)
    }

    /// Split Stance Hammer Curl to Press
    static var splitStanceHammerCurlPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Split Stance Hammer Curl to Press", number: 21)
    }

    /// Swiss Ball Dumbbell Shoulder Press
    static var swissBallDumbbellShoulderPress: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Swiss Ball Dumbbell Shoulder Press", number: 22)
    }

    /// Weight Plate Front Raise
    static var weightPlateFrontRaise: ShoulderPressExerciseName {
        return ShoulderPressExerciseName(name: "Weight Plate Front Raise", number: 23)
    }
}
