//
//  ExerciseCategory.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
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


/// Exercise Category
public enum ExerciseCategory: UInt16 {
    /// Bench Press
    case benchPress         = 0
    /// Calf Raise
    case calfRaise          = 1
    /// Cardio
    case cardio             = 2
    /// Carry
    case carry              = 3
    /// Chop
    case chop               = 4
    /// Core
    case core               = 5
    /// Crunch
    case crunch             = 6
    /// Curl
    case curl               = 7
    /// Deadlift
    case deadlift           = 8
    /// Flye
    case flye               = 9
    /// Hip Raise
    case hipRaise           = 10
    /// Hip Stability
    case hipStability       = 11
    /// Hip Swing
    case hipSwing           = 12
    /// Hyper Extension
    case hyperExtension     = 13
    /// Lateral Raise
    case lateralRaise       = 14
    /// Leg Curl
    case legCurl            = 15
    /// Leg Raise
    case legRaise           = 16
    /// Lunge
    case lunge              = 17
    /// Olympic Lift
    case olympicLift        = 18
    /// Plank
    case plank              = 19
    /// Plyo
    case plyo               = 20
    /// Pull Up
    case pullUp             = 21
    /// Push Up
    case pushUp             = 22
    /// Row
    case row                = 23
    /// Shoulder Press
    case shoulderPress      = 24
    //// Shoulder Stability
    case shouldStability    = 25
    /// Shrug
    case shrug              = 26
    /// Sit Up
    case sitUp              = 27
    /// Squat
    case squat              = 28
    /// Total Body
    case totalBody          = 29
    //// Triceps Extension
    case tricepExtension    = 30
    /// Warm Up
    case warmUp             = 31
    /// Run
    case run                = 32

    /// Unknown
    case unknown            = 65534
    /// Invalid
    case invalid            = 65535
}
