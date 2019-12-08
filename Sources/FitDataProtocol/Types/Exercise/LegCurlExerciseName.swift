//
//  LegCurlExerciseName.swift
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

/// Leg Curl Exercise Name
public struct LegCurlExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = LegCurlExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .legCurl }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension LegCurlExerciseName: Hashable {}

public extension LegCurlExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [LegCurlExerciseName] {

        return [.legCurl,
                .weightedLegCurl,
                .goodMorning,
                .seatedBarbellGoodMorning,
                .singleLegBarbellGoodMorning,
                .singleLegSlidingLegCurl,
                .slidingLegCurl,
                .splitBarbellGoodMorning,
                .splitStanceExtension,
                .staggeredStanceGoodMorning,
                .swissBallHipRaiseLegCurl,
                .zercherGoodMorning
        ]
    }
}

public extension LegCurlExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> LegCurlExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension LegCurlExerciseName {

    /// Leg Curl
    static var legCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Leg Curl", number: 0)
    }

    /// Weighted Leg Curl
    static var weightedLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Weighted Leg Curl", number: 1)
    }

    /// Good Morning
    static var goodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Good Morning", number: 2)
    }

    /// Seated Barbell Good Morning
    static var seatedBarbellGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Seated Barbell Good Morning", number: 3)
    }

    /// Single Leg Barbell Good Morning
    static var singleLegBarbellGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Single Leg Barbell Good Morning", number: 4)
    }

    /// Single Leg Sliding Leg Curl
    static var singleLegSlidingLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Single Leg Sliding Leg Curl", number: 5)
    }

    /// Sliding Leg Curl
    static var slidingLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Sliding Leg Curl", number: 6)
    }

    /// Split Barbell Good Morning
    static var splitBarbellGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Split Barbell Good Morning", number: 7)
    }

    /// Split Stance Extension
    static var splitStanceExtension: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Split Stance Extension", number: 8)
    }

    /// Staggered Stance Good Morning
    static var staggeredStanceGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Staggered Stance Good Morning", number: 9)
    }

    /// Swiss Ball Hip Raise and Leg Curl
    static var swissBallHipRaiseLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Swiss Ball Hip Raise and Leg Curl", number: 10)
    }

    /// Zercher Good Morning
    static var zercherGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Zercher Good Morning", number: 11)
    }
}
