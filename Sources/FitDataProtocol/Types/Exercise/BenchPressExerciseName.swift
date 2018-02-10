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

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}


public extension BenchPressExerciseName {

    public static func create(from: UInt16) -> BenchPressExerciseName? {

        switch from {
        case 0:
            return .alternatingDumbellChestPressOnSwissBall
        case 1:
            return .barbellBenchPress
        case 2:
            return .barbellBoardBenchPress
        case 3:
            return .barbellFloorPress
        case 4:
            return .closeGripBarbellBenchPress
        case 5:
            return .declineDumbellBenchPress
        case 6:
            return .dumbellBenchPress
        case 7:
            return .dumbellFloorPress
        case 8:
            return .inclineBarbellBenchPress
        case 9:
            return .inclineDumbellBenchPress
        case 10:
            return .inclineSmithMachineBenchPress
        case 11:
            return .isometricBarbellBenchPress
        case 12:
            return .kettlebellChestPress
        case 13:
            return .neutralGripDumbellBenchPress
        case 14:
            return .neutralGripDumbellInclineBenchPress
        case 15:
            return .oneArmFloorPress
        case 16:
            return .weightedOneArmFloorPress
        case 17:
            return .partialLockout
        case 18:
            return .reverseGripBarbellBenchPress
        case 19:
            return .reverseGripInclineBenchPress
        case 20:
            return .singleArmCableChestPress
        case 21:
            return .singleArmDumbellBenchPress
        case 22:
            return .smithMachineBenchPress
        case 23:
            return .swissBallDumbellChestPress
        case 24:
            return .tripleStopBarbellBenchPress
        case 25:
            return .wideGripBarbellBenchPress
        case 26:
            return .alternatingDumbellChestPress

        default:
            return nil
        }
    }

}

// MARK: - Exercise Types
public extension BenchPressExerciseName {

    /// Alternating Dumbell and Chest Press on Swiss Ball
    public static var alternatingDumbellChestPressOnSwissBall: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Alternating Dumbell and Chest Press on Swiss Ball", number: 0)
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

    /// Decline Dumbell Bench Press
    public static var declineDumbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Decline Dumbell Bench Press", number: 5)
    }

    /// Dumbell Bench Press
    public static var dumbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Dumbell Bench Press", number: 6)
    }

    /// Dumbell Floor Press
    public static var dumbellFloorPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Dumbell Floor Press", number: 7)
    }

    /// Incline Barbell Bench Press
    public static var inclineBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Incline Barbell Bench Press", number: 8)
    }

    /// Incline Dumbell Bench Press
    public static var inclineDumbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Incline Dumbell Bench Press", number: 9)
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

    /// Neutral Grip Dumbell Bench Press
    public static var neutralGripDumbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Neutral Grip Dumbell Bench Press", number: 13)
    }

    /// Neutral Grip Dumbell Incline Bench Press
    public static var neutralGripDumbellInclineBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Neutral Grip Dumbell Incline Bench Press", number: 14)
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

    /// Single Arm Dumbell Bench Press
    public static var singleArmDumbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Single Arm Dumbell Bench Press", number: 21)
    }

    /// Smith Machine Bench Press
    public static var smithMachineBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Smith Machine Bench Press", number: 22)
    }

    /// Swiss Ball Dumbell Chest Press
    public static var swissBallDumbellChestPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Swiss Ball Dumbell Chest Press", number: 23)
    }

    /// Triple Stop Barbell Bench Press
    public static var tripleStopBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Triple Stop Barbell Bench Press", number: 24)
    }

    /// Wide Grip Barbell Bench Press
    public static var wideGripBarbellBenchPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Wide Grip Barbell Bench Press", number: 25)
    }

    /// Alternating Dumbell and Chest Press
    public static var alternatingDumbellChestPress: BenchPressExerciseName {
        return BenchPressExerciseName(name: "Alternating Dumbell and Chest Press", number: 26)
    }

}
