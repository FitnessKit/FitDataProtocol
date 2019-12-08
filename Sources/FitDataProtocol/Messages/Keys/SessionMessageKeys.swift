//
//  SessionMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 10/13/18.
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
extension SessionMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {

//        /// Event
//        case event                                  = 0
//        /// Event Type
//        case eventType                              = 1
//        /// Start Time
//        case startTime                              = 2
//        /// Start Position Latitude
//        case startPositionLatitude                  = 3
//        /// Start Postion Longitude
//        case startPositionLongitude                 = 4
//        /// Sport
//        case sport                                  = 5
//        /// Sub Sport
//        case subSport                               = 6
//        /// Total Elapsed Time
//        case totalElapsedTime                       = 7
//        /// Total Timer Time
//        case totalTimerTime                         = 8
//        /// Total Distance
//        case totalDistance                          = 9
//        /// Total Cycles
//        case totalCycles                            = 10
//        /// Total Calories
//        case totalCalories                          = 11
//        /// Total Fat Calories
//        case totalFatCalories                       = 13
//        /// Average Speed
//        case averageSpeed                           = 14
//        /// Maximum Speed
//        case maximumSpeed                           = 15
//        /// Average Heart Rate
//        case averageHeartRate                       = 16
//        /// Maximum Heart Rate
//        case maximumHeartRate                       = 17
//        /// Average Cadence
//        case averageCadence                         = 18
//        /// Maximum Cadence
//        case maximumCadence                         = 19
//        /// Average Power
//        case averagePower                           = 20
//        /// Maximum Power
//        case maximumPower                           = 21
//        /// Total Ascent
//        case totalAscent                            = 22
//        /// Total Descent
//        case totalDescent                           = 23
//        /// Total Training Effect
//        case totalTrainingEffect                    = 24
//        /// First Lap Index
//        case firstLapIndex                          = 25
//        /// Number of Laps
//        case numberOfLaps                           = 26
//        /// Event Group
//        case eventGroup                             = 27
//        /// Trigger
//        case trigger                                = 28
//        /// NEC Latitude
//        case necLatitude                            = 29
//        /// NEC Longitude
//        case necLongitude                           = 30
//        /// SWC Latitude
//        case swcLatitude                            = 31
//        /// SWC Longitude
//        case swcLongitude                           = 32
//        /// Normalized Power
//        case normalizedPower                        = 34
//        /// Training Stress Score
//        case trainingStressScore                    = 35
//        /// Intensity Factor
//        case intensityFactor                        = 36
//        /// Left Right Balance
//        case leftRightBalance                       = 37
//        /// Average Stroke Count
//        case averageStrokeCount                     = 41
//        /// Average Stroke Distance
//        case averageStrokeDistance                  = 42
//        /// Swim Stroke
//        case swimStroke                             = 43
//        /// Pool Length
//        case poolLength                             = 44
//        /// Threshold Power
//        case thresholdPower                         = 45
//        /// Pool Length Unit
//        case poolLengthUnit                         = 46
//        /// Number Active Lengths
//        case numberActiveLengths                    = 47
//        /// Total Work
//        case totalWork                              = 48
//        /// Average Altitude
//        case averageAltitude                        = 49
//        /// Maximum Altitude
//        case maximumAltitude                        = 50
//        /// GPS Accuracy
//        case gpsAccuracy                            = 51
//        /// Average Grade
//        case averageGrade                           = 52
//        /// Average Positive Grade
//        case averagePositiveGrade                   = 53
//        /// Average Negative Grade
//        case averageNegitiveGrade                   = 54
//        /// Maximimum Positive Grade
//        case maximumPositiveGrade                   = 55
//        /// Maximum Negitive Grade
//        case maximumNegitiveGrade                   = 56
//        /// Average Temperature
//        case averageTemperature                     = 57
//        /// Maximum Temperature
//        case maximumTemperature                     = 58
//        /// Total Moving Time
//        case totalMovingTime                        = 59
//        /// Average Positive Vertical Speed
//        case averagePositiveVerticalSpeed           = 60
//        /// Average Negitive Vertical Speed
//        case averageNegitiveVerticalSpeed           = 61
//        /// Maximum Positive Vertical Speed
//        case maximumPositiveVerticalSpeed           = 62
//        /// Maximum Negitive Vertical Speed
//        case maximumNegitiveVerticalSpeed           = 63
//        /// Minimum Heart Rate
//        case minimumHeartRate                       = 64
//        /// Time in Heart Rate Zone
//        case timeInHeartRateZone                    = 65
//        /// Time in Speed Zone
//        case timeInSpeedZone                        = 66
//        /// Time in Cadence Zone
//        case timeInCadenceZone                      = 67
//        /// Time in Power Zone
//        case timeInPowerZone                        = 68
//        /// Average Lap Time
//        case averageLapTime                         = 69
//        /// Best Lap Index
//        case bestLapIndex                           = 70
//        /// Minimum Altitude
//        case minimumAltitude                        = 71
//        /// Player Score
//        case playerScore                            = 82
//        /// Opponent Score
//        case opponentScore                          = 83
//        /// Opponent Name
//        case opponentName                           = 84
//        /// Stroke Count
//        case strokeCount                            = 85
//        /// Zone Count
//        case zoneCount                              = 86
//        /// Maximum Ball Speed
//        case maximumBallSpeed                       = 87
//        /// Average Ball Speed
//        case averageBallSpeed                       = 88
//        /// Average Vertical Oscillation
//        case averageVerticalOscillation             = 89
//        /// Average Stance Time Percent
//        case averageStanceTimePercent               = 90
//        /// Average Stance Time
//        case averageStanceTime                      = 91
//        /// Average Fractional Cadence
//        case averageFractionalCadence               = 92
//        /// Maximum Fractional Cadence
//        case maximumFractionalCadence               = 93
//        /// Total Fractional Cycles
//        case totalFractionalCycles                  = 94
//        /// Sport Index
//        case sportIndex                             = 111
//        /// Enhanced Average Speed
//        case enhancedAverageSpeed                   = 124
//        /// Enhanced Maximum Speed
//        case enhancedMaximumSpeed                   = 125
//        /// Enhanced Average Altitude
//        case enhancedAverageAltitude                = 126
//        /// Enhanced Minimum Altitude
//        case enhancedMinimumAltitude                = 127
//        /// Enhanced Maximum Altitude
//        case enhancedMaximumAltitude                = 128
//        /// Total Anaerobic Training Effect
//        case totalAnaerobicTrainingEffect           = 137
        /// Average VAM
        case averageVam                             = 139
    }
}

