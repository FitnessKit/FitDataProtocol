//
//  RecordMessageKeys.swift
//  AntMessageProtocol
//
//  Created by Kevin Hoogheem on 8/18/18.
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

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension RecordMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey {
        /// Position Latitude
        case positionLatitude                   = 0
        /// Position Longitude
        case positionLongitude                  = 1
        /// Altitude
        case altitude                           = 2
        /// Heart Rate
        case heartRate                          = 3
        /// Cadence
        case cadence                            = 4
        /// Distance
        case distance                           = 5
        /// Speed
        case speed                              = 6
        /// Power
        case power                              = 7
        /// Compressed Speed Distance
        case compressedSpeedDistance            = 8
        /// Grade
        case grade                              = 9
        /// Resistance
        case resistance                         = 10
        /// Time From Course
        case timeFromCourse                     = 11
        /// Cycle Length
        case cycleLength                        = 12
        /// Temperature
        case temperature                        = 13
        /// Speed 1s Intervals
        case speedOneSecondInterval             = 17
        /// Cycles
        case cycles                             = 18
        /// Total Cycles
        case totalCycles                        = 19
        /// Compressed Accumulated Power
        case compressedAccumulatedPower         = 28
        /// Accumulated Power
        case accumulatedPower                   = 29
        /// Left Right Balance
        case leftRightBalance                   = 30
        /// GPS Accuracy
        case gpsAccuracy                        = 31
        /// Vertical Speed
        case verticalSpeed                      = 32
        /// Calories
        case calories                           = 33
        /// Vertical Oscillation
        case verticalOscillation                = 39
        /// Stance Time as Percent
        case stanceTimePercent                  = 40
        /// Stance Time
        case stanceTime                         = 41
        /// Activity Type
        case activityType                       = 42
        /// Left Torque Effectiveness
        case leftTorqueEffectiveness            = 43
        /// Right Torque Effectiveness
        case rightTorqueEffectiveness           = 44
        /// Left Pedal Smoothness
        case leftPedalSmoothness                = 45
        /// Right Pedal Smoothness
        case rightPedalSmoothness               = 46
        /// Combined Pedal Smoothness
        case combinedPedalSmoothness            = 47
        /// Time 128 SEcond
        case time128Second                      = 48
        /// Stroke Type
        case strokeType                         = 49
        /// Zone
        case zone                               = 50
        /// Ball Speed
        case ballSpeed                          = 51
        /// Cadence 256
        case cadence256                         = 52
        /// Fractional Cadence
        case fractionalCadence                  = 53
        /// Total Hemoglobin Concentration
        case totalHemoglobinConcentration       = 54
        /// Total Hemoglobin Concentration Min
        case totalHemoglobinConcentrationMin    = 55
        /// Total Hemoglobin Concentration Max
        case totalHemoglobinConcentrationMax    = 56
        /// Saturated Hemoglobin Percent
        case saturatedHemoglobinPercent         = 57
        //// Saturated Hemoglobin Percent Min
        case saturatedHemoglobinPercentMin      = 58
        /// Saturated Hemoglobin Percent Max
        case saturatedHemoglobinPercentMax      = 59
        /// Device Index
        case deviceIndex                        = 62
        /// Enhanced Speed
        case enhancedSpeed                      = 73
        /// Enhanced Altitude
        case enhancedAltitude                   = 78

        /// Timestamp
        case timestamp                          = 253
    }
}
