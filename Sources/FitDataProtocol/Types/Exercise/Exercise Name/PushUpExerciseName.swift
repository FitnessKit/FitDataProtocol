//
//  PushUpExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/14/19.
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

/// Push Up Exercise Name
public struct PushUpExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = PushUpExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .pushUp }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension PushUpExerciseName: Hashable {}

public extension PushUpExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [PushUpExerciseName] {

        return [.chestPressBand,
                .alternatingStaggeredPushUp,
                .weightedAlternatingStaggeredPushUp,
                .alternatingHandsMedicineBallPushUp,
                .weightedAlternatingHandsMedicineBallPushUp,
                .bosuBallPushUp,
                .weightedBosuBallPushUp,
                .clappingPushUp,
                .weightedClappingPushUp,
                .closeGripMedicineBallPushUp,
                .weightedCloseGripMedicineBallPushUp,
                .closeHandsPushUp,
                .weightedCloseHandsPushUp,
                .declinePushUp,
                .weightedDeclinePushUp,
                .diamondPushUp,
                .weightedDiamondPushUp,
                .explosiveCrossoverPushUp,
                .weightedExplosiveCrossoverPushUp,
                .explosivePushUp,
                .weightedExplosivePushUp,
                .feetElevatedSideToSidePushUp,
                .weightedFeetElevatedSideToSidePushUp,
                .handReleasePushUp,
                .weightedHandReleasePushUp,
                .handstandPushUp,
                .weightedHandstandPushUp,
                .inclinePushUp,
                .weightedInclinePushUp,
                .isometricExplosivePushUp,
                .weightedIsometricExplosivePushUp,
                .judoPushUp,
                .weightedJudoPushUp,
                .kneelingPushUp,
                .weightedKneelingPushUp,
                .medicineBallChestPass,
                .medicineBallPushUp,
                .weightedMedicineBallPushUp,
                .oneArmPushUp,
                .weightedOneArmPushUp,
                .weightedPushUp,
                .pushUpRow,
                .weightedPushUpRow,
                .pushUpPlus,
                .weightedPushUpPlus,
                .pushUpFeetOnSwissBall,
                .weightedPushUpFeetOnSwissBall,
                .pushUpOneHandOnMedicineBall,
                .weightedPushUpOneHandOnMedicineBall,
                .shoulderPushUp,
                .seightedShoulderPushUp,
                .singleArmMedicineBallPushUp,
                .weightedSingleArmMedicineBallPushUp,
                .spidermanPushUp,
                .weightedSpidermanPushUp,
                .stackedFeetPushUp,
                .weightedStackedFeetPushUp,
                .staggeredHandsPushUp,
                .weightedStaggeredHandsPushUp,
                .suspendedPushUp,
                .weightedSuspendedPushUp,
                .swissBallPushUp,
                .weightedSwissBallPushUp,
                .swissBallPushUpPlus,
                .weightedSwissBallPushUpPlus,
                .tPushUp,
                .weightedTPushUp,
                .tripleStopPushUp,
                .weightedTripleStopPushUp,
                .wideHandsPushUp,
                .weightedWideHandsPushUp,
                .paralletteHandstandPushUp,
                .weightedParalletteHandstandPushUp,
                .ringHandstandPushUp,
                .weightedRingHandstandPushUp,
                .ringPushUp,
                .weightedRingPushUp,
                .pushUp,
                .pilatesPushUp
        ]
    }
}

public extension PushUpExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> PushUpExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension PushUpExerciseName {

    /// Chest Press with Band
    static var chestPressBand: PushUpExerciseName {
        return PushUpExerciseName(name: "Chest Press with Band", number: 0)
    }

