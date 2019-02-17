//
//  LungeExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/17/19.
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

/// Lunge Exercise Name
public struct LungeExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = LungeExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension LungeExerciseName: Hashable {

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
    public static func == (lhs: LungeExerciseName, rhs: LungeExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension LungeExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [LungeExerciseName] {

        return [.overheadLunge,
                .lungeMatrix,
                .weightedLungeMatrix,
                .alternatingBarbellForwardLunge,
                .alternatingDumbbellForwardLunge,
                .backFootElevatedDumbbellSplitSquat,
                .barbellBoxLunge,
                .barbellBulgarianSplitSquat,
                .barbellCrossoverLunge,
                .barbellFrontSplitSquat,
                .barbellLunge,
                .barbellReverseLunge,
                .barbellSideLunge,
                .barbellSplitSquat,
                .coreControlRearLunge,
                .diagonalLunge,
                .dropLunge,
                .dumbellBoxLunge,
                .dumbellBulgarianSplitSquat,
                .dumbbellCrossoverLunge,
                .dumbbellDiagonalLunge,
                .dumbbellLunge,
                .dumbbellLungeRotation,
                .dumbbellOverheadBulgarianSplitSquat,
                .dumbbellReverseLungeHighKneePress,
                .elevatedFrontFootBarbellSplitSquat,
                .frontFootElevatedDumbbellSplitSquat,
                .lawnmowerLunge,
                .lowLungeIsometricAdduction,
                .lowSideToSideLunge,
                .lunge,
                .weightedLunge,
                .lungeArmReach,
                .lungeDiagonalReach,
                .lungeSideBend,
                .offsetDumbbellLunge,
                .offsetDumbbellReverseLunge,
                .overheadBulgarianSplitSquat,
                .overheadDumbbellReverseLunge,
                .overheadDumbbellSplitSquat,
                .overheadLungeRotation,
                .reverseBarbellBoxLunge,
                .reverseBoxLunge,
                .reverseDumbbellBoxLunge,
                .reverseDumbbellCrossoverLunge,
                .reverseDumbbellDiagonalLunge,
                .reverseLungReachBack,
                .weightedReverseLungReachBack,
                .reverseLungeTwistOverheadReach,
                .weightedReverseLungeTwistOverheadReach,
                .reverseSlidingBoxLunge,
                .weightedReverseSlidingBoxLunge,
                .reverseSlidingLunge,
                .weightedReverseSlidingLunge,
                .runnersLungeBalance,
                .weightedRunnersLungeBalance,
                .shiftingSideLunge,
                .sideCrossoverLunge,
                .weightedSideCrossoverLunge,
                .sideLunge,
                .weightedSideLunge,
                .sideLungePress,
                .sideLungeJumpOff,
                .sideLungeSweep,
                .weightedSideLungeSweep,
                .sideLungeCrossoverTap,
                .weightedSideLungeCrossoverTap,
                .sideToSideLungeChops,
                .weightedSideToSideLungeChops,
                .siffJumpLunge,
                .weightedSiffJumpLunge,
                .singleArmReverseLungePress,
                .slidingLateralLunge,
                .weightedSlidingLateralLunge,
                .walkingBarbellLunge,
                .walkingDumbbellLunge,
                .walkingLunge,
                .weightedWalkingLunge,
                .wideGripOverheadBarbellSplitSquat
        ]
    }
}

public extension LungeExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> LungeExerciseName? {

        for name in LungeExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension LungeExerciseName {

    /// Overhead Lunge
    public static var overheadLunge: LungeExerciseName {
        return LungeExerciseName(name: "Overhead Lunge", number: 0)
    }

    /// Lunge Matrix
    public static var lungeMatrix: LungeExerciseName {
        return LungeExerciseName(name: "Lunge Matrix", number: 1)
    }

    /// Weighted Lunge Matrix
    public static var weightedLungeMatrix: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Lunge Matrix", number: 2)
    }

    /// Alternating Barbell Forward Lunge
    public static var alternatingBarbellForwardLunge: LungeExerciseName {
        return LungeExerciseName(name: "Alternating Barbell Forward Lunge", number: 3)
    }

