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

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension SessionMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey {
        /// Event
        case event                                  = 0
        /// Event Type
        case eventType                              = 1
        /// Start Time
        case startTime                              = 2
        /// Start Position Latitude
        case startPositionLatitude                  = 3
        /// Start Postion Longitude
        case startPositionLongitude                 = 4
        /// Sport
        case sport                                  = 5
        /// Sub Sport
        case subSport                               = 6
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
        case totalFatCalories                       = 13
        /// Average Speed
        case averageSpeed                           = 14
        /// Maximum Speed
        case maximumSpeed                           = 15
        /// Average Heart Rate
        case averageHeartRate                       = 16
        /// Maximum Heart Rate
        case maximumHeartRate                       = 17
        /// Average Cadence
        case averageCadence                         = 18
        /// Maximum Cadence
        case maximumCadence                         = 19
        /// Average Power
        case averagePower                           = 20
        /// Maximum Power
        case maximumPower                           = 21
        /// Total Ascent
        case totalAscent                            = 22
        /// Total Descent
        case totalDescent                           = 23
        /// Total Training Effect
        case totalTrainingEffect                    = 24
        /// First Lap Index
        case firstLapIndex                          = 25
        /// Number of Laps
        case numberOfLaps                           = 26
        /// Event Group
        case eventGroup                             = 27
        /// Trigger
        case trigger                                = 28
        /// NEC Latitude
        case necLatitude                            = 29
        /// NEC Longitude
        case necLongitude                           = 30
        /// SWC Latitude
        case swcLatitude                            = 31
        /// SWC Longitude
        case swcLongitude                           = 32
        /// Normalized Power
        case normalizedPower                        = 34
        /// Training Stress Score
        case trainingStressScore                    = 35
        /// Intensity Factor
        case intensityFactor                        = 36
        /// Left Right Balance
        case leftRightBalance                       = 37
        /// Average Stroke Count
        case averageStrokeCount                     = 41
        /// Average Stroke Distance
        case averageStrokeDistance                  = 42
        /// Swim Stroke
        case swimStroke                             = 43
        /// Pool Length
        case poolLength                             = 44
        /// Threshold Power
        case thresholdPower                         = 45
        /// Pool Length Unit
        case poolLengthUnit                         = 46
        /// Number Active Lengths
        case numberActiveLengths                    = 47
        /// Total Work
        case totalWork                              = 48
        /// Average Altitude
        case averageAltitude                        = 49
        /// Maximum Altitude
        case maximumAltitude                        = 50
        /// GPS Accuracy
        case gpsAccuracy                            = 51
        /// Average Grade
        case averageGrade                           = 52
        /// Average Positive Grade
        case averagePositiveGrade                   = 53
        /// Average Negative Grade
        case averageNegitiveGrade                   = 54
        /// Maximimum Positive Grade
        case maximumPositiveGrade                   = 55
        /// Maximum Negitive Grade
        case maximumNegitiveGrade                   = 56
        /// Average Temperature
        case averageTemperature                     = 57
        /// Maximum Temperature
        case maximumTemperature                     = 58
        /// Total Moving Time
        case totalMovingTime                        = 59
        /// Average Positive Vertical Speed
        case averagePositiveVerticalSpeed           = 60
        /// Average Negitive Vertical Speed
        case averageNegitiveVerticalSpeed           = 61
        /// Maximum Positive Vertical Speed
        case maximumPositiveVerticalSpeed           = 62
        /// Maximum Negitive Vertical Speed
        case maximumNegitiveVerticalSpeed           = 63
        /// Minimum Heart Rate
        case minimumHeartRate                       = 64
        /// Time in Heart Rate Zone
        case timeInHeartRateZone                    = 65
        /// Time in Speed Zone
        case timeInSpeedZone                        = 66
        /// Time in Cadence Zone
        case timeInCadenceZone                      = 67
        /// Time in Power Zone
        case timeInPowerZone                        = 68
        /// Average Lap Time
        case averageLapTime                         = 69
        /// Best Lap Index
        case bestLapIndex                           = 70
        /// Minimum Altitude
        case minimumAltitude                        = 71
        /// Player Score
        case playerScore                            = 82
        /// Opponent Score
        case opponentScore                          = 83
        /// Opponent Name
        case opponentName                           = 84
        /// Stroke Count
        case strokeCount                            = 85
        /// Zone Count
        case zoneCount                              = 86
        /// Maximum Ball Speed
        case maximumBallSpeed                       = 87
        /// Average Ball Speed
        case averageBallSpeed                       = 88
        /// Average Vertical Oscillation
        case averageVerticalOscillation             = 89
        /// Average Stance Time Percent
        case averageStanceTimePercent               = 90
        /// Average Stance Time
        case averageStanceTime                      = 91
        /// Average Fractional Cadence
        case averageFractionalCadence               = 92
        /// Maximum Fractional Cadence
        case maximumFractionalCadence               = 93
        /// Total Fractional Cycles
        case totalFractionalCycles                  = 94
        /// Sport Index
        case sportIndex                             = 111
        /// Enhanced Average Speed
        case enhancedAverageSpeed                   = 124
        /// Enhanced Maximum Speed
        case enhancedMaximumSpeed                   = 125
        /// Enhanced Average Altitude
        case enhancedAverageAltitude                = 126
        /// Enhanced Minimum Altitude
        case enhancedMinimumAltitude                = 127
        /// Enhanced Maximum Altitude
        case enhancedMaximumAltitude                = 128
        /// Average VAM
        case averageVam                             = 130
        /// Total Anaerobic Training Effect
        case totalAnaerobicTrainingEffect           = 137

        /// Timestamp
        case timestamp                              = 253
        /// Message Index
        case messageIndex                           = 254
    }
}