    /// Alternating Staggered Push Up
    static var alternatingStaggeredPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Alternating Staggered Push Up", number: 1)
    }

    /// Weighted Alternating Staggered Push Up
    static var weightedAlternatingStaggeredPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Alternating Staggered Push Up", number: 2)
    }

    /// Alternating Hands Medicine Ball Push Up
    static var alternatingHandsMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Alternating Hands Medicine Ball Push Up", number: 3)
    }

    /// Weighted Alternating Hands Medicine Ball Push Up
    static var weightedAlternatingHandsMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Alternating Hands Medicine Ball Push Up", number: 4)
    }

    /// Bosu Ball Push Up
    static var bosuBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Bosu Ball Push Up", number: 5)
    }

    /// Weighted Bosu Ball Push Up
    static var weightedBosuBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Bosu Ball Push Up", number: 6)
    }

    /// Clapping Push Up
    static var clappingPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Clapping Push Up", number: 7)
    }

    /// Weighted Clapping Push Up
    static var weightedClappingPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Clapping Push Up", number: 8)
    }

    /// Close Grip Medicine Ball Push Up
    static var closeGripMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Close Grip Medicine Ball Push Up", number: 9)
    }

    /// Weighted Close Grip Medicine Ball Push Up
    static var weightedCloseGripMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Close Grip Medicine Ball Push Up", number: 10)
    }

    /// Close Hands Push Up
    static var closeHandsPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Close Hands Push Up", number: 11)
    }

    /// Weighted Close Hands Push Up
    static var weightedCloseHandsPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Close Hands Push Up", number: 12)
    }

    /// Decline Push Up
    static var declinePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Decline Push Up", number: 13)
    }

    /// Weighted Decline Push Up
    static var weightedDeclinePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Decline Push Up", number: 14)
    }

    /// Diamond Push Up
    static var diamondPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Diamond Push Up", number: 15)
    }

    /// Weighted Diamond Push Up
    static var weightedDiamondPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Diamond Push Up", number: 16)
    }

    /// Explosive Crossover Push Up
    static var explosiveCrossoverPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Explosive Crossover Push Up", number: 17)
    }

    /// Weighted Explosive Crossover Push Up
    static var weightedExplosiveCrossoverPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Explosive Crossover Push Up", number: 18)
    }

    /// Explosive Push Up
    static var explosivePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Explosive Push Up", number: 19)
    }

    /// Weighted Explosive Push Up
    static var weightedExplosivePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Explosive Push Up", number: 20)
    }

    /// Feet Elevated Side to Side Push Up
    static var feetElevatedSideToSidePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Feet Elevated Side to Side Push Up", number: 21)
    }

    /// Weighted Feet Elevated Side to Side Push Up
    static var weightedFeetElevatedSideToSidePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Feet Elevated Side to Side Push Up", number: 22)
    }

    /// Hand Release Push Up
    static var handReleasePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Hand Release Push Up", number: 23)
    }

    /// Weighted Hand Release Push Up
    static var weightedHandReleasePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Hand Release Push Up", number: 24)
    }
    
    /// Handstand Push Up
    static var handstandPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Handstand Push Up", number: 25)
    }
    
    /// Weighted Handstand Push Up
    static var weightedHandstandPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Handstand Push Up", number: 26)
    }

    /// Incline Push Up
    static var inclinePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Incline Push Up", number: 27)
    }

    /// Weighted Incline Push Up
    static var weightedInclinePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Incline Push Up", number: 28)
    }
    
    /// Iosmetric Explosive Push Up
    static var isometricExplosivePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Iosmetric Explosive Push Up", number: 29)
    }

    /// Weighted Iosmetric Explosive Push Up
    static var weightedIsometricExplosivePushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Iosmetric Explosive Push Up", number: 30)
    }

    /// Judo Push Up
    static var judoPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Judo Push Up", number: 31)
    }

    /// Weighted Judo Push Up
    static var weightedJudoPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Judo Push Up", number: 32)
    }

    /// Kneeling Push Up
    static var kneelingPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Kneeling Push Up", number: 33)
    }

    /// Weighted Kneeling Push Up
    static var weightedKneelingPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Kneeling Push Up", number: 34)
    }

    /// Medicine Ball Chest Pass
    static var medicineBallChestPass: PushUpExerciseName {
        return PushUpExerciseName(name: "Medicine Ball Chest Pass", number: 35)
    }

    /// Medicine Ball Push Up
    static var medicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Medicine Ball Push Up", number: 36)
    }

    /// Weighted Medicine Ball Push Up
    static var weightedMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Medicine Ball Push Up", number: 37)
    }

    /// One Arm Push Up
    static var oneArmPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "One Arm Push Up", number: 38)
    }

    /// Weighted One Arm Push Up
    static var weightedOneArmPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted One Arm Push Up", number: 39)
    }

    /// Weighted Push Up
    static var weightedPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Push Up", number: 40)
    }

    /// Push Up and Row
    static var pushUpRow: PushUpExerciseName {
        return PushUpExerciseName(name: "Push Up and Row", number: 41)
    }

    /// Weighted Push Up and Row
    static var weightedPushUpRow: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Push Up and Row", number: 42)
    }

    /// Push Up Plus
    static var pushUpPlus: PushUpExerciseName {
        return PushUpExerciseName(name: "Push Up Plus", number: 43)
    }

    /// Weighted Push Up Plus
    static var weightedPushUpPlus: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Push Up Plus", number: 44)
    }

    /// Push Up with Feet on Swiss Ball
    static var pushUpFeetOnSwissBall: PushUpExerciseName {
        return PushUpExerciseName(name: "Push Up with Feet on Swiss Ball", number: 45)
    }

    /// Weighted Push Up with Feet on Swiss Ball
    static var weightedPushUpFeetOnSwissBall: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Push Up with Feet on Swiss Ball", number: 46)
    }

    /// Push Up with One Hand on Medicine Ball
    static var pushUpOneHandOnMedicineBall: PushUpExerciseName {
        return PushUpExerciseName(name: "Push Up with One Hand on Medicine Ball", number: 47)
    }

    /// Weighted Push Up with One Hand on Medicine Ball
    static var weightedPushUpOneHandOnMedicineBall: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Push Up with One Hand on Medicine Ball", number: 48)
    }

    /// Shoulder Push Up
    static var shoulderPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Shoulder Push Up", number: 49)
    }

    /// Weighted Shoulder Push Up
    static var seightedShoulderPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Shoulder Push Up", number: 50)
    }

    /// Single Arm Medicine Ball Push Up
    static var singleArmMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Single Arm Medicine Ball Push Up", number: 51)
    }

    /// Weighted Single Arm Medicine Ball Push Up
    static var weightedSingleArmMedicineBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Single Arm Medicine Ball Push Up", number: 52)
    }

    /// Spiderman Push Up
    static var spidermanPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Spiderman Push Up", number: 53)
    }
    
    /// Weighted Spiderman Push Up
    static var weightedSpidermanPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Spiderman Push Up", number: 54)
    }

    /// Stacked Feet Push Up
    static var stackedFeetPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Stacked Feet Push Up", number: 55)
    }

    /// Weighted Stacked Feet Push Up
    static var weightedStackedFeetPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Stacked Feet Push Up", number: 56)
    }

    /// Staggered Hands Push Up
    static var staggeredHandsPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Staggered Hands Push Up", number: 57)
    }

    /// Weighted Staggered Hands Push Up
    static var weightedStaggeredHandsPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Staggered Hands Push Up", number: 58)
    }

    /// Suspended Push Up
    static var suspendedPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Suspended Push Up", number: 59)
    }

    /// Weighted Suspended Push Up
    static var weightedSuspendedPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Suspended Push Up", number: 60)
    }

    /// Swiss Ball Push Up
    static var swissBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Swiss Ball Push Up", number: 61)
    }
    
    /// Weighted Swiss Ball Push Up
    static var weightedSwissBallPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Swiss Ball Push Up", number: 62)
    }
    
    /// Swiss Ball Push Up Plus
    static var swissBallPushUpPlus: PushUpExerciseName {
        return PushUpExerciseName(name: "Swiss Ball Push Up Plus", number: 63)
    }

    /// Weighted Swiss Ball Push Up Plus
    static var weightedSwissBallPushUpPlus: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Swiss Ball Push Up Plus", number: 64)
    }

    /// T Push Up
    static var tPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "T Push Up", number: 65)
    }

    /// Weighted T Push Up
    static var weightedTPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted T Push Up", number: 66)
    }

    /// Triple Stop Push Up
    static var tripleStopPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Triple Stop Push Up", number: 67)
    }

    /// Weighted Triple Stop Push Up
    static var weightedTripleStopPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Triple Stop Push Up", number: 68)
    }

    /// Wide Hands Push Up
    static var wideHandsPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Wide Hands Push Up", number: 69)
    }

    /// Weighted Wide Hands Push Up
    static var weightedWideHandsPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Wide Hands Push Up", number: 70)
    }

    /// Parallette Handstand Push Up
    static var paralletteHandstandPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Parallette Handstand Push Up", number: 71)
    }

    /// Weighted Parallette Handstand Push Up
    static var weightedParalletteHandstandPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Parallette Handstand Push Up", number: 72)
    }

    /// Ring Handstand Push Up
    static var ringHandstandPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Ring Handstand Push Up", number: 73)
    }

    /// Weighted Ring Handstand Push Up
    static var weightedRingHandstandPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Ring Handstand Push Up", number: 74)
    }

    /// Ring Push Up
    static var ringPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Ring Push Up", number: 75)
    }

    /// Weighted Ring Push Up
    static var weightedRingPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Weighted Ring Push Up", number: 76)
    }

    /// Push Up
    static var pushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Push Up", number: 77)
    }

    /// Pilates Push Up
    static var pilatesPushUp: PushUpExerciseName {
        return PushUpExerciseName(name: "Pilates Push Up", number: 78)
    }
}
