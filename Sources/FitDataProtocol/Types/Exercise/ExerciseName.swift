//
//  ExerciseName.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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

typealias ExerciseName = ExerciseNameType & ExerciseNameSupportable

/// Exercise Name Protocol
public protocol ExerciseNameType {

    /// Exercise Catagory Type
    var catagory: ExerciseCategory { get }

    /// Name of Exercise
    var name: String { get }

    /// Number for the Exercise from FIT
    var number: UInt16 { get }

    /// Creates a ExerciseName Object
    ///
    /// - Parameter rawValue: exerciseNumber
    /// - Returns: ExerciseName Object
    static func create(rawValue: UInt16) -> Self?
}

/// Exercise Name Supportable
///
/// Provides Helper functions such as supported exercises
public protocol ExerciseNameSupportable: Hashable {
    /// Exercise Name Type
    associatedtype ExerciseNameType

    /// List of Supported ExerciseNames
    static var supportedExerciseNames: [ExerciseNameType] { get }
}
