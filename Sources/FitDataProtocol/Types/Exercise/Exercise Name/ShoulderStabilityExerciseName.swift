//
//  ShoulderStabilityExerciseName.swift
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

/// Shoulder Stability Exercise Name
public struct ShoulderStabilityExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = ShoulderStabilityExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .shoulderStability }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension ShoulderStabilityExerciseName: Hashable {}

public extension ShoulderStabilityExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [ShoulderStabilityExerciseName] {

        return [.nintyDegreeCableExternalRotation,
                .bandExternalRotation,
                .bandInternalRotation,
                .bentArmLateralRaiseExternalRotation,
                .cableExternalRotation,
                .dumbbellFacePullExternalRotation,
                .floorIRaise,
                .weightedFloorIRaise,
                .floorTRaise,
                .weightedFloorTRaise,
                .floorYRaise,
                .weightedFloorYRaise,
                .inclineIRaise,
                .weightedInclineIRaise,
                .inclineLRaise,
                .weightedInclineLRaise,
                .inclineTRaise,
                .weightedInclineTRaise,
                .inclineWRaise,
                .weightedInclineWRaise,
                .inclineYRaise,
                .weightedInclineYRaise,
                .lyingExternalRotation,
                .seatedDumbbellExternalRotation,
                .standingLRaise,
                .swissBallIRaise,
                .weightedSwissBallIRaise,
                .swissBallTRaise,
                .weightedSwissBallTRaise,
                .swissBallWRaise,
                .weightedSwissBallWRaise,
                .swissBallYRaise,
                .weightedSwissBallYRaise
        ]
    }
}

public extension ShoulderStabilityExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> ShoulderStabilityExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension ShoulderStabilityExerciseName {

    /// 90 Degree Cable External Rotation
    static var nintyDegreeCableExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "90 Degree Cable External Rotation", number: 0)
    }

    /// Band External Rotation
    static var bandExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Band External Rotation", number: 1)
    }

    /// Band Internal Rotation
    static var bandInternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Band Internal Rotation", number: 2)
    }

    /// Bent Arm Lateral Raise and External Rotation
    static var bentArmLateralRaiseExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Bent Arm Lateral Raise and External Rotation", number: 3)
    }

    /// Cable External Rotation
    static var cableExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Cable External Rotation", number: 4)
    }

    /// Dumbbell Face Pull with External Rotation
    static var dumbbellFacePullExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Dumbbell Face Pull with External Rotation", number: 5)
    }

    /// Floor I Raise
    static var floorIRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Floor I Raise", number: 6)
    }

    /// Weighted Floor I Raise
    static var weightedFloorIRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Floor I Raise", number: 7)
    }

    /// Floor T Raise
    static var floorTRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Floor T Raise", number: 8)
    }

    /// Weighted Floor T Raise
    static var weightedFloorTRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Floor T Raise", number: 9)
    }

    /// Floor Y Raise
    static var floorYRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Floor Y Raise", number: 10)
    }

    /// Weighted Floor Y Raise
    static var weightedFloorYRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Floor Y Raise", number: 11)
    }

    /// Incline I Raise
    static var inclineIRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Incline I Raise", number: 12)
    }

    /// Weighted Incline I Raise
    static var weightedInclineIRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Incline I Raise", number: 13)
    }

    /// Incline L Raise
    static var inclineLRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Incline L Raise", number: 14)
    }

    /// Weighted Incline L Raise
    static var weightedInclineLRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Incline L Raise", number: 15)
    }

    /// Incline T Raise
    static var inclineTRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Incline T Raise", number: 16)
    }

    /// Weighted Incline T Raise
    static var weightedInclineTRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Incline T Raise", number: 17)
    }

    /// Incline W Raise
    static var inclineWRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Incline W Raise", number: 18)
    }

    /// Weighted Incline W Raise
    static var weightedInclineWRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Incline W Raise", number: 19)
    }

    /// Incline Y Raise
    static var inclineYRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Incline Y Raise", number: 20)
    }

    /// Weighted Incline Y Raise
    static var weightedInclineYRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Incline Y Raise", number: 21)
    }

    /// Lying External Rotation
    static var lyingExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Lying External Rotation", number: 22)
    }

    /// Seated Dumbbell External Rotation
    static var seatedDumbbellExternalRotation: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Seated Dumbbell External Rotation", number: 23)
    }

    /// Standing L Raise
    static var standingLRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Standing L Raise", number: 24)
    }

    /// Swiss Ball I Raise
    static var swissBallIRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Swiss Ball L Raise", number: 25)
    }

    /// Weighted Swiss Ball I Raise
    static var weightedSwissBallIRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Swiss Ball L Raise", number: 26)
    }

    /// Swiss Ball T Raise
    static var swissBallTRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Swiss Ball T Raise", number: 27)
    }

    /// Weighted Swiss Ball T Raise
    static var weightedSwissBallTRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Swiss Ball T Raise", number: 28)
    }

    /// Swiss Ball W Raise
    static var swissBallWRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Swiss Ball W Raise", number: 29)
    }

    /// Weighted Swiss Ball W Raise
    static var weightedSwissBallWRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Swiss Ball W Raise", number: 30)
    }

    /// Swiss Ball Y Raise
    static var swissBallYRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Swiss Ball Y Raise", number: 31)
    }

    /// Weighted Swiss Ball Y Raise
    static var weightedSwissBallYRaise: ShoulderStabilityExerciseName {
        return ShoulderStabilityExerciseName(name: "Weighted Swiss Ball Y Raise", number: 32)
    }
}
