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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension RecordMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
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

public extension RecordMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .positionLatitude:
            return .sint32
        case .positionLongitude:
            return .sint32
        case .altitude:
            return .uint16
        case .heartRate:
            return .uint8
        case .cadence:
            return .uint8
        case .distance:
            return .uint32
        case .speed:
            return .uint16
        case .power:
            return .uint16
        case .compressedSpeedDistance:
            return .byte // 3
        case .grade:
            return .sint16
        case .resistance:
            return .uint8
        case .timeFromCourse:
            return .sint32
        case .cycleLength:
            return .uint8
        case .temperature:
            return .sint8
        case .speedOneSecondInterval:
            return .uint8 // 5
        case .cycles:
            return .uint8
        case .totalCycles:
            return .uint32
        case .compressedAccumulatedPower:
            return .uint16
        case .accumulatedPower:
            return .uint32
        case .leftRightBalance:
            return .uint8
        case .gpsAccuracy:
            return .uint8
        case .verticalSpeed:
            return .sint16
        case .calories:
            return .uint16
        case .verticalOscillation:
            return .uint16
        case .stanceTimePercent:
            return .uint16
        case .stanceTime:
            return .uint16
        case .activityType:
            return .enumtype
        case .leftTorqueEffectiveness:
            return .uint8
        case .rightTorqueEffectiveness:
            return .uint8
        case .leftPedalSmoothness:
            return .uint8
        case .rightPedalSmoothness:
            return .uint8
        case .combinedPedalSmoothness:
            return .uint8
        case .time128Second:
            return .uint8
        case .strokeType:
            return .enumtype
        case .zone:
            return .uint8
        case .ballSpeed:
            return .uint16
        case .cadence256:
            return .uint16
        case .fractionalCadence:
            return .uint8
        case .totalHemoglobinConcentration:
            return .uint16
        case .totalHemoglobinConcentrationMin:
            return .uint16
        case .totalHemoglobinConcentrationMax:
            return .uint16
        case .saturatedHemoglobinPercent:
            return .uint16
        case .saturatedHemoglobinPercentMin:
            return .uint16
        case .saturatedHemoglobinPercentMax:
            return .uint16
        case .deviceIndex:
            return .uint8
        case .enhancedSpeed:
            return .uint32
        case .enhancedAltitude:
            return .uint32
        case .timestamp:
            return .uint32
        }
    }

}
