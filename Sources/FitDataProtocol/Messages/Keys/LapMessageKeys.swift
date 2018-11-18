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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension LapMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
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
        /// Average Vam
        case averageVam                             = 121

        /// Timestamp
        case timestamp                              = 253
        /// Message Index
        case messageIndex                           = 254
    }
}

public extension LapMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .event:
            return .enumtype
        case .eventType:
            return .enumtype
        case .startTime:
            return .uint32
        case .startPositionLat:
            return .sint32
        case .startPositionLong:
            return .sint32
        case .endPositionLat:
            return .sint32
        case .endPositionLong:
            return .sint32
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
        case .intensity:
            return .enumtype
        case .lapTrigger:
            return .enumtype
        case .sport:
            return .enumtype
        case .eventGroup:
            return .uint8
        case .lengths:
            return .uint16
        case .normalizedPower:
            return .uint16
        case .leftRightBalance:
            return .uint16
        case .firstLengthIndex:
            return .uint16
        case .averageStrokeDistance:
            return .uint16
        case .swimStroke:
            return .enumtype
        case .subSport:
            return .enumtype
        case .activeLengths:
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
        case .timeInHrZone:
            return .uint32
        case .timeInSpeedZone:
            return .uint32
        case .timeInCadenceZone:
            return .uint32
        case .timeInPowerZone:
            return .uint32
        case .repetionNumber:
            return .uint16
        case .minimumAltitude:
            return .uint16
        case .minimumHeartRate:
            return .uint8
        case .workoutStepIndex:
            return .uint16
        case .opponentScore:
            return .uint16
        case .strokeCount:
            return .uint16
        case .zoneCount:
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
        case .totalFractionalCadence:
            return .uint8
        case .playerScore:
            return .uint16
        case .averageTotalHemoglobinConcentration:
            return .uint16
        case .minimumTotalHemoglobinConcentration:
            return .uint16
        case .maximumTotalHemoglobinConcentration:
            return .uint16
        case .averageSaturatedHemoglobinPercent:
            return .uint16
        case .minimumSaturatedHemoglobinPercent:
            return .uint16
        case .maximumSaturatedHemoglobinPercent:
            return .uint16
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
        case .timestamp:
            return .uint32
        case .messageIndex:
            return .uint16
        }
    }

}
