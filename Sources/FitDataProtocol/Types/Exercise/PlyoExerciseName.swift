//
//  PlyoExerciseName.swift
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

/// Plyo Exercise Name
public struct PlyoExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = PlyoExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension PlyoExerciseName: Hashable {

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
    public static func == (lhs: PlyoExerciseName, rhs: PlyoExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension PlyoExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [PlyoExerciseName] {

        return [.alternatingJumpLunge,
                .weightedAlternatingJumpLunge,
                .barbellJumpSquat,
                .bodyWeightJumpSquat,
                .weightedJumpSquat,
                .crossKneeStrike,
                .weightedCrossKneeStrike,
                .depthJump,
                .weightedDepthJump,
                .dumbbellJumpSquat,
                .dumbbellSplitJump,
                .frontKneeStrike,
                .weightedFrontKneeStrike,
                .highBoxJump,
                .weightedHighBoxJump,
                .isometricExplosiveBodyWeightJumpSquat,
                .weightedIsometricExplosiveJumpSquat,
                .lateralLeapHop,
                .weightedLateralLeapHop,
                .lateralPlyoSquats,
                .weightedLateralPlyoSquats,
                .lateralSlide,
                .weightedLateralSlide,
                .medicineBallOverheadThrows,
                .medicineBallSideThrow,
                .medicineBallSlam,
                .sideToSideMedicineBallThrows,
                .sideToSideShuffleJump,
                .weightedSideToSideShuffleJump,
                .squatJumpOntoBox,
                .weightedSquatJumpOntoBox,
                .squatJumpsInOut,
                .weightedSquatJumpsInOut
        ]
    }
}

public extension PlyoExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> PlyoExerciseName? {

        for name in PlyoExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension PlyoExerciseName {

    /// Alternating Jump Lunge
    public static var alternatingJumpLunge: PlyoExerciseName {
        return PlyoExerciseName(name: "Alternating Jump Lunge", number: 0)
    }

    /// Weighted Alternating Jump Lunge
    public static var weightedAlternatingJumpLunge: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Alternating Jump Lunge", number: 1)
    }

    /// Barbell Jump Squat
    public static var barbellJumpSquat: PlyoExerciseName {
        return PlyoExerciseName(name: "Barbell Jump Squat", number: 2)
    }

    /// Body Weight Jump Squat
    public static var bodyWeightJumpSquat: PlyoExerciseName {
        return PlyoExerciseName(name: "Body Weight Jump Squat", number: 3)
    }

    /// Weighted Jump Squat
    public static var weightedJumpSquat: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Jump Squat", number: 4)
    }

    /// Cross Knee Strike
    public static var crossKneeStrike: PlyoExerciseName {
        return PlyoExerciseName(name: "Cross Knee Strike", number: 5)
    }

    /// Weighted Cross Knee Strike
    public static var weightedCrossKneeStrike: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Cross Knee Strike", number: 6)
    }

    /// Depth Jump
    public static var depthJump: PlyoExerciseName {
        return PlyoExerciseName(name: "Depth Jump", number: 7)
    }

    /// Weighted Depth Jump
    public static var weightedDepthJump: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Depth Jump", number: 8)
    }

    /// Dumbbell Jump Squat
    public static var dumbbellJumpSquat: PlyoExerciseName {
        return PlyoExerciseName(name: "Dumbbell Jump Squat", number: 9)
    }

    /// Dumbbell Split Jump
    public static var dumbbellSplitJump: PlyoExerciseName {
        return PlyoExerciseName(name: "Dumbbell Split Jump", number: 10)
    }

    /// Front Knee Strike
    public static var frontKneeStrike: PlyoExerciseName {
        return PlyoExerciseName(name: "Front Knee Strike", number: 11)
    }

    /// Weighted Front Knee Strike
    public static var weightedFrontKneeStrike: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Front Knee Strike", number: 12)
    }

    /// High Box Jump
    public static var highBoxJump: PlyoExerciseName {
        return PlyoExerciseName(name: "High Box Jump", number: 13)
    }

    /// Weighted High Box Jump
    public static var weightedHighBoxJump: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted High Box Jump", number: 14)
    }

    /// Isometric Explosive Body Weight Jump Squat
    public static var isometricExplosiveBodyWeightJumpSquat: PlyoExerciseName {
        return PlyoExerciseName(name: "Isometric Explosive Body Weight Jump Squat", number: 15)
    }

    /// Weighted Isometric Explosive Jump Squat
    public static var weightedIsometricExplosiveJumpSquat: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Isometric Explosive Jump Squat", number: 16)
    }

    /// Lateral Leap and Hop
    public static var lateralLeapHop: PlyoExerciseName {
        return PlyoExerciseName(name: "Lateral Leap and Hop", number: 17)
    }

    /// Weighted Lateral Leap and Hop
    public static var weightedLateralLeapHop: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Lateral Leap and Hop", number: 18)
    }

    /// Lateral Plyo Squats
    public static var lateralPlyoSquats: PlyoExerciseName {
        return PlyoExerciseName(name: "Lateral Plyo Squats", number: 19)
    }

    /// Weighted Lateral Plyo Squats
    public static var weightedLateralPlyoSquats: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Lateral Plyo Squats", number: 20)
    }

    /// Lateral Slide
    public static var lateralSlide: PlyoExerciseName {
        return PlyoExerciseName(name: "Lateral Slide", number: 21)
    }

    /// Weighted Lateral Slide
    public static var weightedLateralSlide: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Lateral Slide", number: 22)
    }

    /// Medicine Ball Overhead Throws
    public static var medicineBallOverheadThrows: PlyoExerciseName {
        return PlyoExerciseName(name: "Medicine Ball Overhead Throws", number: 23)
    }

    /// Medicine Ball Side Throw
    public static var medicineBallSideThrow: PlyoExerciseName {
        return PlyoExerciseName(name: "Medicine Ball Side Throw", number: 24)
    }

    /// Medicine Ball Slam
    public static var medicineBallSlam: PlyoExerciseName {
        return PlyoExerciseName(name: "Medicine Ball Slam", number: 25)
    }

    /// Side to Side Medicine Ball Throws
    public static var sideToSideMedicineBallThrows: PlyoExerciseName {
        return PlyoExerciseName(name: "Side to Side Medicine Ball Throws", number: 26)
    }

    /// Side to Side Shuffle Jump
    public static var sideToSideShuffleJump: PlyoExerciseName {
        return PlyoExerciseName(name: "Side to Side Shuffle Jump", number: 27)
    }

    /// Weighted Side to Side Shuffle Jump
    public static var weightedSideToSideShuffleJump: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Side to Side Shuffle Jump", number: 28)
    }

    /// Squat Jump Onto Box
    public static var squatJumpOntoBox: PlyoExerciseName {
        return PlyoExerciseName(name: "Squat Jump Onto Box", number: 29)
    }

    /// Weighted Squat Jump Onto Box
    public static var weightedSquatJumpOntoBox: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Squat Jump Onto Box", number: 30)
    }

    /// Squat Jumps In and Out
    public static var squatJumpsInOut: PlyoExerciseName {
        return PlyoExerciseName(name: "Squat Jumps In and Out", number: 31)
    }

    /// Weighted Squat Jumps In and Out
    public static var weightedSquatJumpsInOut: PlyoExerciseName {
        return PlyoExerciseName(name: "Weighted Squat Jumps In and Out", number: 32)
    }
}
