//
//  WorkoutStepDurationType.swift
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

/// Workout Step Duration Type
public enum WorkoutStepDurationType: UInt8 {
    /// Time
    case time                               = 0
    /// Distance
    case distance                           = 1
    /// Heart Rate Less Then
    case heartRateLessThen                  = 2
    /// Heart Rate Greater Then
    case heatRateGreaterThen                = 3
    /// Calories
    case calories                           = 4
    /// Open
    case open                               = 5
    /// Repeat Until Steps Complete
    case repeatUntilStepsComplete           = 6
    /// Repeat Until Time
    case repeatUntilTime                    = 7
    /// Repeat Until Distance
    case repeatUntilDistance                = 8
    /// Repeat Until Calories
    case repeatUntilCalories                = 9
    /// Repeat Until Heart Rate Less Then
    case repeatUntilHeartRateLessThen       = 10
    /// Repeat Until Heart Rate Greater Then
    case repeatUntilHeartRateGreaterThen    = 11
    /// Repeat Until Power Less Then
    case repeatUntilPowerLessThen           = 12
    /// Repeat Until Power Greater Then
    case repeatUntilPowerGreaterThen        = 13
    /// Power Less Then
    case powerLessThen                      = 14
    /// Power Greater Then
    case powerGreaterThen                   = 15
    /// Training Peaks TSS
    case trainingPeaksTss                   = 16
    /// Repeat Until Power Last Lap Less Then
    case repeatUntilPowerLastLapLessThen    = 17
    /// Repeat Until Max Power Last Lap Less Then
    case repeatUntilMaxPowerLastLapLessThen = 18
    /// Power 3 Second Less Then
    case power3SecondLessThen               = 19
    /// Power 10 Second Less Then
    case power10SecondLessThen              = 20
    /// Power 30 Second Less Then
    case power30SecondLessThen              = 21
    /// Power 3 Second Greater Then
    case power3SecondGreaterThen            = 22
    /// Power 10 Second Greater Then
    case power10SecondGreaterThen           = 23
    /// Power 30 Second Greater Then
    case power30SecondGreaterThen           = 24
    /// Power Lap Less Then
    case powerLapLessThen                   = 25
    /// Power Lap Greater Then
    case powerLapGreaterThen                = 26
    /// Repeat Until Training Peaks TSS
    case repeatUntilTrainingPeaksTss        = 27
    /// Repetition Time
    case repetitionTime                     = 28
    /// Reps
    case repetitions                        = 29

    /// Invalid
    case invalid                            = 255
}

// MARK: - FitFieldCodeable
extension WorkoutStepDurationType: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
    }
    
    /// Decode FIT Field
    ///
    /// - Parameters:
    ///   - type: Type of Field
    ///   - data: Data to Decode
    ///   - base: BaseTypeData
    ///   - arch: Endian
    /// - Returns: Decoded Value
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return WorkoutStepDurationType(rawValue: value) as? T
        }
        
        return nil
    }
}
