//
//  LapMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 10/12/18.
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
extension LapMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Message Index
        case messageIndex                           = 254
        /// Timestamp
        case timestamp                              = 253

        /// Event
        case event                                  = 0
        /// Event Type
        case eventType                              = 1
        /// Start Time
        case startTime                              = 2
        /// Start Postion Lat
        case startPositionLat                       = 3
        /// Start Position Long
        case startPositionLong                      = 4
        /// End Position Lat
        case endPositionLat                         = 5
        /// End Position Long
        case endPositionLong                        = 6
        /// Total Elapsed Time
        case totalElapsedTime                       = 7
        /// Total Timer Time
        case totalTimerTime                         = 8
        /// Total Distance
        case totalDistance                          = 9
        /// Total Cycles
        case totalCycles                            = 10
        /// Total Calories
        case totalCalories                          = 11
        /// Total Fat Calories
        case totalFatCalories                       = 12
        /// Avg Speed
        case averageSpeed                           = 13
        /// Max Speed
        case maximumSpeed                           = 14
        /// Average Heart Rate
        case averageHeartRate                       = 15
        /// Maximum Heart Rate
        case maximumHeartRate                       = 16
        /// Average Cadence
        case averageCadence                         = 17
        /// Maximum Cadence
        case maximumCadence                         = 18
        /// Avg Power
        case averagePower                           = 19
        /// Max Power
        case maximumPower                           = 20
        /// Total Ascent
        case totalAscent                            = 21
        /// Total Descent
        case totalDescent                           = 22
        /// Intensity
        case intensity                              = 23
        /// Lap Trigger
        case lapTrigger                             = 24
        /// Sport
        case sport                                  = 25
        /// Event Group
        case eventGroup                             = 26
        /// Lengths
        case lengths                                = 32
        /// Normalized Power
        case normalizedPower                        = 33
        /// Left Right Balance
        case leftRightBalance                       = 34
        /// First Length Index
        case firstLengthIndex                       = 35
        /// Avg Stroke Distance
        case averageStrokeDistance                  = 37
        /// Swim Stroke
        case swimStroke                             = 38
        /// Sub Sport
        case subSport                               = 39
        /// Active Lengths
        case activeLengths                          = 40
        /// Total Work
        case totalWork                              = 41
        /// Avg Altitude
        case averageAltitude                        = 42
        /// Max Altitude
        case maximumAltitude                        = 43
        /// GPS Accuracy
        case gpsAccuracy                            = 44
        /// Avg Grade
        case averageGrade                           = 45
        /// Avg Pos Grade
        case averagePositiveGrade                   = 46
        /// Avg Negitive Grade
        case averageNegitiveGrade                   = 47
        /// Max Positive Grade
        case maximumPositiveGrade                   = 48
        /// Max Negitive Grade
        case maximumNegitiveGrade                   = 49
        /// Average Temperature
        case averageTemperature                     = 50
        /// Maximum Temperature
        case maximumTemperature                     = 51
        /// Total Moving Time
        case totalMovingTime                        = 52
        /// Avg Positive Vertical Speed
        case averagePositiveVerticalSpeed           = 53
        /// Avg Negitive Vertical Speed
        case averageNegitiveVerticalSpeed           = 54
        /// Max Positive Vertical Speed
        case maximumPositiveVerticalSpeed           = 55
        /// Max Negitive Vertical Speed
        case maximumNegitiveVerticalSpeed           = 56
        /// Time in Hr Zone
        case timeInHrZone                           = 57
        /// Time in Speed Zone
        case timeInSpeedZone                        = 58
        /// Time in Cadence Zone
        case timeInCadenceZone                      = 59
        /// Time in Power Zone
        case timeInPowerZone                        = 60
        /// Repetition Number
        case repetionNumber                         = 61
        /// Min Altitude
        case minimumAltitude                        = 62
        /// Minimum Heart Rate
        case minimumHeartRate                       = 63
        /// Workout Step Index
        case workoutStepIndex                       = 71
        /// Opponent Score
        case opponentScore                          = 74
        /// Stroke Count
        case strokeCount                            = 75
        /// Zone Count
        case zoneCount                              = 76
        /// Average Vertical Oscillation
        case averageVerticalOscillation             = 77
        /// Average Stance Time Percent
        case averageStanceTimePercent               = 78
        /// Average Stance Time
        case averageStanceTime                      = 79
        /// Average Fractional Cadence
        case averageFractionalCadence               = 80
        /// Maximum Fractional Cadence
        case maximumFractionalCadence               = 81
        /// Total Fractional Cadence
        case totalFractionalCadence                 = 82
        /// Player Score
        case playerScore                            = 83
        /// Average Total Hemoglobin Concentration
        case averageTotalHemoglobinConcentration    = 84
        /// Minimum Total Hemoglobin Concentration
        case minimumTotalHemoglobinConcentration    = 85
        /// Maximum Total Hemoglobin Concentration
        case maximumTotalHemoglobinConcentration    = 86
        /// Average Saturated Hemoglobin Percent
        case averageSaturatedHemoglobinPercent      = 87
        /// Minimum Saturated Hemoglobin Percent
        case minimumSaturatedHemoglobinPercent      = 88
        /// Maximum Saturated Hemoglobin Percent
        case maximumSaturatedHemoglobinPercent      = 89
        /// Enhanced Avg Speed
        case enhancedAverageSpeed                   = 110
        /// Enhanced Max Speed
        case enhancedMaximumSpeed                   = 111
        /// Enhanced Avg Altitude
        case enhancedAverageAltitude                = 112
        /// Enhanced Min Altitude
        case enhancedMinimumAltitude                = 113
        /// Enhanced Max Altitude
        case enhancedMaximumAltitude                = 114
        /// Average Vam (average ascent speed)
        case averageVam                             = 121

    }
}

