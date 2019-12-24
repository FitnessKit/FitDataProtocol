//
//  SitUpExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/19.
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

/// Sit Up Exercise Name
public struct SitUpExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = SitUpExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .sitUp }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension SitUpExerciseName: Hashable {}

public extension SitUpExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [SitUpExerciseName] {

        return [.alternatingSitUp,
                .weightedAlternatingSitUp,
                .bentKneeVUp,
                .weightedBentKneeVUp,
                .butterflySitUp,
                .weightedButterflySitUp,
                .crossPunchRollUp,
                .weightedCrossPunchRollUp,
                .crossedArmsSitUp,
                .weightedCrossedArmsSitUp,
                .getUpSitUp,
                .weightedGetUpSitUp,
                .hoveringSitUp,
                .weightedHoveringSitUp,
                .kettlebellSitUp,
                .medicineBallAlternatingVUp,
                .medicineBallSitUp,
                .medicineBallVUp,
                .modifiedSitUp,
                .negativeSitUp,
                .oneArmFullSitUp,
                .weightedRecliningCircle,
                .reverseCurlUp,
                .weightedReverseCurlUp,
                .singleLegSwissBallJackknife,
                .weightedSingleLegSwissBallJackknife,
                .theTeaser,
                .theTeaserWeighted,
                .threePartRollDown,
                .weightedThreePartRollDown,
                .vUp,
                .weightedVUp,
                .weightedRussianTwistOnSwissBall,
                .weightedSitUp,
                .xAbs,
                .weightedXAbs,
                .sitUp
        ]
    }
}

public extension SitUpExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> SitUpExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension SitUpExerciseName {

    /// Alternating Sit Up
    static var alternatingSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Alternating Sit Up", number: 0)
    }

    /// Weighted Alternating Sit Up
    static var weightedAlternatingSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Alternating Sit Up", number: 1)
    }

    /// Bent Knee V Up
    static var bentKneeVUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Bent Knee V Up", number: 2)
    }

    /// Weighted Bent Knee V Up
    static var weightedBentKneeVUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Bent Knee V Up", number: 3)
    }

    /// Butterfly Sit Up
    static var butterflySitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Butterfly Sit Up", number: 4)
    }

    /// Weighted Butterfly Sit Up
    static var weightedButterflySitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Butterfly Sit Up", number: 5)
    }

    /// Cross Punch Roll Up
    static var crossPunchRollUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Cross Punch Roll Up", number: 6)
    }

    /// Weighted Cross Punch Roll Up
    static var weightedCrossPunchRollUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Cross Punch Roll Up", number: 7)
    }

    /// Crossed Arms Sit Up
    static var crossedArmsSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Crossed Arms Sit Up", number: 8)
    }

    /// Weighted Crossed Arms Sit Up
    static var weightedCrossedArmsSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Crossed Arms Sit Up", number: 9)
    }

    /// Get Up Sit Up
    static var getUpSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Get Up Sit Up", number: 10)
    }

    /// Weighted Get Up Sit Up
    static var weightedGetUpSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Get Up Sit Up", number: 11)
    }

    /// Hovering Sit Up
    static var hoveringSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Hovering Sit Up", number: 12)
    }

    /// Weighted Hovering Sit Up
    static var weightedHoveringSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Hovering Sit Up", number: 13)
    }

    /// Kettlebell Sit Up
    static var kettlebellSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Kettlebell Sit Up", number: 14)
    }

    /// Medicine Ball Alternating V Up
    static var medicineBallAlternatingVUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Medicine Ball Alternating V Up", number: 15)
    }

    /// Medicine Ball Sit Up
    static var medicineBallSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Medicine Ball Sit Up", number: 16)
    }

    /// Medicine Ball V Up
    static var medicineBallVUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Medicine Ball V Up", number: 17)
    }

    /// Modified Sit Up
    static var modifiedSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Modified Sit Up", number: 18)
    }

    /// Negative Sit Up
    static var negativeSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Negative Sit Up", number: 19)
    }

    /// One Arm Full Sit Up
    static var oneArmFullSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "One Arm Full Sit Up", number: 20)
    }

    /// Reclining Circle
    static var recliningCircle: SitUpExerciseName {
        return SitUpExerciseName(name: "Reclining Circle", number: 21)
    }

    /// Weighted Reclining Circle
    static var weightedRecliningCircle: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Reclining Circle", number: 22)
    }

    /// Reverse Curl Up
    static var reverseCurlUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Reverse Curl Up", number: 23)
    }

    /// Weighted Reverse Curl Up
    static var weightedReverseCurlUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Reverse Curl Up", number: 24)
    }

    /// Single Leg Swiss Ball Jackknife
    static var singleLegSwissBallJackknife: SitUpExerciseName {
        return SitUpExerciseName(name: "Single Leg Swiss Ball Jackknife", number: 25)
    }

    /// Weighted Single Leg Swiss Ball Jackknife
    static var weightedSingleLegSwissBallJackknife: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Single Leg Swiss Ball Jackknife", number: 26)
    }

    /// The Teaser
    static var theTeaser: SitUpExerciseName {
        return SitUpExerciseName(name: "The Teaser", number: 27)
    }

    /// The Teaser Weighted
    static var theTeaserWeighted: SitUpExerciseName {
        return SitUpExerciseName(name: "The Teaser Weighted", number: 28)
    }

    /// Three Part Roll Down
    static var threePartRollDown: SitUpExerciseName {
        return SitUpExerciseName(name: "Three Part Roll Down", number: 29)
    }

    /// Weighted Three Part Roll Down
    static var weightedThreePartRollDown: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Three Part Roll Down", number: 30)
    }

    /// V Up
    static var vUp: SitUpExerciseName {
        return SitUpExerciseName(name: "V Up", number: 31)
    }

    /// Weighted V Up
    static var weightedVUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted V Up", number: 32)
    }

    /// Weighted Russian Twist on Swiss Ball
    static var weightedRussianTwistOnSwissBall: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Russian Twist on Swiss Ball", number: 33)
    }

    /// Weighted Sit Up
    static var weightedSitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted Sit Up", number: 34)
    }

    /// X Abs
    static var xAbs: SitUpExerciseName {
        return SitUpExerciseName(name: "X Abs", number: 35)
    }

    /// Weighted X Abs
    static var weightedXAbs: SitUpExerciseName {
        return SitUpExerciseName(name: "Weighted X Abs", number: 36)
    }

    /// Sit Up
    static var sitUp: SitUpExerciseName {
        return SitUpExerciseName(name: "Sit Up", number: 37)
    }
}
