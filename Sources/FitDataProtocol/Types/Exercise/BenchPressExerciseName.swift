//
//  BenchPressExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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


/// Bench Press Exercise Name
public struct BenchPressExerciseName: ExerciseName {
    public typealias ExerciseNameType = BenchPressExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}


extension BenchPressExerciseName: Hashable {
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    public static func ==(lhs: BenchPressExerciseName, rhs: BenchPressExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension BenchPressExerciseName {
    
    public static var supportedExerciseNames: [BenchPressExerciseName] {
        return [
            .alternatingDumbbellChestPressOnSwissBall,
            .barbellBenchPress,
            .barbellBoardBenchPress,
            .barbellFloorPress,
            .closeGripBarbellBenchPress,
            .declineDumbbellBenchPress,
            .dumbbellBenchPress,
            .dumbbellFloorPress,
            .inclineBarbellBenchPress,
            .inclineDumbbellBenchPress,
            .inclineSmithMachineBenchPress,
            .isometricBarbellBenchPress,
            .kettlebellChestPress,
            .neutralGripDumbbellBenchPress,
            .neutralGripDumbbellInclineBenchPress,
            .oneArmFloorPress,
            .weightedOneArmFloorPress,
            .partialLockout,
            .reverseGripBarbellBenchPress,
            .reverseGripInclineBenchPress,
            .singleArmCableChestPress,
            .singleArmDumbbellBenchPress,
            .smithMachineBenchPress,
            .swissBallDumbbellChestPress,
            .tripleStopBarbellBenchPress,
            .wideGripBarbellBenchPress,
            .alternatingDumbbellChestPress,
        ]
    }
}

public extension BenchPressExerciseName {

    public static func create(rawValue: UInt16) -> BenchPressExerciseName? {

        for name in BenchPressExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }

}

// MARK: - Exercise Types
public extension BenchPressExerciseName {

    /// Alternating Dumbbell and Chest Press on Swiss Ball
    public static var alternatingDumbbellChestPressOnSwissBall: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Alternating Dumbbell and Chest Press on Swiss Ball", number: 0)
    }

    /// Barbell Bench Press
    public static var barbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Barbell Bench Press", number: 1)
    }

    /// Barbell Board Bench Press
    public static var barbellBoardBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Barbell Board Bench Press", number: 2)
    }

    /// Barbell Floor Press
    public static var barbellFloorPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Barbell Floor Press", number: 3)
    }

    /// Close Grip Barbell Bench Press
    public static var closeGripBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Close Grip Barbell Bench Press", number: 4)
    }

    /// Decline Dumbbell Bench Press
    public static var declineDumbbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Decline Dumbbell Bench Press", number: 5)
    }

    /// Dumbbell Bench Press
    public static var dumbbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Dumbbell Bench Press", number: 6)
    }

    /// Dumbbell Floor Press
    public static var dumbbellFloorPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Dumbbell Floor Press", number: 7)
    }

    /// Incline Barbell Bench Press
    public static var inclineBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Incline Barbell Bench Press", number: 8)
    }

    /// Incline Dumbbell Bench Press
    public static var inclineDumbbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Incline Dumbbell Bench Press", number: 9)
    }

    /// Incline Smith Machine Bench Press
    public static var inclineSmithMachineBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Incline Smith Machine Bench Press", number: 10)
    }

    /// Isometric Barbell Bench Press
    public static var isometricBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Isometric Barbell Bench Press", number: 11)
    }

    /// Kettlebell Chest Press
    public static var kettlebellChestPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Kettlebell Chest Press", number: 12)
    }

    /// Neutral Grip Dumbbell Bench Press
    public static var neutralGripDumbbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Neutral Grip Dumbbell Bench Press", number: 13)
    }

    /// Neutral Grip Dumbbell Incline Bench Press
    public static var neutralGripDumbbellInclineBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Neutral Grip Dumbbell Incline Bench Press", number: 14)
    }

    /// One Arm Floor Press
    public static var oneArmFloorPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "One Arm Floor Press", number: 15)
    }

    /// Weighted One Arm Floor Press
    public static var weightedOneArmFloorPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Weighted One Arm Floor Press", number: 16)
    }

    /// Partial Lockout
    public static var partialLockout: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Partial Lockout", number: 17)
    }

    /// Reverse Grip Barbell Bench Press
    public static var reverseGripBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Reverse Grip Barbell Bench Press", number: 18)
    }

    /// Reverse Grip Incline Bench Press
    public static var reverseGripInclineBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Reverse Grip Incline Bench Press", number: 19)
    }

    /// Single Arm Cable Chest Press
    public static var singleArmCableChestPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Single Arm Cable Chest Press", number: 20)
    }

    /// Single Arm Dumbbell Bench Press
    public static var singleArmDumbbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Single Arm Dumbbell Bench Press", number: 21)
    }

    /// Smith Machine Bench Press
    public static var smithMachineBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Smith Machine Bench Press", number: 22)
    }

    /// Swiss Ball Dumbbell Chest Press
    public static var swissBallDumbbellChestPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Swiss Ball Dumbbell Chest Press", number: 23)
    }

    /// Triple Stop Barbell Bench Press
    public static var tripleStopBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Triple Stop Barbell Bench Press", number: 24)
    }

    /// Wide Grip Barbell Bench Press
    public static var wideGripBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Wide Grip Barbell Bench Press", number: 25)
    }

    /// Alternating Dumbbell and Chest Press
    public static var alternatingDumbbellChestPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Alternating Dumbbell and Chest Press", number: 26)
    }

}