extension LapMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    /// Key Base Resolution
    var resolution: Resolution { return self.baseData.resolution }
    
    /// Key Base Data
    var baseData: BaseData {
        switch self {
        case .messageIndex:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .timestamp:
            // 1 * s + 0, Lap end time
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .event:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .eventType:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .startTime:
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .startPositionLat:
            // 1 * semicircles + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .startPositionLong:
            // 1 * semicircles + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .endPositionLat:
            // 1 * semicircles + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .endPositionLong:
            // 1 * semicircles + 0
            return BaseData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalElapsedTime:
            // 1000 * s + 0, Time (includes pauses)
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .totalTimerTime:
            // 1000 * s + 0, Time (excludes pauses)
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .totalDistance:
            // 100 * m + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .totalCycles:
            // 1 * cycles + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalCalories:
            // 1 * kcal + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalFatCalories:
            // 1 * kcal + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .maximumSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .averageHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .maximumHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageCadence:
            // 1 * rpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .maximumCadence:
            // 1 * rpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averagePower:
            // 1 * watts + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .maximumPower:
            // 1 * watts + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalAscent:
            // 1 * m + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalDescent:
            // 1 * m + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .intensity:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .lapTrigger:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .sport:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .eventGroup:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .lengths:
            // 1 * lengths + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .normalizedPower:
            // 1 * watts + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .leftRightBalance:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .firstLengthIndex:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageStrokeDistance:
            // 100 * m + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .swimStroke:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .subSport:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .activeLengths:
            // 1 * lengths + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalWork:
            // 1 * J + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageAltitude:
            // 5 * m + 500
            return BaseData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .maximumAltitude:
            // 5 * m + 500
            return BaseData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .gpsAccuracy:
            // 1 * m + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageGrade:
            // 100 * % + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .averagePositiveGrade:
            // 100 * % + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .averageNegitiveGrade:
            // 100 * % + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .maximumPositiveGrade:
            // 100 * % + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .maximumNegitiveGrade:
            // 100 * % + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .averageTemperature:
            // 1 * C + 0
            return BaseData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .maximumTemperature:
            // 1 * C + 0
            return BaseData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .totalMovingTime:
            // 1000 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .averagePositiveVerticalSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .averageNegitiveVerticalSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .maximumPositiveVerticalSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .maximumNegitiveVerticalSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .timeInHrZone:
            // 1000 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .timeInSpeedZone:
            // 1000 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .timeInCadenceZone:
            // 1000 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .timeInPowerZone:
            // 1000 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .repetionNumber:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .minimumAltitude:
            // 5 * m + 500
            return BaseData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .minimumHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .workoutStepIndex:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .opponentScore:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .strokeCount:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .zoneCount:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageVerticalOscillation:
            // 10 * mm + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .averageStanceTimePercent:
            // 100 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .averageStanceTime:
            // 10 * ms + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .averageFractionalCadence:
            // 128 * rpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
        case .maximumFractionalCadence:
            // 128 * rpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
        case .totalFractionalCadence:
            // 128 * cycles + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .playerScore:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageTotalHemoglobinConcentration:
            // 100 * g/dL + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .minimumTotalHemoglobinConcentration:
            // 100 * g/dL + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .maximumTotalHemoglobinConcentration:
            // 100 * g/dL + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .averageSaturatedHemoglobinPercent:
            // 10 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .minimumSaturatedHemoglobinPercent:
            // 10 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .maximumSaturatedHemoglobinPercent:
            // 10 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .enhancedAverageSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .enhancedMaximumSpeed:
            // 1000 * m/s + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .enhancedAverageAltitude:
            // 5 * m + 500
            return BaseData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .enhancedMinimumAltitude:
            // 5 * m + 500
            return BaseData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .enhancedMaximumAltitude:
            // 5 * m + 500
            return BaseData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
        case .averageVam:
            // 1000 * m/s + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        }
    }
}

extension LapMessage.FitCodingKeys: KeyedEncoder {}

// Encoding
internal extension LapMessage.FitCodingKeys {

    func encodeKeyed(value: Intensity) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }

    func encodeKeyed(value: LapTrigger) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }

    func encodeKeyed(value: SwimStroke) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}

// Event Encoding
extension LapMessage.FitCodingKeys: KeyedEncoderEvent {}

// Sport Encoding
extension LapMessage.FitCodingKeys: KeyedEncoderSport {}

extension LapMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