extension SessionMessage.FitCodingKeys: BaseTypeable {
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
//        case .event:
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .eventType:
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .startTime:
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .startPositionLatitude:
//            // 1 * semicircles + 0
//            return BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .startPositionLongitude:
//            // 1 * semicircles + 0
//            return BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .sport:
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .subSport:
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalElapsedTime:
//            // 1000 * s + 0, Time (includes pauses)
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .totalTimerTime:
//            // 1000 * s + 0, Timer Time (excludes pauses)
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .totalDistance:
//            // 100 * m + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .totalCycles:
//            // 1 * cycles + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalCalories:
//            // 1 * kcal + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalFatCalories:
//            // 1 * kcal + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .averageSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .maximumSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .averageHeartRate:
//            // 1 * bpm + 0
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .maximumHeartRate:
//            // 1 * bpm + 0
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .averageCadence:
//            // 1 * rpm + 0
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .maximumCadence:
//            // 1 * rpm + 0
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .averagePower:
//            // 1 * watts + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .maximumPower:
//            // 1 * watts + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalAscent:
//            // 1 * m + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalDescent:
//            // 1 * m + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalTrainingEffect:
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .firstLapIndex:
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .numberOfLaps:
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .eventGroup:
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .trigger:
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .necLatitude:
//            // 1 * semicircles + 0
//            return BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .necLongitude:
//            // 1 * semicircles + 0
//            return BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .swcLatitude:
//            // 1 * semicircles + 0
//            return BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .swcLongitude:
//            // 1 * semicircles + 0
//            return BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .normalizedPower:
//            // 1 * watts + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .trainingStressScore:
//            // 10 * tss + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
//        case .intensityFactor:
//            // 1000 * if + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .leftRightBalance:
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .averageStrokeCount:
//            // 10 * strokes/lap + 0  (WE SHOULD ADD THIS TO CAD)
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 10.0, offset: 0.0))
//        case .averageStrokeDistance:
//            // 100 * m + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .swimStroke:
//            // 1 * swim_stroke + 0
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .poolLength:
//            // 100 * m + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .thresholdPower:
//            // 1 * watts + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .poolLengthUnit:
//            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .numberActiveLengths:
//            // 1 * lengths + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalWork:
//            // 1 * J + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .averageAltitude:
//            // 5 * m + 500
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
//        case .maximumAltitude:
//            // 5 * m + 500
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
//        case .gpsAccuracy:
//            // 1 * m + 0
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .averageGrade:
//            // 100 * % + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .averagePositiveGrade:
//            // 100 * % + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .averageNegitiveGrade:
//            // 100 * % + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .maximumPositiveGrade:
//            // 100 * % + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .maximumNegitiveGrade:
//            // 100 * % + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .averageTemperature:
//            // 1 * C + 0
//            return BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .maximumTemperature:
//            // 1 * C + 0
//            return BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .totalMovingTime:
//            // 1000 * s + 0,
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .averagePositiveVerticalSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .averageNegitiveVerticalSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .maximumPositiveVerticalSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .maximumNegitiveVerticalSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .minimumHeartRate:
//            // 1 * bpm + 0
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .timeInHeartRateZone:
//            // 1000 * s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .timeInSpeedZone:
//            // 1000 * s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .timeInCadenceZone:
//            // 1000 * s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .timeInPowerZone:
//            // 1000 * s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .averageLapTime:
//            // 1000 * s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .bestLapIndex:
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .minimumAltitude:
//            // 5 * m + 500
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0))
//        case .playerScore:
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .opponentScore:
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .opponentName:
//            //1
//            return BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .strokeCount:
//            // 1 * counts + 0, stroke_type enum used as the index
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .zoneCount:
//            // 1 * counts + 0, zone number used as the index
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .maximumBallSpeed:
//            // 100 * m/s + 0,
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .averageBallSpeed:
//            // 100 * m/s + 0,
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .averageVerticalOscillation:
//            // 10 * mm + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
//        case .averageStanceTimePercent:
//            // 100 * percent + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
//        case .averageStanceTime:
//            // 10 * ms + 0
//            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
//        case .averageFractionalCadence:
//            // 128 * rpm + 0, fractional part of the avg_cadence
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
//        case .maximumFractionalCadence:
//            // 128 * rpm + 0, fractional part of the max_cadence
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
//        case .totalFractionalCycles:
//            // 128 * cycles + 0, fractional part of the total_cycles
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0))
//        case .sportIndex:
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
//        case .enhancedAverageSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .enhancedMaximumSpeed:
//            // 1000 * m/s + 0
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
//        case .enhancedAverageAltitude:
//            // 5 * m + 500
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
//        case .enhancedMinimumAltitude:
//            // 5 * m + 500
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
//        case .enhancedMaximumAltitude:
//            // 5 * m + 500
//            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0))
//        case .totalAnaerobicTrainingEffect:
//            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .averageVam:
            // 1000 * m/s + 0,
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        }
    }
}

extension SessionMessage.FitCodingKeys: KeyedEncoder {}

// Display Types Encoding
extension SessionMessage.FitCodingKeys: KeyedEncoderDisplayType {}

// Encoding
internal extension SessionMessage.FitCodingKeys {

    func encodeKeyed(value: SessionTrigger) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    func encodeKeyed(value: SwimStroke) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }
}

// Event Encoding
extension SessionMessage.FitCodingKeys: KeyedEncoderEvent {}

// Sport Encoder
extension SessionMessage.FitCodingKeys: KeyedEncoderSport {}

extension SessionMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
