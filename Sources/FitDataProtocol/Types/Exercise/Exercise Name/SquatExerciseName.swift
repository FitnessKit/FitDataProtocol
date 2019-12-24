//
//  SquatExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/21/19.
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

/// Squat Exercise Name
public struct SquatExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = SquatExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .squat }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension SquatExerciseName: Hashable {}

public extension SquatExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [SquatExerciseName] {

        return [.legPress,
                .backSquatBodyBar,
                .backSquats,
                .weightedBackSquats,
                .balancingSquat,
                .weightedBalancingSquat,
                .barbellBackSquat,
                .barbellBoxSquat,
                .barbellFrontSquat,
                .barbellHackSquat,
                .barbellHangSquatSnatch,
                .barbellLateralStepUp,
                .barbellQuarterSquat,
                .barbellSiffSquat,
                .barbellSquatSnatch,
                .barbellSquatHeelsRaised,
                .barbellStepover,
                .barbellStepUp,
                .benchSquatRotationalChop,
                .weightedBenchSquatRotationalChop,
                .bodyWeightWallSquat,
                .weightedWallSquat,
                .boxStepSquat,
                .weightedBoxStepSquat,
                .bracedSquat,
                .crossedArmBarbellFrontSquat,
                .crossoverDumbbellStepUp,
                .dumbbellFrontSquat,
                .dumbbellSplitSquat,
                .dumbbellSquat,
                .dumbbellSquatClean,
                .dumbbellStepover,
                .dumbbellStepUp,
                .elevatedSingleLegSquat,
                .weightedElevatedSingleLegSquat,
                .figureFourSquats,
                .weightedFigureFourSquats,
                .gobletSquat,
                .kettlebellSquat,
                .kettlebellSwingOverhead,
                .kettlebellSwingFlipSquat,
                .lateralDumbbellStepUp,
                .oneLeggedSquat,
                .overheadDumbbellSquat,
                .overheadSquat,
                .partialSingleLegSquat,
                .weightedPartialSingleLegSquat,
                .pistolSquat,
                .weightedPistolSquat,
                .pileSlides,
                .weightedPileSlides,
                .pileSquat,
                .weightedPileSquat,
                .prisonerSquat,
                .weightedPrisonerSquat,
                .singleLegBenchGetUp,
                .weightedSingleLegBenchGetUp,
                .singleLegBenchSquat,
                .weightedSingleLegBenchSquat,
                .singleLegSquatSwissBall,
                .weightedSingleLegSquatSwissBall,
                .squat,
                .weightedSquat,
                .squatsBand,
                .staggeredSquat,
                .weightedStaggeredSquat,
                .stepUp,
                .weightedStepUp,
                .suitecaseSquats,
                .sumoSquat,
                .sumoSquatSlideIn,
                .weightedSumoSquatSlideIn,
                .sumoSquatHighPull,
                .sumoSquatStand,
                .weightedSumoSquatStand,
                .sumoSquatRotation,
                .weightedSumoSquatRotation,
                .swissBallBodyWeightWallSquat,
                .weightedSwissBallWallSquat,
                .thrusters,
                .unevenSquat,
                .weightedUnevenSquat,
                .waistSlimmingSquat,
                .wallBall,
                .wideStanceBarbellSquat,
                .wideStanceGobletSquat,
                .zercherSquat,
                .kbsOverhead,
                .squatSideKick,
                .squatJumpsInOut,
                .pilatesPileSquatsParallelTurnedOutFlatHeels,
                .releveStraightLegKneeBenOneLegVariation,
        ]
    }
}

public extension SquatExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> SquatExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }

    }
}

// MARK: - Exercise Types
public extension SquatExerciseName {

    /// Leg Press
    static var legPress: SquatExerciseName {
        return SquatExerciseName(name: "Leg Press", number: 0)
    }

    /// Back Squat with Body Bar
    static var backSquatBodyBar: SquatExerciseName {
        return SquatExerciseName(name: "Back Squat with Body Bar", number: 1)
    }

    /// Back Squats
    static var backSquats: SquatExerciseName {
        return SquatExerciseName(name: "Back Squats", number: 2)
    }

