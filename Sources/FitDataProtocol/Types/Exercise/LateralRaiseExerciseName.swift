//
//  LateralRaiseExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/18/18.
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

/// Lateral Raise Exercise Name
public struct LateralRaiseExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = LateralRaiseExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension LateralRaiseExerciseName: Hashable {

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
    public static func == (lhs: LateralRaiseExerciseName, rhs: LateralRaiseExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension LateralRaiseExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [LateralRaiseExerciseName] {

        return [.fortyFiveDegreeCableExternalRotation,
                .alternatingLateralRaiseWithStaticHold,
                .barMuscleUp,
                .bentOverLateralRaise,
                .cableDiagonalRaise,
                .cableFrontRaise,
                .calorieRow,
                .comboShoulderRaise,
                .dumbbellDiagonalRaise,
                .dumbbellVRaise,
                .frontRaise,
                .leaningDumbbellLateralRaise,
                .lyingDumbbellRaise,
                .muscleUp,
                .oneArmCableLateralRaise,
                .overhandGripRearLateralRaise,
                .plateRaises,
                .ringDip,
                .weightedRingDip,
                .ringMuscleUp,
                .weightedRingMuscleUp,
                .ropeClimb,
                .weightedRopeClimb,
                .scaption,
                .seatedLateralRaise,
                .seatedRearLateralRaise,
                .sideLyingLatralRaise,
                .standingLift,
                .suspendedRow,
                .underhandGripRearLateralRaise,
                .wallSlide,
                .weightedWallSlide
        ]
    }
}

public extension LateralRaiseExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> LateralRaiseExerciseName? {

        for name in LateralRaiseExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension LateralRaiseExerciseName {

    /// 45 Degree Cable External Rotation
    public static var fortyFiveDegreeCableExternalRotation: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "45 Degree Cable External Rotation", number: 0)
    }

    /// Alternating Lteral Raise with Static Hold
    public static var alternatingLateralRaiseWithStaticHold: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Alternating Lteral Raise with Static Hold", number: 1)
    }

    /// Bar Muscle Up
    public static var barMuscleUp: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Bar Muscle Up", number: 2)
    }

    /// Bent Over Lateral Raise
    public static var bentOverLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Bent Over Lateral Raise", number: 3)
    }

    /// Cable Diagonal Raise
    public static var cableDiagonalRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Cable Diagonal Raise", number: 4)
    }

    /// Cable Front Raise
    public static var cableFrontRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Cable Front Raise", number: 5)
    }

    /// Calorie Row
    public static var calorieRow: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Calorie Row", number: 6)
    }

    /// Combo Shoulder Raise
    public static var comboShoulderRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Combo Shoulder Raise", number: 7)
    }

    /// Dumbbell Diagonal Raise
    public static var dumbbellDiagonalRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Dumbbell Diagonal Raise", number: 8)
    }

    /// Dumbbell V Raise
    public static var dumbbellVRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Dumbbell V Raise", number: 9)
    }

    /// Front Raise
    public static var frontRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Front Raise", number: 10)
    }

    /// Leaning Dumbbell Lateral Raise
    public static var leaningDumbbellLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Leaning Dumbbell Lateral Raise", number: 11)
    }

    /// Lying Dumbbell Raise
    public static var lyingDumbbellRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Lying Dumbbell Raise", number: 12)
    }

    /// Muscle Up
    public static var muscleUp: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Muscle Up", number: 13)
    }

    /// One Arm Cable Lateral Raise
    public static var oneArmCableLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "One Arm Cable Lateral Raise", number: 14)
    }

    /// Overhand Grip Rear Lateral Raise
    public static var overhandGripRearLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Overhand Grip Rear Lateral Raise", number: 15)
    }

    /// Plate Raises
    public static var plateRaises: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Plate Raises", number: 16)
    }

    /// Ring Dip
    public static var ringDip: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Ring Dip", number: 17)
    }

    /// Weighted Ring Dip
    public static var weightedRingDip: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Weighted Ring Dip", number: 18)
    }

    /// Ring Muscle Up
    public static var ringMuscleUp: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Ring Muscle Up", number: 19)
    }

    /// Weighted Ring Muscle Up
    public static var weightedRingMuscleUp: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Weighted Ring Muscle Up", number: 20)
    }

    /// Rope Climb
    public static var ropeClimb: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Rope Climb", number: 21)
    }

    /// Weighted Rope Climb
    public static var weightedRopeClimb: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Weighted Rope Climb", number: 22)
    }

    /// Scaption
    public static var scaption: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Scaption", number: 23)
    }

    /// Seated Lateral Raise
    public static var seatedLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Seated Lateral Raise", number: 24)
    }

    /// Seated Rear Lateral Raise
    public static var seatedRearLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Seated Rear Lateral Raise", number: 25)
    }

    /// Side Lying Lateral Raise
    public static var sideLyingLatralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Side Lying Lateral Raise", number: 26)
    }

    /// Standing Lift
    public static var standingLift: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Standing Lift", number: 27)
    }

    /// Suspended Row
    public static var suspendedRow: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Suspended Row", number: 28)
    }

    /// Underhand Grip Rear Lateral Raise
    public static var underhandGripRearLateralRaise: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Underhand Grip Rear Lateral Raise", number: 29)
    }

    /// Wall Slide
    public static var wallSlide: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Wall Slide", number: 30)
    }

    /// Weighted Wall Slide
    public static var weightedWallSlide: LateralRaiseExerciseName {
        return LateralRaiseExerciseName(name: "Weighted Wall Slide", number: 31)
    }
}
