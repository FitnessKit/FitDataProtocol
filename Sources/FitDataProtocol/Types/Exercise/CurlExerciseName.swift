//
//  CurlExerciseName.swift
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

/// Curl Exercise Name
public struct CurlExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = CurlExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension CurlExerciseName: Hashable {

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
    public static func == (lhs: CurlExerciseName, rhs: CurlExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}

public extension CurlExerciseName {

    /// List of Supported ExerciseNames
    public static var supportedExerciseNames: [CurlExerciseName] {

        return [.alternatingDumbbellBicepsCurl,
                .alternatingDumbbellBicepsCurlOnSwissBall,
                .alternatingInclineDumbbellBicepsCurl,
                .barbellBicepsCurl,
                .barbellReverseWristCurl,
                .barbellWristCurl,
                .behindTheBackBarbellReverseWristCurl,
                .behindTheBackOneArmCableCurl,
                .cableBicepsCurl,
                .cableHammerCurl,
                .cheatingBarbellBicepsCurl,
                .closeGripEzBarBicepsCurl,
                .crossBodyDumbbellHammerCurl,
                .deadHangBicepsCurl,
                .declineHammerCurl,
                .dumbbellBicepsCurlWithStaticHold,
                .dumbbellReverseWristCurl,
                .dumbbellWristCurl,
                .ezBarPreacherCurl,
                .forwardBendBicepsCurl,
                .hammerCurlToPress,
                .inclineDumbbellBicepsCurl,
                .inclineOffsetThumbDumbbellCurl,
                .kettlebellBicepsCurl,
                .lyingConcentrationCableCurl,
                .oneArmPreacherCurl,
                .platePinchCurl,
                .preacherCurlWithCable,
                .reverseEzBarCurl,
                .reverseGripWristCurl,
                .reverseGripBarbellBicepsCurl,
                .seatedAlternatingDumbbellBicepsCurl,
                .seatedDumbbellBicepsCurl,
                .seatedReverseDumbbellBicepsCurl,
                .splitStanceOffsetPinkyDumbbellCurl,
                .standingAlternatingDumbbellCurls,
                .standingDumbbellBicepsCurl,
                .standingEzBarBicepsCurl,
                .staticCurl,
                .swissBallDumbbellOverheadTricepsExtension,
                .swissBallEzBarPreacherCurl,
                .twistingStandingDumbbellBicepsCurl,
                .wideGripEzBarBicepsCurl
        ]
    }
}

public extension CurlExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    public static func create(rawValue: UInt16) -> CurlExerciseName? {

        for name in CurlExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension CurlExerciseName {

    /// Alternating Dumbbell Biceps Curl
    public static var alternatingDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Alternating Dumbbell Biceps Curl", number: 0)
    }

    /// Alternating Dumbbell Biceps Curl on Swiss Ball
    public static var alternatingDumbbellBicepsCurlOnSwissBall: CurlExerciseName {
        return CurlExerciseName(name: "Alternating Dumbbell Biceps Curl on Swiss Ball", number: 1)
    }

    /// Alternating Incline Dumbbell Biceps Curl
    public static var alternatingInclineDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Alternating Incline Dumbbell Biceps Curl", number: 2)
    }

