//
//  CoreExerciseName.swift
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

/// Core Exercise Name
public struct CoreExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = CoreExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .core }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension CoreExerciseName: Hashable {}

public extension CoreExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [CoreExerciseName] {

        return [.absJabs,
                .weightedAbsJabs,
                .alternatingPlateReach,
                .barbellRollout,
                .weightedBarbellRollout,
                .bodyBarObliqueTwist,
                .cableCorePress,
                .cableSideBend,
                .sideBend,
                .weightedSideBend,
                .crescentCircle,
                .weightedCrescentCircle,
                .cyclingRussianTwist,
                .weightedCyclingRussianTwist,
                .elevatedFeetRussianTwist,
                .weightedElevatedFeetRussianTwist,
                .halfTurkishGetUp,
                .kettlebellWindmill,
                .kneelingAbWheel,
                .weightedKneelingAbWheel,
                .modifiedFrontLever,
                .openKneeTucks,
                .weightedOpenKneeTucks,
                .sideAbsLegLift,
                .weightedSideAbsLegLift,
                .swissBallJackknife,
                .weightedSwissBallJackknife,
                .swissBallPike,
                .weightedSwissBallPike,
                .swissBallRollout,
                .weightedSwissBallRollout,
                .triangleHipPress,
                .weightedTriangleHipPress,
                .trxSuspendedJackknife,
                .weightedTrxSuspendedJackknife,
                .uBoat,
                .weightedUBoat,
                .windmillSwitches,
                .weightedWindmillSwitches,
                .alternatingSlideOut,
                .weightedAlternatingSlideOut,
                .ghdBackExtensions,
                .weightedGhdBackExtensions,
                .overheadWalk,
                .inchworm,
                .weightedModifiedFrontLever,
        ]
    }
}

public extension CoreExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> CoreExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension CoreExerciseName {

    /// Abs Jabs
    static var absJabs: CoreExerciseName {
        return CoreExerciseName(name: "Abs Jabs", number: 0)
    }