    /// Alternating Dumbbell Forward Lunge
    public static var alternatingDumbbellForwardLunge: LungeExerciseName {
        return LungeExerciseName(name: "Alternating Dumbbell Forward Lunge", number: 4)
    }

    /// Back Foot Elevated Dumbbell Split Squat
    public static var backFootElevatedDumbbellSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Back Foot Elevated Dumbbell Split Squat", number: 5)
    }

    /// Barbell Box Lunge
    public static var barbellBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Box Lunge", number: 6)
    }

    /// Barbell Bulgarian Split Squat
    public static var barbellBulgarianSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Bulgarian Split Squat", number: 7)
    }

    /// Barbell Crossover Lunge
    public static var barbellCrossoverLunge: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Crossover Lunge", number: 8)
    }

    /// Barbell Front Split Squat
    public static var barbellFrontSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Front Split Squat", number: 9)
    }

    /// Barbell Lunge
    public static var barbellLunge: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Lunge", number: 10)
    }

    /// Barbell Reverse Lunge
    public static var barbellReverseLunge: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Reverse Lunge", number: 11)
    }

    /// Barbell Side Lunge
    public static var barbellSideLunge: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Side Lunge", number: 12)
    }

    /// Barbell Split Squat
    public static var barbellSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Barbell Split Squat", number: 13)
    }

    /// Core Control Rear Lunge
    public static var coreControlRearLunge: LungeExerciseName {
        return LungeExerciseName(name: "Core Control Rear Lunge", number: 14)
    }

    /// Diagonal Lunge
    public static var diagonalLunge: LungeExerciseName {
        return LungeExerciseName(name: "Diagonal Lunge", number: 15)
    }

    /// Drop Lunge
    public static var dropLunge: LungeExerciseName {
        return LungeExerciseName(name: "Drop Lunge", number: 16)
    }

    /// Dumbbell Box Lunge
    public static var dumbellBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Box Lunge", number: 17)
    }

    /// Dumbbell Bulgarian Split Squat
    public static var dumbellBulgarianSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Bulgarian Split Squat", number: 18)
    }

    /// Dumbbell Crossover Lunge
    public static var dumbbellCrossoverLunge: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Crossover Lunge", number: 19)
    }

    /// Dumbbell Diagonal Lunge
    public static var dumbbellDiagonalLunge: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Diagonal Lunge", number: 20)
    }

    /// Dumbbell Lunge
    public static var dumbbellLunge: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Lunge", number: 21)
    }

    /// Dumbbell Lunge and Rotation
    public static var dumbbellLungeRotation: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Lunge and Rotation", number: 22)
    }

    /// Dumbbell Overhead Bulgarian Split Squat
    public static var dumbbellOverheadBulgarianSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Overhead Bulgarian Split Squat", number: 23)
    }

    /// Dumbbell Reverse Lunge to High Knee and Press
    public static var dumbbellReverseLungeHighKneePress: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Reverse Lunge to High Knee and Press", number: 24)
    }

    /// Dumbbell Side Lunge
    public static var dumbbellSideLunge: LungeExerciseName {
        return LungeExerciseName(name: "Dumbbell Side Lunge", number: 25)
    }

    /// Elevated Front Foot Barbell Split Squat
    public static var elevatedFrontFootBarbellSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Elevated Front Foot Barbell Split Squat", number: 26)
    }

    /// Front Foot Elevated Dumbbell Split Squat
    public static var frontFootElevatedDumbbellSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Front Foot Elevated Dumbbell Split Squat", number: 27)
    }

    /// Gunslinger Lunge
    public static var gungslingerLunge: LungeExerciseName {
        return LungeExerciseName(name: "Gunslinger Lunge", number: 28)
    }

    /// Lawnmower Lunge
    public static var lawnmowerLunge: LungeExerciseName {
        return LungeExerciseName(name: "Lawnmower Lunge", number: 29)
    }

    /// Low Lunge with Isometric Adduction
    public static var lowLungeIsometricAdduction: LungeExerciseName {
        return LungeExerciseName(name: "Low Lunge with Isometric Adduction", number: 30)
    }

    /// Low Side to Side Lunge
    public static var lowSideToSideLunge: LungeExerciseName {
        return LungeExerciseName(name: "Low Side to Side Lunge", number: 31)
    }

    /// Lunge
    public static var lunge: LungeExerciseName {
        return LungeExerciseName(name: "Lunge", number: 32)
    }

    /// Weighted Lunge
    public static var weightedLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Lunge", number: 33)
    }

    /// Lunge with Arm Reach
    public static var lungeArmReach: LungeExerciseName {
        return LungeExerciseName(name: "Lunge with Arm Reach", number: 34)
    }

    /// Lunge with Diagonal Reach
    public static var lungeDiagonalReach: LungeExerciseName {
        return LungeExerciseName(name: "Lunge with Diagonal Reach", number: 35)
    }

    /// Lunge with Side Bend
    public static var lungeSideBend: LungeExerciseName {
        return LungeExerciseName(name: "Lunge with Side Bend", number: 36)
    }

    /// Offset Dumbbell Lunge
    public static var offsetDumbbellLunge: LungeExerciseName {
        return LungeExerciseName(name: "Offset Dumbbell Lunge", number: 37)
    }

    /// Offset Dumbbell Reverse Lunge
    public static var offsetDumbbellReverseLunge: LungeExerciseName {
        return LungeExerciseName(name: "Offset Dumbbell Reverse Lunge", number: 38)
    }

    /// Overhead Bulgarian Split Squat
    public static var overheadBulgarianSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Overhead Bulgarian Split Squat", number: 39)
    }

    /// Overhead Dumbbell Reverse Lunge
    public static var overheadDumbbellReverseLunge: LungeExerciseName {
        return LungeExerciseName(name: "Overhead Dumbbell Reverse Lunge", number: 40)
    }

    /// Overhead Dumbbell Split Squat
    public static var overheadDumbbellSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Overhead Dumbbell Split Squat", number: 41)
    }

    /// Overhead Lunge with Rotation
    public static var overheadLungeRotation: LungeExerciseName {
        return LungeExerciseName(name: "Overhead Lunge with Rotation", number: 42)
    }

    /// Reverse Barbell Box Lunge
    public static var reverseBarbellBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Barbell Box Lunge", number: 43)
    }

    /// Reverse Box Lunge
    public static var reverseBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Box Lunge", number: 44)
    }

    /// Reverse Dumbbell Box Lunge
    public static var reverseDumbbellBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Dumbbell Box Lunge", number: 45)
    }

    /// Reverse Dumbbell Crossover Lunge
    public static var reverseDumbbellCrossoverLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Dumbbell Crossover Lunge", number: 46)
    }

    /// Reverse Dumbbell Diagonal Lunge
    public static var reverseDumbbellDiagonalLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Dumbbell Diagonal Lunge", number: 47)
    }

    /// Reverse Lunge with Reach Back
    public static var reverseLungReachBack: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Lunge with Reach Back", number: 48)
    }

    /// Weighted Reverse Lunge with Reach Back
    public static var weightedReverseLungReachBack: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Reverse Lunge with Reach Back", number: 49)
    }

    /// Reverse Lunge with Twist and Overhead Reach
    public static var reverseLungeTwistOverheadReach: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Lunge with Twist and Overhead Reach", number: 50)
    }

    /// Weighted Reverse Lunge with Twist and Overhead Reach
    public static var weightedReverseLungeTwistOverheadReach: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Reverse Lunge with Twist and Overhead Reach", number: 51)
    }

    /// Reverse Sliding Box Lunge
    public static var reverseSlidingBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Sliding Box Lunge", number: 52)
    }

    /// Weighted Reverse Sliding Box Lunge
    public static var weightedReverseSlidingBoxLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Reverse Sliding Box Lunge", number: 53)
    }

    /// Reverse Sliding Lunge
    public static var reverseSlidingLunge: LungeExerciseName {
        return LungeExerciseName(name: "Reverse Sliding Lunge", number: 54)
    }

    /// Weighted Reverse Sliding Lunge
    public static var weightedReverseSlidingLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Reverse Sliding Lunge", number: 55)
    }

    /// Runners Lunge to Balance
    public static var runnersLungeBalance: LungeExerciseName {
        return LungeExerciseName(name: "Runners Lunge to Balance", number: 56)
    }

    /// Weighted Runners Lunge to Balance
    public static var weightedRunnersLungeBalance: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Runners Lunge to Balance", number: 57)
    }

    /// Shifting Side Lunge
    public static var shiftingSideLunge: LungeExerciseName {
        return LungeExerciseName(name: "Shifting Side Lunge", number: 58)
    }

    /// Side and Crossover Lunge
    public static var sideCrossoverLunge: LungeExerciseName {
        return LungeExerciseName(name: "Side and Crossover Lunge", number: 59)
    }

    /// Weighted Side and Crossover Lunge
    public static var weightedSideCrossoverLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Side and Crossover Lunge", number: 60)
    }

    /// Side Lunge
    public static var sideLunge: LungeExerciseName {
        return LungeExerciseName(name: "Side Lunge", number: 61)
    }

    /// Weighted Side Lunge
    public static var weightedSideLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Side Lunge", number: 62)
    }

    /// Side Lunge and Press
    public static var sideLungePress: LungeExerciseName {
        return LungeExerciseName(name: "Side Lunge and Press", number: 63)
    }

    /// Side Lunge Jump Off
    public static var sideLungeJumpOff: LungeExerciseName {
        return LungeExerciseName(name: "Side Lunge Jump Off", number: 64)
    }

    /// Side Lunge Sweep
    public static var sideLungeSweep: LungeExerciseName {
        return LungeExerciseName(name: "Side Lunge Sweep", number: 65)
    }

    /// Weighted Side Lunge Sweep
    public static var weightedSideLungeSweep: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Side Lunge Sweep", number: 66)
    }

    /// Side Lunge to Crossover Tap
    public static var sideLungeCrossoverTap: LungeExerciseName {
        return LungeExerciseName(name: "Side Lunge to Crossover Tap", number: 67)
    }

    /// Weighted Side Lunge to Crossover Tap
    public static var weightedSideLungeCrossoverTap: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Side Lunge to Crossover Tap", number: 68)
    }

    /// Side to Side Lunge Chops
    public static var sideToSideLungeChops: LungeExerciseName {
        return LungeExerciseName(name: "Side to Side Lunge Chops", number: 69)
    }

    /// Weighted Side to Side Lunge Chops
    public static var weightedSideToSideLungeChops: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Side to Side Lunge Chops", number: 70)
    }

    /// Siff Jump Lunge
    public static var siffJumpLunge: LungeExerciseName {
        return LungeExerciseName(name: "Siff Jump Lunge", number: 71)
    }

    /// Weighted Siff Jump Lunge
    public static var weightedSiffJumpLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Siff Jump Lunge", number: 72)
    }

    /// Single Arm Reverse Lunge and Press
    public static var singleArmReverseLungePress: LungeExerciseName {
        return LungeExerciseName(name: "Single Arm Reverse Lunge and Press", number: 73)
    }

    /// Sliding Lateral Lunge
    public static var slidingLateralLunge: LungeExerciseName {
        return LungeExerciseName(name: "Sliding Lateral Lunge", number: 74)
    }

    /// Weighted Sliding Lateral Lunge
    public static var weightedSlidingLateralLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Sliding Lateral Lunge", number: 75)
    }

    /// Walking Barbell Lunge
    public static var walkingBarbellLunge: LungeExerciseName {
        return LungeExerciseName(name: "Walking Barbell Lunge", number: 76)
    }

    /// Walking Dumbbell Lunge
    public static var walkingDumbbellLunge: LungeExerciseName {
        return LungeExerciseName(name: "Walking Dumbbell Lunge", number: 77)
    }

    /// Walking Lunge
    public static var walkingLunge: LungeExerciseName {
        return LungeExerciseName(name: "Walking Lunge", number: 78)
    }

    /// Weighted Walking Lunge
    public static var weightedWalkingLunge: LungeExerciseName {
        return LungeExerciseName(name: "Weighted Walking Lunge", number: 79)
    }

    /// Wide Grip Overhead Barbell Split Squat
    public static var wideGripOverheadBarbellSplitSquat: LungeExerciseName {
        return LungeExerciseName(name: "Wide Grip Overhead Barbell Split Squat", number: 80)
    }
}