    /// Weighted Back Squats
    static var weightedBackSquats: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Back Squats", number: 3)
    }

    /// Balancing Squat
    static var balancingSquat: SquatExerciseName {
        return SquatExerciseName(name: "Balancing Squat", number: 4)
    }

    /// Weighted Balancing Squat
    static var weightedBalancingSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Balancing Squat", number: 5)
    }

    /// Barbell Back Squat
    static var barbellBackSquat: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Back Squat", number: 6)
    }

    /// Barbell Box Squat
    static var barbellBoxSquat: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Box Squat", number: 7)
    }

    /// Barbell Front Squat
    static var barbellFrontSquat: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Front Squat", number: 8)
    }

    /// Barbell Hack Squat
    static var barbellHackSquat: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Hack Squat", number: 9)
    }
    
    /// Barbell Hang Squat Snatch
    static var barbellHangSquatSnatch: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Hang Squat Snatch", number: 10)
    }

    /// Barbell Lateral Step Up
    static var barbellLateralStepUp: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Lateral Step Up", number: 11)
    }

    /// Barbell Quarter Squat
    static var barbellQuarterSquat: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Quarter Squat", number: 12)
    }

    /// Barbell Siff Squat
    static var barbellSiffSquat: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Siff Squat", number: 13)
    }

    /// Barbell Squat Snatch
    static var barbellSquatSnatch: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Squat Snatch", number: 14)
    }

    /// Barbell Squat with Heels Raised
    static var barbellSquatHeelsRaised: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Squat with Heels Raised", number: 15)
    }

    /// Barbell Stepover
    static var barbellStepover: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Stepover", number: 16)
    }

    /// Barbell Step Up
    static var barbellStepUp: SquatExerciseName {
        return SquatExerciseName(name: "Barbell Step Up", number: 17)
    }

    /// Bench Squat with Rotational Chop
    static var benchSquatRotationalChop: SquatExerciseName {
        return SquatExerciseName(name: "Bench Squat with Rotational Chop", number: 18)
    }

    /// Weighted Bench Squat with Rotational Chop
    static var weightedBenchSquatRotationalChop: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Bench Squat with Rotational Chop", number: 19)
    }

    /// Body Weight Wall Squat
    static var bodyWeightWallSquat: SquatExerciseName {
        return SquatExerciseName(name: "Body Weight Wall Squat", number: 20)
    }

    /// Weighted Wall Squat
    static var weightedWallSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Wall Squat", number: 21)
    }

    /// Box Step Squat
    static var boxStepSquat: SquatExerciseName {
        return SquatExerciseName(name: "Box Step Squat", number: 22)
    }

    /// Weighted Box Step Squat
    static var weightedBoxStepSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Box Step Squat", number: 23)
    }

    /// Braced Squat
    static var bracedSquat: SquatExerciseName {
        return SquatExerciseName(name: "Braced Squat", number: 24)
    }

    /// Crossed Arm Barbell Front Squat
    static var crossedArmBarbellFrontSquat: SquatExerciseName {
        return SquatExerciseName(name: "Crossed Arm Barbell Front Squat", number: 25)
    }

    /// Crossover Dumbbell Step Up
    static var crossoverDumbbellStepUp: SquatExerciseName {
        return SquatExerciseName(name: "Crossover Dumbbell Step Up", number: 26)
    }

    /// Dumbbell Front Squat
    static var dumbbellFrontSquat: SquatExerciseName {
        return SquatExerciseName(name: "Dumbbell Front Squat", number: 27)
    }

    /// Dumbbell Split Squat
    static var dumbbellSplitSquat: SquatExerciseName {
        return SquatExerciseName(name: "Dumbbell Split Squat", number: 28)
    }

    /// Dumbbell Squat
    static var dumbbellSquat: SquatExerciseName {
        return SquatExerciseName(name: "Dumbbell Squat", number: 29)
    }

    /// Dumbbell Squat Clean
    static var dumbbellSquatClean: SquatExerciseName {
        return SquatExerciseName(name: "Dumbbell Squat Clean", number: 30)
    }

    /// Dumbbell Stepover
    static var dumbbellStepover: SquatExerciseName {
        return SquatExerciseName(name: "Dumbbell Stepover", number: 31)
    }

    /// Dumbbell Step Up
    static var dumbbellStepUp: SquatExerciseName {
        return SquatExerciseName(name: "Dumbbell Step Up", number: 32)
    }

    /// Elevated Single Leg Squat
    static var elevatedSingleLegSquat: SquatExerciseName {
        return SquatExerciseName(name: "Elevated Single Leg Squat", number: 33)
    }

    /// Weighted Elevated Single Leg Squat
    static var weightedElevatedSingleLegSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Elevated Single Leg Squat", number: 34)
    }

    /// Figure Four Squats
    static var figureFourSquats: SquatExerciseName {
        return SquatExerciseName(name: "Figure Four Squats", number: 35)
    }

    /// Weighted Figure Four Squats
    static var weightedFigureFourSquats: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Figure Four Squats", number: 36)
    }

    /// Goblet Squat
    static var gobletSquat: SquatExerciseName {
        return SquatExerciseName(name: "Goblet Squat", number: 37)
    }

    /// Kettlebell Squat
    static var kettlebellSquat: SquatExerciseName {
        return SquatExerciseName(name: "Kettlebell Squat", number: 38)
    }

    /// Kettlebell Swing Overhead
    static var kettlebellSwingOverhead: SquatExerciseName {
        return SquatExerciseName(name: "Kettlebell Swing Overhead", number: 39)
    }

    /// Kettlebell Swing with Flip to Squat
    static var kettlebellSwingFlipSquat: SquatExerciseName {
        return SquatExerciseName(name: "Kettlebell Swing with Flip to Squat", number: 40)
    }

    /// Lateral Dumbbell Step Up
    static var lateralDumbbellStepUp: SquatExerciseName {
        return SquatExerciseName(name: "Lateral Dumbbell Step Up", number: 41)
    }

    /// One Legged Squat
    static var oneLeggedSquat: SquatExerciseName {
        return SquatExerciseName(name: "One Legged Squat", number: 42)
    }

    /// Overhead Dumbbell Squat
    static var overheadDumbbellSquat: SquatExerciseName {
        return SquatExerciseName(name: "Overhead Dumbbell Squat", number: 43)
    }

    /// Overhead Squat
    static var overheadSquat: SquatExerciseName {
        return SquatExerciseName(name: "Overhead Squat", number: 44)
    }

    /// Partial Single Leg Squat
    static var partialSingleLegSquat: SquatExerciseName {
        return SquatExerciseName(name: "Partial Single Leg Squat", number: 45)
    }

    /// Weighted Partial Single Leg Squat
    static var weightedPartialSingleLegSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Partial Single Leg Squat", number: 46)
    }

    /// Pistol Squat
    static var pistolSquat: SquatExerciseName {
        return SquatExerciseName(name: "Pistol Squat", number: 47)
    }

    /// Weighted Pistol Squat
    static var weightedPistolSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Pistol Squat", number: 48)
    }

    /// Pile Slides
    static var pileSlides: SquatExerciseName {
        return SquatExerciseName(name: "Pile Slides", number: 49)
    }

    /// Weighted Pile Slides
    static var weightedPileSlides: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Pile Slides", number: 50)
    }

    /// Pile Squat
    static var pileSquat: SquatExerciseName {
        return SquatExerciseName(name: "Pile Squat", number: 51)
    }

    /// Weighted Pile Squat
    static var weightedPileSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Pile Squat", number: 52)
    }

    /// Prisoner Squat
    static var prisonerSquat: SquatExerciseName {
        return SquatExerciseName(name: "Prisoner Squat", number: 53)
    }

    /// Weighted Prisoner Squat
    static var weightedPrisonerSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Prisoner Squat", number: 54)
    }

    /// Single Leg Bench Get Up
    static var singleLegBenchGetUp: SquatExerciseName {
        return SquatExerciseName(name: "Single Leg Bench Get Up", number: 55)
    }

    /// Weighted Single Leg Bench Get Up
    static var weightedSingleLegBenchGetUp: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Single Leg Bench Get Up", number: 56)
    }

    /// Single Leg Bench Squat
    static var singleLegBenchSquat: SquatExerciseName {
        return SquatExerciseName(name: "Single Leg Bench Squat", number: 57)
    }

    /// Weighted Single Leg Bench Squat
    static var weightedSingleLegBenchSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Single Leg Bench Squat", number: 58)
    }

    /// Single Leg Squat on Swiss Ball
    static var singleLegSquatSwissBall: SquatExerciseName {
        return SquatExerciseName(name: "Single Leg Squat on Swiss Ball", number: 59)
    }

    /// Weighted Single Leg Squat on Swiss Ball
    static var weightedSingleLegSquatSwissBall: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Single Leg Squat on Swiss Ball", number: 60)
    }

    /// Squat
    static var squat: SquatExerciseName {
        return SquatExerciseName(name: "Squat", number: 61)
    }

    /// Weighted Squat
    static var weightedSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Squat", number: 62)
    }

    /// Squats with Band
    static var squatsBand: SquatExerciseName {
        return SquatExerciseName(name: "Squats with Band", number: 63)
    }

    /// Staggered Squat
    static var staggeredSquat: SquatExerciseName {
        return SquatExerciseName(name: "Staggered Squat", number: 64)
    }

    /// Weighted Staggered Squat
    static var weightedStaggeredSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Staggered Squat", number: 65)
    }

    /// Step Up
    static var stepUp: SquatExerciseName {
        return SquatExerciseName(name: "Step Up", number: 66)
    }

    /// Weighted Step Up
    static var weightedStepUp: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Step Up", number: 67)
    }

    /// Suitcase Squats
    static var suitecaseSquats: SquatExerciseName {
        return SquatExerciseName(name: "Suitcase Squats", number: 68)
    }

    /// Sumo Squat
    static var sumoSquat: SquatExerciseName {
        return SquatExerciseName(name: "Sumo Squat", number: 69)
    }

    /// Sumo Squat Slide In
    static var sumoSquatSlideIn: SquatExerciseName {
        return SquatExerciseName(name: "Sumo Squat Slide In", number: 70)
    }

    /// Weighted Sumo Squat Slide In
    static var weightedSumoSquatSlideIn: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Sumo Squat Slide In", number: 71)
    }

    /// Sumo Squat to High Pull
    static var sumoSquatHighPull: SquatExerciseName {
        return SquatExerciseName(name: "Sumo Squat to High Pull", number: 72)
    }

    /// Sumo Squat to Stand
    static var sumoSquatStand: SquatExerciseName {
        return SquatExerciseName(name: "Sumo Squat to Stand", number: 73)
    }

    /// Weighted Sumo Squat to Stand
    static var weightedSumoSquatStand: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Sumo Squat to Stand", number: 74)
    }

    /// Sumo Squat with Rotation
    static var sumoSquatRotation: SquatExerciseName {
        return SquatExerciseName(name: "Sumo Squat with Rotation", number: 75)
    }

    /// Weighted Sumo Squat with Rotation
    static var weightedSumoSquatRotation: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Sumo Squat with Rotation", number: 76)
    }

    /// Swiss Ball Body Weight Wall Squat
    static var swissBallBodyWeightWallSquat: SquatExerciseName {
        return SquatExerciseName(name: "Swiss Ball Body Weight Wall Squat", number: 77)
    }

    /// Weighted Swiss Ball Wall Squat
    static var weightedSwissBallWallSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Swiss Ball Wall Squat", number: 78)
    }

    /// Thrusters
    static var thrusters: SquatExerciseName {
        return SquatExerciseName(name: "Thrusters", number: 79)
    }

    /// Uneven Squat
    static var unevenSquat: SquatExerciseName {
        return SquatExerciseName(name: "Uneven Squat", number: 80)
    }

    /// Weighted Uneven Squat
    static var weightedUnevenSquat: SquatExerciseName {
        return SquatExerciseName(name: "Weighted Uneven Squat", number: 81)
    }

    /// Waist Slimming Squat
    static var waistSlimmingSquat: SquatExerciseName {
        return SquatExerciseName(name: "Waist Slimming Squat", number: 82)
    }

    /// Wall Ball
    static var wallBall: SquatExerciseName {
        return SquatExerciseName(name: "Wall Ball", number: 83)
    }

    /// Wide Stance Barbell Squat
    static var wideStanceBarbellSquat: SquatExerciseName {
        return SquatExerciseName(name: "Wide Stance Barbell Squat", number: 84)
    }

    /// Wide Stance Goblet Squat
    static var wideStanceGobletSquat: SquatExerciseName {
        return SquatExerciseName(name: "Wide Stance Goblet Squat", number: 85)
    }

    /// Zercher Squat
    static var zercherSquat: SquatExerciseName {
        return SquatExerciseName(name: "Zercher Squat", number: 86)
    }

    /// KBS Overhead
    static var kbsOverhead: SquatExerciseName {
        return SquatExerciseName(name: "KBS Overhead", number: 87)
    }

    /// Squat and Side Kick
    static var squatSideKick: SquatExerciseName {
        return SquatExerciseName(name: "Squat and Side Kick", number: 88)
    }

    /// Squat Jumps In n Out
    static var squatJumpsInOut: SquatExerciseName {
        return SquatExerciseName(name: "Squat Jumps In n Out", number: 89)
    }

    /// Pilates Pile Squats Parallel Turned Out Flat and Heels
    static var pilatesPileSquatsParallelTurnedOutFlatHeels: SquatExerciseName {
        return SquatExerciseName(name: "Pilates Pile Squats Parallel Turned Out Flat and Heels", number: 90)
    }

    /// Releve Straight Leg and Knee Bent with One Leg Variation
    static var releveStraightLegKneeBenOneLegVariation: SquatExerciseName {
        return SquatExerciseName(name: "Releve Straight Leg and Knee Bent with One Leg Variation", number: 91)
    }
}