    /// Barbell Biceps Curl
    public static var barbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Barbell Biceps Curl", number: 3)
    }

    /// Barbell Reverse Wrist Curl
    public static var barbellReverseWristCurl: CurlExerciseName {
        return CurlExerciseName(name: "Barbell Reverse Wrist Curl", number: 4)
    }

    /// Barbell Wrist Curl
    public static var barbellWristCurl: CurlExerciseName {
        return CurlExerciseName(name: "Barbell Wrist Curl", number: 5)
    }

    /// Behind the Back Barbell Reverse Wrist Curl
    public static var behindTheBackBarbellReverseWristCurl: CurlExerciseName {
        return CurlExerciseName(name: "Behind the Back Barbell Reverse Wrist Curl", number: 6)
    }

    /// Behind the Back one Arm Cable Curl
    public static var behindTheBackOneArmCableCurl: CurlExerciseName {
        return CurlExerciseName(name: "Behind the Back one Arm Cable Curl", number: 7)
    }

    /// Cable Biceps Curl
    public static var cableBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Cable Biceps Curl", number: 8)
    }

    /// Cable Hammer Curl
    public static var cableHammerCurl: CurlExerciseName {
        return CurlExerciseName(name: "Cable Hammer Curl", number: 9)
    }

    /// Cheating Barbell Biceps Curl
    public static var cheatingBarbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Cheating Barbell Biceps Curl", number: 10)
    }

    /// Close Grip EZ Bar Biceps Curl
    public static var closeGripEzBarBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Close Grip EZ Bar Biceps Curl", number: 11)
    }

    /// Cross Body Dumbbell Hammer Curl
    public static var crossBodyDumbbellHammerCurl: CurlExerciseName {
        return CurlExerciseName(name: "Cross Body Dumbbell Hammer Curl", number: 12)
    }

    /// Dead Hang Biceps Curl
    public static var deadHangBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Dead Hang Biceps Curl", number: 13)
    }

    /// Decline Hammer Curl
    public static var declineHammerCurl: CurlExerciseName {
        return CurlExerciseName(name: "Decline Hammer Curl", number: 14)
    }

    /// Dumbbell Biceps Curl with Static Hold
    public static var dumbbellBicepsCurlWithStaticHold: CurlExerciseName {
        return CurlExerciseName(name: "Dumbbell Biceps Curl with Static Hold", number: 15)
    }

    /// Dumbbell Hammer Curl
    public static var dumbellHammerCurl: CurlExerciseName {
        return CurlExerciseName(name: "Dumbbell Hammer Curl", number: 16)
    }

    /// Dumbbell Reverse Wrist Curl
    public static var dumbbellReverseWristCurl: CurlExerciseName {
        return CurlExerciseName(name: "Dumbbell Reverse Wrist Curl", number: 17)
    }

    /// Dumbbell Wrist Curl
    public static var dumbbellWristCurl: CurlExerciseName {
        return CurlExerciseName(name: "Dumbbell Wrist Curl", number: 18)
    }

    /// EZ Bar Preacher Curl
    public static var ezBarPreacherCurl: CurlExerciseName {
        return CurlExerciseName(name: "EZ Bar Preacher Curl", number: 19)
    }

    /// Forward Bend Biceps Curl
    public static var forwardBendBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Forward Bend Biceps Curl", number: 20)
    }

    /// Hammer Curl to Press
    public static var hammerCurlToPress: CurlExerciseName {
        return CurlExerciseName(name: "Hammer Curl to Press", number: 21)
    }

    /// Incline Dumbbell Biceps Curl
    public static var inclineDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Incline Dumbbell Biceps Curl", number: 22)
    }

    /// Incline Offset Thumb Dumbbell Curl
    public static var inclineOffsetThumbDumbbellCurl: CurlExerciseName {
        return CurlExerciseName(name: "Incline Offset Thumb Dumbbell Curl", number: 23)
    }

    /// Kettlebell Biceps Curl
    public static var kettlebellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Kettlebell Biceps Curl", number: 24)
    }

    /// Lying Concentration Cable Curl
    public static var lyingConcentrationCableCurl: CurlExerciseName {
        return CurlExerciseName(name: "Lying Concentration Cable Curl", number: 25)
    }

    /// One Arm Preacher Curl
    public static var oneArmPreacherCurl: CurlExerciseName {
        return CurlExerciseName(name: "One Arm Preacher Curl", number: 26)
    }

    /// Plate Pinch Curl
    public static var platePinchCurl: CurlExerciseName {
        return CurlExerciseName(name: "Plate Pinch Curl", number: 27)
    }

    /// Preacher Curl with Cable
    public static var preacherCurlWithCable: CurlExerciseName {
        return CurlExerciseName(name: "Preacher Curl with Cable", number: 28)
    }

    /// Reverse EZ Bar Curl
    public static var reverseEzBarCurl: CurlExerciseName {
        return CurlExerciseName(name: "Reverse EZ Bar Curl", number: 29)
    }

    /// Reverse Grip Wrist Curl
    public static var reverseGripWristCurl: CurlExerciseName {
        return CurlExerciseName(name: "Reverse Grip Wrist Curl", number: 30)
    }

    /// Reverse Grip Barbell Biceps Curl
    public static var reverseGripBarbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Reverse Grip Barbell Biceps Curl", number: 31)
    }

    /// Seated Alternating Dumbbell Biceps Curl
    public static var seatedAlternatingDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Seated Alternating Dumbbell Biceps Curl", number: 32)
    }

    /// Seated Dumbbell Biceps Curl
    public static var seatedDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Seated Dumbbell Biceps Curl", number: 33)
    }

    /// Seated Reverse Dumbbell Biceps Curl
    public static var seatedReverseDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Seated Reverse Dumbbell Biceps Curl", number: 34)
    }

    /// Split Stance Offset Pinky Dumbbell Curl
    public static var splitStanceOffsetPinkyDumbbellCurl: CurlExerciseName {
        return CurlExerciseName(name: "Split Stance Offset Pinky Dumbbell Curl", number: 35)
    }

    /// Standing Alternating Dumbbell Curls
    public static var standingAlternatingDumbbellCurls: CurlExerciseName {
        return CurlExerciseName(name: "Standing Alternating Dumbbell Curls", number: 36)
    }

    /// Standing Dumbbell Biceps Curl
    public static var standingDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Standing Dumbbell Biceps Curl", number: 37)
    }

    /// Standing EZ Bar Biceps Curl
    public static var standingEzBarBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Standing EZ Bar Biceps Curl", number: 38)
    }

    /// Static Curl
    public static var staticCurl: CurlExerciseName {
        return CurlExerciseName(name: "Static Curl", number: 39)
    }

    /// Swiss Ball Dumbbell Overhead Triceps Extension
    public static var swissBallDumbbellOverheadTricepsExtension: CurlExerciseName {
        return CurlExerciseName(name: "Swiss Ball Dumbbell Overhead Triceps Extension", number: 40)
    }

    /// Swiss Ball EZ Bar Preacher Curl
    public static var swissBallEzBarPreacherCurl: CurlExerciseName {
        return CurlExerciseName(name: "Swiss Ball EZ Bar Preacher Curl", number: 41)
    }

    /// Twisting Standing Dumbbell Biceps Curl
    public static var twistingStandingDumbbellBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Twisting Standing Dumbbell Biceps Curl", number: 42)
    }

    /// Wide Grip EZ Bar Biceps Curl
    public static var wideGripEzBarBicepsCurl: CurlExerciseName {
        return CurlExerciseName(name: "Wide Grip EZ Bar Biceps Curl", number: 43)
    }
}