    /// Weighted Abs Jabs
    static var weightedAbsJabs: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Abs Jabs", number: 1)
    }

    /// Alternating Plate Reach
    static var alternatingPlateReach: CoreExerciseName {
        return CoreExerciseName(name: "Alternating Plate Reach", number: 2)
    }

    /// Barbell Rollout
    static var barbellRollout: CoreExerciseName {
        return CoreExerciseName(name: "Barbell Rollout", number: 3)
    }

    /// Weighted Barbell Rollout
    static var weightedBarbellRollout: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Barbell Rollout", number: 4)
    }

    /// Body Bar Oblique Twist
    static var bodyBarObliqueTwist: CoreExerciseName {
        return CoreExerciseName(name: "Body Bar Oblique Twist", number: 5)
    }

    /// Cable Core Press
    static var cableCorePress: CoreExerciseName {
        return CoreExerciseName(name: "Cable Core Press", number: 6)
    }

    /// Cable Side Bend
    static var cableSideBend: CoreExerciseName {
        return CoreExerciseName(name: "Cable Side Bend", number: 7)
    }

    /// Side Bend
    static var sideBend: CoreExerciseName {
        return CoreExerciseName(name: "Side Bend", number: 8)
    }

    /// Weighted Side Bend
    static var weightedSideBend: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Side Bend", number: 9)
    }

    /// Crescent Circle
    static var crescentCircle: CoreExerciseName {
        return CoreExerciseName(name: "Crescent Circle", number: 10)
    }

    /// Weighted Crescent Circle
    static var weightedCrescentCircle: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Crescent Circle", number: 11)
    }

    /// Cycling Russian Twist
    static var cyclingRussianTwist: CoreExerciseName {
        return CoreExerciseName(name: "Cycling Russian Twist", number: 12)
    }

    /// Weighted Cycling Russian Twist
    static var weightedCyclingRussianTwist: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Cycling Russian Twist", number: 13)
    }

    /// Elevated Feet Russian Twist
    static var elevatedFeetRussianTwist: CoreExerciseName {
        return CoreExerciseName(name: "Elevated Feet Russian Twist", number: 14)
    }

    /// Weighted Elevated Feet Russian Twist
    static var weightedElevatedFeetRussianTwist: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Elevated Feet Russian Twist", number: 15)
    }

    /// Half Turkish Get Up
    static var halfTurkishGetUp: CoreExerciseName {
        return CoreExerciseName(name: "Half Turkish Get Up", number: 16)
    }

    /// Kettlebell Windmill
    static var kettlebellWindmill: CoreExerciseName {
        return CoreExerciseName(name: "Kettlebell Windmill", number: 17)
    }

    /// Kneeling Ab Wheel
    static var kneelingAbWheel: CoreExerciseName {
        return CoreExerciseName(name: "Kneeling Ab Wheel", number: 18)
    }

    /// Weighted Kneeling Ab Wheel
    static var weightedKneelingAbWheel: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Kneeling Ab Wheel", number: 19)
    }

    /// Modified front Lever
    static var modifiedFrontLever: CoreExerciseName {
        return CoreExerciseName(name: "Modified front Lever", number: 20)
    }

    /// Open Knee Tucks
    static var openKneeTucks: CoreExerciseName {
        return CoreExerciseName(name: "Open Knee Tucks", number: 21)
    }

    /// Weighted Open Knee Tucks
    static var weightedOpenKneeTucks: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Open Knee Tucks", number: 22)
    }

    /// Side Abs Leg Lift
    static var sideAbsLegLift: CoreExerciseName {
        return CoreExerciseName(name: "Side Abs Leg Lift", number: 23)
    }

    /// Weighted Side Abs Leg Lift
    static var weightedSideAbsLegLift: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Side Abs Leg Lift", number: 24)
    }

    /// Swiss Ball Jackknife
    static var swissBallJackknife: CoreExerciseName {
        return CoreExerciseName(name: "Swiss Ball Jackknife", number: 25)
    }

    /// Weighted Swiss Ball Jackknife
    static var weightedSwissBallJackknife: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Swiss Ball Jackknife", number: 26)
    }

    /// Swiss Ball Pike
    static var swissBallPike: CoreExerciseName {
        return CoreExerciseName(name: "Swiss Ball Pike", number: 27)
    }

    /// Weighted Swiss Ball Pike
    static var weightedSwissBallPike: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Swiss Ball Pike", number: 28)
    }

    /// Swiss Ball Rollout
    static var swissBallRollout: CoreExerciseName {
        return CoreExerciseName(name: "Swiss Ball Rollout", number: 29)
    }

    /// Weighted Swiss Ball Rollout
    static var weightedSwissBallRollout: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Swiss Ball Rollout", number: 30)
    }

    /// Triangle Hip Press
    static var triangleHipPress: CoreExerciseName {
        return CoreExerciseName(name: "Triangle Hip Press", number: 31)
    }

    /// Weighted Triangle Hip Press
    static var weightedTriangleHipPress: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Triangle Hip Press", number: 32)
    }

    /// TRX Suspended Jackknife
    static var trxSuspendedJackknife: CoreExerciseName {
        return CoreExerciseName(name: "TRX Suspended Jackknife", number: 33)
    }

    /// Weighted TRX Suspended Jackknife
    static var weightedTrxSuspendedJackknife: CoreExerciseName {
        return CoreExerciseName(name: "Weighted TRX Suspended Jackknife", number: 34)
    }

    /// U Boat
    static var uBoat: CoreExerciseName {
        return CoreExerciseName(name: "U Boat", number: 35)
    }

    /// Weighted U Boat
    static var weightedUBoat: CoreExerciseName {
        return CoreExerciseName(name: "Weighted U Boat", number: 36)
    }

    /// Windmill Switches
    static var windmillSwitches: CoreExerciseName {
        return CoreExerciseName(name: "Windmill Switches", number: 37)
    }

    /// Weighted Windmill Switches
    static var weightedWindmillSwitches: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Windmill Switches", number: 38)
    }

    /// Alternating Slide Out
    static var alternatingSlideOut: CoreExerciseName {
        return CoreExerciseName(name: "Alternating Slide Out", number: 39)
    }

    /// Weighted Alternating Slide Out
    static var weightedAlternatingSlideOut: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Alternating Slide Out", number: 40)
    }

    /// GHD Back Extensions
    static var ghdBackExtensions: CoreExerciseName {
        return CoreExerciseName(name: "GHD Back Extensions", number: 41)
    }

    /// Weighted GHD Back Extensions
    static var weightedGhdBackExtensions: CoreExerciseName {
        return CoreExerciseName(name: "Weighted GHD Back Extensions", number: 42)
    }

    /// Overhead Walk
    static var overheadWalk: CoreExerciseName {
        return CoreExerciseName(name: "Overhead Walk", number: 43)
    }

    /// Inchworm
    static var inchworm: CoreExerciseName {
        return CoreExerciseName(name: "Inchworm", number: 44)
    }

    /// Weighted Modified Front Lever
    static var weightedModifiedFrontLever: CoreExerciseName {
        return CoreExerciseName(name: "Weighted Modified Front Lever", number: 45)
    }
}
