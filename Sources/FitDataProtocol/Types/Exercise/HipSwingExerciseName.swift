//
//  HipSwingExerciseName.swift
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

/// Hip Swing Exercise Name
public struct HipSwingExerciseName: ExerciseName {
    /// Exercise Name Type
    public typealias ExerciseNameType = HipSwingExerciseName

    /// Exercise Catagory Type
    public var catagory: ExerciseCategory { .hipSwing }

    /// Exercise Name
    private(set) public var name: String

    /// Exercise Name Number
    private(set) public var number: UInt16

    private init (name: String, number: UInt16) {
        self.name = name
        self.number = number
    }
}

extension HipSwingExerciseName: Hashable {}


public extension HipSwingExerciseName {

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [HipSwingExerciseName] {

        return [.armKettlebellSwing,
                .singleArmDumbbellSwing,
                .stepOutSwing
        ]
    }
}

public extension HipSwingExerciseName {

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> HipSwingExerciseName? {
        return supportedExerciseNames.first { $0.number == rawValue }
    }
}

// MARK: - Exercise Types
public extension HipSwingExerciseName {

    /// Arm Kettlebell Swing
    static var armKettlebellSwing: HipSwingExerciseName {
        return HipSwingExerciseName(name: "Arm Kettlebell Swing", number: 0)
    }

    /// Single Arm Dumbbell Swing
    static var singleArmDumbbellSwing: HipSwingExerciseName {
        return HipSwingExerciseName(name: "Single Arm Dumbbell Swing", number: 1)
    }

    /// Step Out Swing
    static var stepOutSwing: HipSwingExerciseName {
        return HipSwingExerciseName(name: "Step Out Swing", number: 2)
    }
}