public extension SessionMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .event:
            return .enumtype
        case .eventType:
            return .enumtype
        case .startTime:
            return .uint32
        case .startPositionLatitude:
            return .sint32
        case .startPositionLongitude:
            return .sint32
        case .sport:
            return .enumtype
        case .subSport:
            return .enumtype
        case .totalElapsedTime:
            return .uint32
        case .totalTimerTime:
            return .uint32
        case .totalDistance:
            return .uint32
        case .totalCycles:
            return .uint32
        case .totalCalories:
            return .uint16
        case .totalFatCalories:
            return .uint16
        case .averageSpeed:
            return .uint16
        case .maximumSpeed:
            return .uint16
        case .averageHeartRate:
            return .uint8
        case .maximumHeartRate:
            return .uint8
        case .averageCadence:
            return .uint8
        case .maximumCadence:
            return .uint8
        case .averagePower:
            return .uint16
        case .maximumPower:
            return .uint16
        case .totalAscent:
            return .uint16
        case .totalDescent:
            return .uint16
        case .totalTrainingEffect:
            return .uint8
        case .firstLapIndex:
            return .uint16
        case .numberOfLaps:
            return .uint16
        case .eventGroup:
            return .uint8
        case .trigger:
            return .enumtype
        case .necLatitude:
            return .sint32
        case .necLongitude:
            return .sint32
        case .swcLatitude:
            return .sint32
        case .swcLongitude:
            return .sint32
        case .normalizedPower:
            return .uint16
        case .trainingStressScore:
            return .uint16
        case .intensityFactor:
            return .uint16
        case .leftRightBalance:
            return .uint16
        case .averageStrokeCount:
            return .uint32
        case .averageStrokeDistance:
            return .uint16
        case .swimStroke:
            return .enumtype
        case .poolLength:
            return .uint16
        case .thresholdPower:
            return .uint16
        case .poolLengthUnit:
            return .enumtype
        case .numberActiveLengths:
            return .uint16
        case .totalWork:
            return .uint32
        case .averageAltitude:
            return .uint16
        case .maximumAltitude:
            return .uint16
        case .gpsAccuracy:
            return .uint8
        case .averageGrade:
            return .sint16
        case .averagePositiveGrade:
            return .sint16
        case .averageNegitiveGrade:
            return .sint16
        case .maximumPositiveGrade:
            return .sint16
        case .maximumNegitiveGrade:
            return .sint16
        case .averageTemperature:
            return .sint8
        case .maximumTemperature:
            return .sint8
        case .totalMovingTime:
            return .uint32
        case .averagePositiveVerticalSpeed:
            return .sint16
        case .averageNegitiveVerticalSpeed:
            return .sint16
        case .maximumPositiveVerticalSpeed:
            return .sint16
        case .maximumNegitiveVerticalSpeed:
            return .sint16
        case .minimumHeartRate:
            return .uint8
        case .timeInHeartRateZone:
            return .uint32
        case .timeInSpeedZone:
            return .uint32
        case .timeInCadenceZone:
            return .uint32
        case .timeInPowerZone:
            return .uint32
        case .averageLapTime:
            return .uint32
        case .bestLapIndex:
            return .uint16
        case .minimumAltitude:
            return .uint16
        case .playerScore:
            return .uint16
        case .opponentScore:
            return .uint16
        case .opponentName:
            return .string  //1
        case .strokeCount:
            return .uint16
        case .zoneCount:
            return .uint16
        case .maximumBallSpeed:
            return .uint16
        case .averageBallSpeed:
            return .uint16
        case .averageVerticalOscillation:
            return .uint16
        case .averageStanceTimePercent:
            return .uint16
        case .averageStanceTime:
            return .uint16
        case .averageFractionalCadence:
            return .uint8
        case .maximumFractionalCadence:
            return .uint8
        case .totalFractionalCycles:
            return .uint8
        case .sportIndex:
            return .uint8
        case .enhancedAverageSpeed:
            return .uint32
        case .enhancedMaximumSpeed:
            return .uint32
        case .enhancedAverageAltitude:
            return .uint32
        case .enhancedMinimumAltitude:
            return .uint32
        case .enhancedMaximumAltitude:
            return .uint32
        case .averageVam:
            return .uint16
        case .totalAnaerobicTrainingEffect:
            return .uint8
        case .timestamp:
            return .uint32
        case .messageIndex:
            return .uint16
        }
    }

}
