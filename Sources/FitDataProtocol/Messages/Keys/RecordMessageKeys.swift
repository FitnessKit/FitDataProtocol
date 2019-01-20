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
import AntMessageProtocol
import FitnessUnits

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension RecordMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp                          = 253

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
    }
}

public extension RecordMessage.FitCodingKeys {
    /// Key Base Type
    public var baseType: BaseType { return self.baseData.type }
}

internal extension RecordMessage.FitCodingKeys {

    /// Key Base Type
    internal var baseData: BaseData {
        switch self {
        case .timestamp:
            // 1 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))

        case .positionLatitude:
            // 1 * semicircles + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .positionLongitude:
            // 1 * semicircles + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .altitude:
            // 5 * m + 500
            return BaseData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .heartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .cadence:
            // 1 * rpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .distance:
            // 100 * m + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .speed:
            // 1000 * m/s + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .power:
            // 1 * watts + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .compressedSpeedDistance:
            // 3 typical units
            return BaseData(type: .byte, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .grade:
            // 100 * % + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .resistance:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .timeFromCourse:
            // 1000 * s + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .cycleLength:
            // 100 * m + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .temperature:
            // 1 * C + 0
            return BaseData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .speedOneSecondInterval:
            // 16 * m/s + 0
            // 5 units typical
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .cycles:
            // 1 * cycles + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalCycles:
            // 1 * cycles + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .compressedAccumulatedPower:
            // 1 * watts + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .accumulatedPower:
            // 1 * watts + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .leftRightBalance:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .gpsAccuracy:
            // 1 * m + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .verticalSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .calories:
            // 1 * kcal + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .verticalOscillation:
            // 10 * mm + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .stanceTimePercent:
            // 100 * percent + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .stanceTime:
            // 10 * ms + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .activityType:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .leftTorqueEffectiveness:
            // 2 * percent + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0))
        case .rightTorqueEffectiveness:
            // 2 * percent + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0))
        case .leftPedalSmoothness:
            // 2 * percent + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0))
        case .rightPedalSmoothness:
            // 2 * percent + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0))
        case .combinedPedalSmoothness:
            // 2 * percent + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0))
        case .time128Second:
            // 128 * s + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
        case .strokeType:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .zone:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .ballSpeed:
            // 100 * m/s + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .cadence256:
            // 256 * rpm + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 256.0, offset: 0.0))
        case .fractionalCadence:
            // 128 * rpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
        case .totalHemoglobinConcentration:
            // 100 * g/dL + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .totalHemoglobinConcentrationMin:
            // 100 * g/dL + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .totalHemoglobinConcentrationMax:
            // 100 * g/dL + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .saturatedHemoglobinPercent:
            // 10 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .saturatedHemoglobinPercentMin:
            // 10 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .saturatedHemoglobinPercentMax:
            // 10 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .deviceIndex:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .enhancedSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .enhancedAltitude:
            // 5 * m + 500
            return BaseData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
        }
    }
}

// Encoding
internal extension RecordMessage.FitCodingKeys {

//    internal func encodeKeyed(value: Intensity) throws -> Data {
//        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
//    }
//
//    internal func encodeKeyed(value: LapTrigger) throws -> Data {
//        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
//    }
//
    //    internal func encodeKeyed(value: SwimStroke) throws -> Data {
    //        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    //    }

    internal func encodeKeyed(value: ActivityType) throws -> Data {
        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: Stroke) throws -> Data {
        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }
}

// Encoding
internal extension RecordMessage.FitCodingKeys {

    internal func encodeKeyed(value: Event) throws -> Data {
        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: EventType) throws -> Data {
        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }
}

// Encoding
extension RecordMessage.FitCodingKeys: KeyedEncoder {

    internal func encodeKeyed(value: Bool) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: UInt8) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt8>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: UInt16) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt16>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: UInt32) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt32>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }

    internal func encodeKeyed(value: Double) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.baseData.resolution)
    }
}


internal extension RecordMessage.FitCodingKeys {

    /// Create a Field Definition Message From the Key
    ///
    /// - Parameter size: Data Size, if nil will use the keys predefined size
    /// - Returns: FieldDefinition
    internal func fieldDefinition(size: UInt8) -> FieldDefinition {

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: UInt8(self.rawValue),
                                              size: size,
                                              endianAbility: self.baseType.hasEndian,
                                              baseType: self.baseType)

        return fieldDefinition
    }

    /// Create a Field Definition Message From the Key
    ///
    /// - Returns: FieldDefinition
    internal func fieldDefinition() -> FieldDefinition {

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: UInt8(self.rawValue),
                                              size: self.baseType.dataSize,
                                              endianAbility: self.baseType.hasEndian,
                                              baseType: self.baseType)

        return fieldDefinition
    }
}
