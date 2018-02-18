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
    public typealias ExerciseNameType = LegCurlExerciseName

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension LegCurlExerciseName: Hashable {
    public var hashValue: Int {
        return name.hashValue ^ number.hashValue
    }

    public static func ==(lhs: LegCurlExerciseName, rhs: LegCurlExerciseName) -> Bool {
        return lhs.name == rhs.name &&
            lhs.number == rhs.number
    }
}


public extension LegCurlExerciseName {

    public static var supportedExerciseNames: [LegCurlExerciseName] {

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
                .swissBallHipRaiseAndLegCurl,
                .zercherGoodMorning
        ]
    }
}

public extension LegCurlExerciseName {

    public static func create(rawValue: UInt16) -> LegCurlExerciseName? {

        for name in LegCurlExerciseName.supportedExerciseNames {
            if name.number == rawValue {
                return name
            }
        }

        return nil
    }
}

// MARK: - Exercise Types
public extension LegCurlExerciseName {

    /// Leg Curl
    public static var legCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Leg Curl", number: 0)
    }

    /// Weighted Leg Curl
    public static var weightedLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Weighted Leg Curl", number: 1)
    }

    /// Good Morning
    public static var goodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Good Morning", number: 2)
    }

    /// Seated Barbell Good Morning
    public static var seatedBarbellGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Seated Barbell Good Morning", number: 3)
    }

    /// Single Leg Barbell Good Morning
    public static var singleLegBarbellGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Single Leg Barbell Good Morning", number: 4)
    }

    /// Single Leg Sliding Leg Curl
    public static var singleLegSlidingLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Single Leg Sliding Leg Curl", number: 5)
    }

    /// Sliding Leg Curl
    public static var slidingLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Sliding Leg Curl", number: 6)
    }

    /// Split Barbell Good Morning
    public static var splitBarbellGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Split Barbell Good Morning", number: 7)
    }

    /// Split Stance Extension
    public static var splitStanceExtension: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Split Stance Extension", number: 8)
    }

    /// Staggered Stance Good Morning
    public static var staggeredStanceGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Staggered Stance Good Morning", number: 9)
    }

    /// Swiss Ball Hip Raise and Leg Curl
    public static var swissBallHipRaiseAndLegCurl: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Swiss Ball Hip Raise and Leg Curl", number: 10)
    }

    /// Zercher Good Morning
    public static var zercherGoodMorning: LegCurlExerciseName {
        return LegCurlExerciseName(name: "Zercher Good Morning", number: 11)
    }

}
