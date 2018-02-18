//
//  HipStabilityExerciseName.swift
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


/// Hip Stability Exercise Name
public struct HipStabilityExerciseName: ExerciseName {
    public typealias ExerciseNameType = HipStabilityExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension HipStabilityExerciseName: Hashable {
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    public static func ==(lhs: HipStabilityExerciseName, rhs: HipStabilityExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}


public extension HipStabilityExerciseName {

    public static var supportedExerciseNames: [HipStabilityExerciseName] {

        return [.bandSideLyingLegRaise,
                .deadBug,
                .weightedDeadBug,
                .externalHipRaise,
                .weightedExternalHipRaise,
                .fireHydrantKicks,
                .weightedFireHydrantKicks,
                .hipCircles,
                .weightedHipCircles,
                .innerThighLift,
                .weightedInnerThighLift,
                .lateralWalksWithBandAtAnkles,
                .pretzelSideKick,
                .weightedPretzelSideKick,
                .proneHipInternalRotation,
                .weightedProneHipInternalRotation,
                .quadruped,
                .quadrupedHipExtension,
                .weightedQuadrupedHipExtension,
                .quadrupedWithLegLift,
                .weightedQuadrupedWithLegLift,
                .sideLyingLegRaise,
                .weightedSideLyingLegRaise,
                .slidingHipAdduction,
                .weightedSlidingHipAdduction,
                .standingAdduction,
                .weightedStandingAdduction,
                .standingCableHipAbduction,
                .standingHipAbduction,
                .weightedStandingHipAbduction,
                .standingRearLegRaise,
                .weightedStandingRearLegRaise,
                .supineHipInternalRotation,
                .weightedSupineHipInternalRotation
        ]
    }
}

public extension HipStabilityExerciseName {

    public static func create(rawValue: UInt16) -> HipStabilityExerciseName? {

        for name in HipStabilityExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension HipStabilityExerciseName {

    /// Band Side Lying Leg Raise
    public static var bandSideLyingLegRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Band Side Lying Leg Raise", number: 0)
    }

    /// Dead Bug
    public static var deadBug: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Dead Bug", number: 1)
    }

    /// Weighted Dead Bug
    public static var weightedDeadBug: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Dead Bug", number: 2)
    }

    /// External Hip Raise
    public static var externalHipRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "External Hip Raise", number: 3)
    }

    /// Weighted External Hip Raise
    public static var weightedExternalHipRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted External Hip Raise", number: 4)
    }

    /// Fire Hydrant Kicks
    public static var fireHydrantKicks: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Fire Hydrant Kicks", number: 5)
    }

    /// Weighted Fire Hydrant Kicks
    public static var weightedFireHydrantKicks: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Fire Hydrant Kicks", number: 6)
    }

    /// Hip Circles
    public static var hipCircles: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Hip Circles", number: 7)
    }

    /// Weighted Hip Circles
    public static var weightedHipCircles: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Hip Circles", number: 8)
    }

    /// Inner Thigh Lift
    public static var innerThighLift: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Inner Thigh Lift", number: 9)
    }

    /// Weighted Inner Thigh Lift
    public static var weightedInnerThighLift: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Inner Thigh Lift", number: 10)
    }

    /// Lateral Walks with Band at Ankles
    public static var lateralWalksWithBandAtAnkles: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Lateral Walks with Band at Ankles", number: 11)
    }

    /// Pretzel Side Kick
    public static var pretzelSideKick: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Pretzel Side Kick", number: 12)
    }

    /// Weighted Pretzel Side Kick
    public static var weightedPretzelSideKick: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Pretzel Side Kick", number: 13)
    }

    /// Prone Hip Internal Rotation
    public static var proneHipInternalRotation: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Prone Hip Internal Rotation", number: 14)
    }

    /// Weighted Prone Hip Internal Rotation
    public static var weightedProneHipInternalRotation: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Prone Hip Internal Rotation", number: 15)
    }

    /// Quadruped
    public static var quadruped: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Quadruped", number: 16)
    }

    /// Quadruped Hip Extension
    public static var quadrupedHipExtension: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Quadruped Hip Extension", number: 17)
    }

    /// Weighted Quadruped Hip Extension
    public static var weightedQuadrupedHipExtension: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Quadruped Hip Extension", number: 18)
    }

    /// Quadruped with Leg Lift
    public static var quadrupedWithLegLift: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Quadruped with Leg Lift", number: 19)
    }

    /// Weighted Quadruped with Leg Lift
    public static var weightedQuadrupedWithLegLift: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Quadruped with Leg Lift", number: 20)
    }

    /// Side Lying Leg Raise
    public static var sideLyingLegRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Side Lying Leg Raise", number: 21)
    }

    /// Weighted Side Lying Leg Raise
    public static var weightedSideLyingLegRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Side Lying Leg Raise", number: 22)
    }

    /// Sliding Hip Adduction
    public static var slidingHipAdduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Sliding Hip Adduction", number: 23)
    }

    /// Weighted Sliding Hip Adduction
    public static var weightedSlidingHipAdduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Sliding Hip Adduction", number: 24)
    }

    /// Standing Adduction
    public static var standingAdduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Standing Adduction", number: 25)
    }

    /// Weighted Standing Adduction
    public static var weightedStandingAdduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Standing Adduction", number: 26)
    }

    /// Standing Cable Hip Abduction
    public static var standingCableHipAbduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Standing Cable Hip Abduction", number: 27)
    }

    /// Standing Hip Abduction
    public static var standingHipAbduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Standing Hip Abduction", number: 28)
    }

    /// Weighted Standing Hip Abduction
    public static var weightedStandingHipAbduction: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Standing Hip Abduction", number: 29)
    }

    /// Standing Rear Leg Raise
    public static var standingRearLegRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Standing Rear Leg Raise", number: 30)
    }

    /// Weighted Standing Rear Leg Raise
    public static var weightedStandingRearLegRaise: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Standing Rear Leg Raise", number: 31)
    }

    /// Supine Hip Internal Rotation
    public static var supineHipInternalRotation: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Supine Hip Internal Rotation", number: 32)
    }

    /// Weighted Supine Hip Internal Rotation
    public static var weightedSupineHipInternalRotation: HipStabilityExerciseName {
        return HipStabilityExerciseName(name: "Weighted Supine Hip Internal Rotation", number: 33)
    }
}
