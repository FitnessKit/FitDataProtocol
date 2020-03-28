//
//  SessionMessage.swift
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
import DataDecoder
import AntMessageProtocol
import FitnessUnits

/// FIT Session Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SessionMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 18 }
    
    /// Event
    ///
    /// - note: Event should be .session
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var event: Event?
    
    /// Event Type
    ///
    /// - note: EventType should be .stop
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var eventType: EventType?
    
    /// Start Time
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 2, local: false)
    private(set) public var startTime: FitTime?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitAngle.garminSemicircle)
    private var startLatitude: Measurement<UnitAngle>?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitAngle.garminSemicircle)
    private var startLongitude: Measurement<UnitAngle>?
    
    /// Start Position
    private(set) public var startPosition: Position? {
        get {
            return Position(latitude: self.startLatitude, longitude: self.startLongitude)
        }
        set {
            self.startLatitude = newValue?.latitude
            self.startLongitude = newValue?.longitude
        }
    }
    
    /// Sport
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var sport: Sport?
    
    /// Sub Sport
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var subSport: SubSport?
    
    /// Total Elapsed Time
    ///
    /// Includes pauses
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 7,
                       unit: UnitDuration.seconds)
    private(set) public var totalElapsedTime: Measurement<UnitDuration>?
    
    /// Total Timer Time
    ///
    /// Excludes pauses
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 8,
                       unit: UnitDuration.seconds)
    private(set) public var totalTimerTime: Measurement<UnitDuration>?
    
    /// Total Distance
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 9,
                       unit: UnitLength.meters)
    private(set) public var totalDistance: Measurement<UnitLength>?
    
    /// Total Cycles
    @FitFieldUnit(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 10,
                  unit: UnitCount.cycles)
    private(set) public var totalCycles: Measurement<UnitCount>?
    
    /// Total Calories
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 11,
                       unit: UnitEnergy.kilocalories)
    private(set) public var totalCalories: Measurement<UnitEnergy>?
    
    /// Total Fat Calories
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 13,
                       unit: UnitEnergy.kilocalories)
    private(set) public var totalFatCalories: Measurement<UnitEnergy>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 14,
                       unit: UnitSpeed.metersPerSecond)
    private var _averageSpeed: Measurement<UnitSpeed>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 124,
                       unit: UnitSpeed.metersPerSecond)
    private var enhancedAvgSpeed: Measurement<UnitSpeed>?
    
    /// Average Speed
    private(set) public var averageSpeed: Measurement<UnitSpeed>? {
        get {
            return preferredField(preferred: self.enhancedAvgSpeed, fallbakck: self._averageSpeed)
        }
        set {
            self.enhancedAvgSpeed = newValue
        }
    }
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 15,
                       unit: UnitSpeed.metersPerSecond)
    private var _maximumSpeed: Measurement<UnitSpeed>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 125,
                       unit: UnitSpeed.metersPerSecond)
    private var enhancedMaximumSpeed: Measurement<UnitSpeed>?
    
    /// Maximum Speed
    private(set) public var maximumSpeed: Measurement<UnitSpeed>? {
        get {
            return preferredField(preferred: self.enhancedMaximumSpeed, fallbakck: self._maximumSpeed)
        }
        set {
            self.enhancedMaximumSpeed = newValue
        }
    }
    
    /// Average Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 16,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var averageHeartRate: Measurement<UnitCadence>?
    
    /// Maximum Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 17,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var maximumHeartRate: Measurement<UnitCadence>?
    
    /// Average Cadence
    ///
    /// If nil you can use totalCycles / totalTimerTime
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 18,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var averageCadence: Measurement<UnitCadence>?
    
    /// Maximum Cadence
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 19,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var maximumCadence: Measurement<UnitCadence>?
    
    /// Average Power
    ///
    /// If nil you can use totalPower / totalTimerTime
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 20,
                       unit: UnitPower.watts)
    private(set) public var averagePower: Measurement<UnitPower>?
    
    /// Maximum Power
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 21,
                       unit: UnitPower.watts)
    private(set) public var maximumPower: Measurement<UnitPower>?
    
    /// Total Ascent
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 22,
                       unit: UnitLength.meters)
    private(set) public var totalAscent: Measurement<UnitLength>?
    
    /// Total Descent
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 23,
                       unit: UnitLength.meters)
    private(set) public var totalDescent: Measurement<UnitLength>?
    
    /// Total Training Effect
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 24)
    private(set) public var totalTrainingEffect: UInt8?
    
    /// First Lap Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 25)
    private(set) public var firstLapIndex: UInt16?
    
    /// Number of Laps
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 26,
                  unit: UnitCount.laps)
    private(set) public var numberOfLaps: Measurement<UnitCount>?
    
    /// Event Group
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 27)
    private(set) public var eventGroup: UInt8?
    
    /// Session Trigger
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 28)
    private(set) public var trigger: SessionTrigger?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 29,
                       unit: UnitAngle.garminSemicircle)
    private var necLatitude: Measurement<UnitAngle>?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 30,
                       unit: UnitAngle.garminSemicircle)
    private var necLongitude: Measurement<UnitAngle>?
    
    /// NEC Position
    private(set) public var necPosition: Position? {
        get {
            return Position(latitude: self.necLatitude, longitude: self.necLongitude)
        }
        set {
            self.necLatitude = newValue?.latitude
            self.necLongitude = newValue?.longitude
        }
    }
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 31,
                       unit: UnitAngle.garminSemicircle)
    private var swcLatitude: Measurement<UnitAngle>?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 32,
                       unit: UnitAngle.garminSemicircle)
    private var swcLongitude: Measurement<UnitAngle>?
    
    /// SWC Position
    private(set) public var swcPosition: Position? {
        get {
            return Position(latitude: self.swcLatitude, longitude: self.swcLongitude)
        }
        set {
            self.swcLatitude = newValue?.latitude
            self.swcLongitude = newValue?.longitude
        }
    }
    
    /// Normalized Power
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 34,
                       unit: UnitPower.watts)
    private(set) public var normalizedPower: Measurement<UnitPower>?
    
    /// Training Stress Score
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 35,
                  unit: UnitCount.trainingStress)
    private(set) public var trainingStressScore: Measurement<UnitCount>?
    
    /// Intensity Factor
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                  fieldNumber: 36,
                  unit: UnitCount.intensityFactor)
    private(set) public var intensityFactor: Measurement<UnitCount>?
    
    /// Left Right Balance scaled by 100
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 37)
    private(set) public var leftRightBalance: LeftRightBalance100?
    
    /// Average Stroke Count
    @FitFieldUnit(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 41,
                  unit: UnitCount.strokes)
    private(set) public var averageStrokeCount: Measurement<UnitCount>?
    
    /// Average Stroke Distance
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 42,
                       unit: UnitLength.meters)
    private(set) public var averageStrokeDistance: Measurement<UnitLength>?
    
    /// Swim Stroke
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 43)
    private(set) public var swimStroke: SwimStroke?
    
    /// Pool Length
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 44,
                       unit: UnitLength.meters)
    private(set) public var poolLength: Measurement<UnitLength>?
    
    /// Threshold Power
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 45,
                       unit: UnitPower.watts)
    private(set) public var thresholdPower: Measurement<UnitPower>?
    
    /// Pool Length Unit
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 46)
    private(set) public var poolLengthUnit: MeasurementDisplayType?
    
    /// Number of Active Lengths
    ///
    /// Number of active lengths of swim pool
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 47,
                  unit: UnitCount.lengths)
    private(set) public var activeLengths: Measurement<UnitCount>?
    
    /// Total Work
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 48,
                       unit: UnitEnergy.joules)
    private(set) public var totalWork: Measurement<UnitEnergy>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 49,
                       unit: UnitLength.meters)
    private var _averageAltitude: Measurement<UnitLength>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 126,
                       unit: UnitLength.meters)
    private var enhancedAverageAltitude: Measurement<UnitLength>?
    
    /// Average Altitude
    private(set) public var averageAltitude: Measurement<UnitLength>? {
        get {
            return preferredField(preferred: self.enhancedAverageAltitude, fallbakck: self._averageAltitude)
        }
        set {
            self.enhancedAverageAltitude = newValue
        }
    }
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 50,
                       unit: UnitLength.meters)
    private var _maximumAltitude: Measurement<UnitLength>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 128,
                       unit: UnitLength.meters)
    private var enhancedMaximumAltitude: Measurement<UnitLength>?
    
    /// Maximum Altitude
    private(set) public var maximumAltitude: Measurement<UnitLength>? {
        get {
            return preferredField(preferred: self.enhancedMaximumAltitude, fallbakck: self._maximumAltitude)
        }
        set {
            self.enhancedMaximumAltitude = newValue
        }
    }
    
    /// GPS Accuracy
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 51,
                       unit: UnitLength.meters)
    private(set) public var gpsAccuracy: Measurement<UnitLength>?
    
    /// Average Grade
    @FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 52,
                  unit: UnitPercent.percent)
    private(set) public var averageGrade: Measurement<UnitPercent>?
    
    /// Average Positive Grade
    @FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 53,
                  unit: UnitPercent.percent)
    private(set) public var averagePositiveGrade: Measurement<UnitPercent>?
    
    /// Average Negitive Grade
    @FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 54,
                  unit: UnitPercent.percent)
    private(set) public var averageNegitiveGrade: Measurement<UnitPercent>?
    
    /// Maximum Positive Grade
    @FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 55,
                  unit: UnitPercent.percent)
    private(set) public var maximumPositiveGrade: Measurement<UnitPercent>?
    
    /// Maximum Negitive Grade
    @FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 56,
                  unit: UnitPercent.percent)
    private(set) public var maximumNegitiveGrade: Measurement<UnitPercent>?
    
    /// Average Temperature
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 57,
                       unit: UnitTemperature.celsius)
    private(set) public var averageTemperature: Measurement<UnitTemperature>?
    
    /// Maximum Temperature
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 58,
                       unit: UnitTemperature.celsius)
    private(set) public var maximumTemperature: Measurement<UnitTemperature>?
    
    /// Total Moving Time
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 59,
                       unit: UnitDuration.seconds)
    private(set) public var totalMovingTime: Measurement<UnitDuration>?
    
    /// Average Positive Vertical Speed
    @FitFieldDimension(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 60,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var averagePositiveVerticalSpeed: Measurement<UnitSpeed>?
    
    /// Average Negitive Vertical Speed
    @FitFieldDimension(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 61,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var averageNegitiveVerticalSpeed: Measurement<UnitSpeed>?
    
    /// Maximum Positive Vertical Speed
    @FitFieldDimension(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 62,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var maximumPositiveVerticalSpeed: Measurement<UnitSpeed>?
    
    /// Maximum Negitive Vertical Speed
    @FitFieldDimension(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 63,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var maximumNegitiveVerticalSpeed: Measurement<UnitSpeed>?
    
    /// Minimum Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 64,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var minimumHeartRate: Measurement<UnitCadence>?
    
    /// Time in HeartRate Zone
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 65,
                       unit: UnitDuration.seconds)
    private(set) public var timeInHrZone: Measurement<UnitDuration>?
    
    /// Time in Speed Zone
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 66,
                       unit: UnitDuration.seconds)
    private(set) public var timeInSpeedZone: Measurement<UnitDuration>?
    
    /// Time in Cadence Zone
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 67,
                       unit: UnitDuration.seconds)
    private(set) public var timeInCadenceZone: Measurement<UnitDuration>?
    
    /// Time in Power Zone
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 68,
                       unit: UnitDuration.seconds)
    private(set) public var timeInPowerZone: Measurement<UnitDuration>?
    
    /// Average Lap Time
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 69,
                       unit: UnitDuration.seconds)
    private(set) public var averageLapTime: Measurement<UnitDuration>?
    
    /// Best Lap Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 70)
    private(set) public var bestLapIndex: UInt16?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 71,
                       unit: UnitLength.meters)
    private var _minimumAltitude: Measurement<UnitLength>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 127,
                       unit: UnitLength.meters)
    private var enhancedMinimumAltitude: Measurement<UnitLength>?
    
    /// Minimum Altitude
    private(set) public var minimumAltitude: Measurement<UnitLength>? {
        get {
            return preferredField(preferred: self.enhancedMinimumAltitude, fallbakck: self._minimumAltitude)
        }
        set {
            self.enhancedMinimumAltitude = newValue
        }
    }
    
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 82)
    private var opponentScore: UInt16?
    
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 83)
    private var playerScore: UInt16?
    
    /// Score Information
    ///
    /// Include Opponent Score, Player Score
    private(set) public var score: Score? {
        get {
            return Score(playerScore: self.playerScore, opponentScore: self.opponentScore)
        }
        set {
            self.playerScore = newValue?.playerScore
            self.opponentScore = newValue?.opponentScore
        }
    }
    
    /// Opponent Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 84)
    private(set) public var opponentName: String?
    
    /// Stroke Count
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 85,
                  unit: UnitCount.counts)
    private(set) public var strokeCount: Measurement<UnitCount>?
    
    /// Zone Count
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 86,
                  unit: UnitCount.counts)
    private(set) public var zoneCount: Measurement<UnitCount>?
    
    /// Maximum Ball Speed
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 87,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var maximumBallSpeed: Measurement<UnitSpeed>?
    
    /// Average Ball Speed
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 88,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var averageBallSpeed: Measurement<UnitSpeed>?
    
    /// Average Vertical Oscillation
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 89,
                       unit: UnitLength.millimeters)
    private(set) public var averageVerticalOscillation: Measurement<UnitLength>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 90,
                  unit: UnitPercent.percent)
    private var avgStanceTimePercent: Measurement<UnitPercent>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 91,
                       unit: UnitDuration.millisecond)
    private var avgStanceTimeDuration: Measurement<UnitDuration>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 133,
                  unit: UnitPercent.percent)
    private var avgStanceTimeBalance: Measurement<UnitPercent>?
    
    /// Average Stance Time
    private(set) public var averageStanceTime: StanceTime? {
        get {
            return StanceTime(percent: self.avgStanceTimePercent,
                              time: self.avgStanceTimeDuration,
                              balance: self.avgStanceTimeBalance)
        }
        set {
            self.avgStanceTimePercent = newValue?.percent
            self.avgStanceTimeDuration = newValue?.time
            self.avgStanceTimeBalance = newValue?.balance
        }
    }
    
    /// Average Fractional Cadence
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0)),
                  fieldNumber: 92,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var averageFractionalCadence: Measurement<UnitCadence>?
    
    /// Maximum Fractional Cadence
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0)),
                  fieldNumber: 93,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var maximumFractionalCadence: Measurement<UnitCadence>?
    
    /// Total Fractional Cadence
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0)),
                  fieldNumber: 94,
                  unit: UnitCount.cycles)
    private(set) public var totalFractionalCadence: Measurement<UnitCount>?
    
    /// Average Total Hemoglobin Concentration
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 95,
                       unit: UnitConcentrationMass.gramPerDeciliter)
    private(set) public var averageTotalHemoglobinConcentration: Measurement<UnitConcentrationMass>?
    
    /// Minimum Total Hemoglobin Concentration
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 96,
                       unit: UnitConcentrationMass.gramPerDeciliter)
    private(set) public var minimumTotalHemoglobinConcentration: Measurement<UnitConcentrationMass>?
    
    /// Maximum Total Hemoglobin Concentration
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 97,
                       unit: UnitConcentrationMass.gramPerDeciliter)
    private(set) public var maximumTotalHemoglobinConcentration: Measurement<UnitConcentrationMass>?
    
    /// Average Saturated Hemoglobin Percent
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 98,
                  unit: UnitPercent.percent)
    private(set) public var averageSaturatedHemoglobinPercent: Measurement<UnitPercent>?
    
    /// Minimum Saturated Hemoglobin Percent
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 99,
                  unit: UnitPercent.percent)
    private(set) public var minimumSaturatedHemoglobinPercent: Measurement<UnitPercent>?
    
    /// Maximum Saturated Hemoglobin Percent
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 100,
                  unit: UnitPercent.percent)
    private(set) public var maximumSaturatedHemoglobinPercent: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 101,
                  unit: UnitPercent.percent)
    private var avgLeftTorqueEffectiveness: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 102,
                  unit: UnitPercent.percent)
    private var avgRightTorqueEffectiveness: Measurement<UnitPercent>?
    
    /// Average Torque Effectiveness
    private(set) public var averageTorqueEffectiveness: TorqueEffectiveness? {
        get {
            return TorqueEffectiveness(left: self.avgLeftTorqueEffectiveness, right: self.avgRightTorqueEffectiveness)
        }
        set {
            self.avgLeftTorqueEffectiveness = newValue?.left
            self.avgRightTorqueEffectiveness = newValue?.right
        }
    }
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 103,
                  unit: UnitPercent.percent)
    private var avgLeftPedalSmoothness: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 104,
                  unit: UnitPercent.percent)
    private var avgRightPedalSmoothness: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 105,
                  unit: UnitPercent.percent)
    private var avgCombinedPedalSmoothness: Measurement<UnitPercent>?
    
    /// Average Pedal Smoothness
    private(set) public var averagePedalSmoothness: PedalSmoothness? {
        get {
            return PedalSmoothness(right: self.avgRightPedalSmoothness,
                                   left: self.avgLeftPedalSmoothness,
                                   combined: self.avgCombinedPedalSmoothness)
        }
        set {
            self.avgLeftPedalSmoothness = newValue?.left
            self.avgRightPedalSmoothness = newValue?.right
            self.avgCombinedPedalSmoothness = newValue?.combined
        }
    }
    
    /// Sport Group
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 111)
    private(set) public var sportIndex: UInt8?
    
    /// Time Standing
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 112,
                       unit: UnitDuration.seconds)
    private(set) public var timeStanding: Measurement<UnitDuration>?
    
    /// Stand Count
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 113)
    private(set) public var standCount: UInt16?
    
    /// Average Step Length
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 134,
                       unit: UnitLength.millimeters)
    private(set) public var averageStepLength: Measurement<UnitLength>?
    
    /// Total Anaerobic Training Effect
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 10.0, offset: 0.0)),
              fieldNumber: 137)
    private(set) public var totalAnaerobicTrainingEffect: UInt8?
    
    /// Velocità Ascensionale Media
    ///
    /// VAM - Average Ascent Speed
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 139,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var averageAscentSpeed: Measurement<UnitSpeed>?
    
    /// Total Grit
    ///
    /// The grit score estimates how challenging a route could be for a cyclist
    /// in terms of time spent going over sharp turns or large grade slopes
    @FitFieldUnit(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 181,
                  unit: UnitFitGrit.kiloGrit)
    private(set) public var totalGrit: Measurement<UnitFitGrit>?
    
    /// Total Flow
    ///
    /// The flow score estimates how long distance wise a cyclist deaccelerates over intervals
    /// where deacceleration is unnecessary such as smooth turns or small grade angle intervals
    @FitFieldUnit(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 182,
                  unit: UnitFitFlow.flow)
    private(set) public var totalFlow: Measurement<UnitFitFlow>?
    
    /// Jump Count
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 183,
                  unit: UnitCount.jumps)
    private(set) public var jumpCount: Measurement<UnitCount>?
    
    /// Average Grit
    ///
    /// The grit score estimates how challenging a route could be for a cyclist
    /// in terms of time spent going over sharp turns or large grade slopes
    @FitFieldUnit(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 186,
                  unit: UnitFitGrit.kiloGrit)
    private(set) public var averageGrit: Measurement<UnitFitGrit>?
    
    /// Average Flow
    ///
    /// The flow score estimates how long distance wise a cyclist deaccelerates over intervals
    /// where deacceleration is unnecessary such as smooth turns or small grade angle intervals
    @FitFieldUnit(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 187,
                  unit: UnitFitFlow.flow)
    private(set) public var averageFlow: Measurement<UnitFitFlow>?
    
    /// Timestamp
    ///
    /// Sesson end time
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 254)
    private(set) public var messageIndex: MessageIndex?
    
    
    ///sportIndex
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        self.$messageIndex.owner = self
        
        self.$event.owner = self
        self.$eventType.owner = self
        self.$startTime.owner = self
        self.$startLatitude.owner = self
        self.$startLongitude.owner = self
        self.$sport.owner = self
        self.$subSport.owner = self
        self.$totalElapsedTime.owner = self
        self.$totalTimerTime.owner = self
        self.$totalDistance.owner = self
        self.$totalCycles.owner = self
        self.$totalCalories.owner = self
        self.$totalFatCalories.owner = self
        self.$_averageSpeed.owner = self
        self.$enhancedAvgSpeed.owner = self
        self.$_maximumSpeed.owner = self
        self.$enhancedMaximumSpeed.owner = self
        self.$averageHeartRate.owner = self
        self.$maximumHeartRate.owner = self
        self.$averageCadence.owner = self
        self.$maximumCadence.owner = self
        self.$averagePower.owner = self
        self.$maximumPower.owner = self
        self.$totalAscent.owner = self
        self.$totalTrainingEffect.owner = self
        self.$firstLapIndex.owner = self
        self.$numberOfLaps.owner = self
        self.$eventGroup.owner = self
        self.$trigger.owner = self
        self.$necLatitude.owner = self
        self.$necLongitude.owner = self
        self.$swcLatitude.owner = self
        self.$swcLongitude.owner = self
        self.$normalizedPower.owner = self
        self.$trainingStressScore.owner = self
        self.$intensityFactor.owner = self
        self.$leftRightBalance.owner = self
        self.$averageStrokeCount.owner = self
        self.$averageStrokeDistance.owner = self
        self.$swimStroke.owner = self
        self.$poolLength.owner = self
        self.$thresholdPower.owner = self
        self.$poolLengthUnit.owner = self
        self.$activeLengths.owner = self
        self.$totalWork.owner = self
        self.$_averageAltitude.owner = self
        self.$enhancedAverageAltitude.owner = self
        self.$_maximumAltitude.owner = self
        self.$enhancedMaximumAltitude.owner = self
        self.$gpsAccuracy.owner = self
        self.$averageGrade.owner = self
        self.$averagePositiveGrade.owner = self
        self.$averageNegitiveGrade.owner = self
        self.$maximumPositiveGrade.owner = self
        self.$maximumNegitiveGrade.owner = self
        self.$averageTemperature.owner = self
        self.$maximumTemperature.owner = self
        self.$totalMovingTime.owner = self
        self.$averagePositiveVerticalSpeed.owner = self
        self.$averageNegitiveVerticalSpeed.owner = self
        self.$maximumPositiveVerticalSpeed.owner = self
        self.$maximumNegitiveVerticalSpeed.owner = self
        self.$minimumHeartRate.owner = self
        self.$timeInHrZone.owner = self
        self.$timeInSpeedZone.owner = self
        self.$timeInCadenceZone.owner = self
        self.$timeInPowerZone.owner = self
        self.$averageLapTime.owner = self
        self.$bestLapIndex.owner = self
        self.$_minimumAltitude.owner = self
        self.$enhancedMinimumAltitude.owner = self
        self.$opponentScore.owner = self
        self.$playerScore.owner = self
        self.$opponentName.owner = self
        self.$strokeCount.owner = self
        self.$zoneCount.owner = self
        self.$maximumBallSpeed.owner = self
        self.$averageBallSpeed.owner = self
        self.$averageVerticalOscillation.owner = self
        self.$avgStanceTimePercent.owner = self
        self.$avgStanceTimeDuration.owner = self
        self.$avgStanceTimeBalance.owner = self
        self.$averageFractionalCadence.owner = self
        self.$maximumFractionalCadence.owner = self
        self.$totalFractionalCadence.owner = self
        self.$averageTotalHemoglobinConcentration.owner = self
        self.$minimumTotalHemoglobinConcentration.owner = self
        self.$maximumTotalHemoglobinConcentration.owner = self
        self.$averageSaturatedHemoglobinPercent.owner = self
        self.$minimumSaturatedHemoglobinPercent.owner = self
        self.$maximumSaturatedHemoglobinPercent.owner = self
        self.$avgLeftTorqueEffectiveness.owner = self
        self.$avgRightTorqueEffectiveness.owner = self
        self.$avgLeftPedalSmoothness.owner = self
        self.$avgRightPedalSmoothness.owner = self
        self.$avgCombinedPedalSmoothness.owner = self
        self.$sportIndex.owner = self
        self.$timeStanding.owner = self
        self.$standCount.owner = self
        self.$averageStepLength.owner = self
        self.$totalAnaerobicTrainingEffect.owner = self
        self.$averageAscentSpeed.owner = self
        self.$totalGrit.owner = self
        self.$totalFlow.owner = self
        self.$jumpCount.owner = self
        self.$averageGrit.owner = self
        self.$averageFlow.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            messageIndex: MessageIndex? = nil,
                            event: Event? = nil,
                            eventType: EventType? = nil,
                            startTime: FitTime? = nil,
                            startPosition: Position? = nil,
                            sport: Sport? = nil,
                            subSport: SubSport? = nil,
                            totalElapsedTime: Measurement<UnitDuration>? = nil,
                            totalTimerTime: Measurement<UnitDuration>? = nil,
                            totalDistance: Measurement<UnitLength>? = nil,
                            totalCycles: UInt32? = nil,
                            totalCalories: Measurement<UnitEnergy>? = nil,
                            totalFatCalories: Measurement<UnitEnergy>? = nil,
                            averageSpeed: Measurement<UnitSpeed>? = nil,
                            maximumSpeed: Measurement<UnitSpeed>? = nil,
                            averageHeartRate: UInt8? = nil,
                            maximumHeartRate: UInt8? = nil,
                            averageCadence: UInt8? = nil,
                            maximumCadence: UInt8? = nil,
                            averagePower: Measurement<UnitPower>? = nil,
                            maximumPower: Measurement<UnitPower>? = nil,
                            totalAscent: Measurement<UnitLength>? = nil,
                            totalDescent: Measurement<UnitLength>? = nil,
                            totalTrainingEffect: UInt8? = nil,
                            firstLapIndex: UInt16? = nil,
                            numberOfLaps: UInt16? = nil,
                            eventGroup: UInt8? = nil,
                            trigger: SessionTrigger? = nil,
                            necPosition: Position? = nil,
                            swcPosition: Position? = nil,
                            normalizedPower: Measurement<UnitPower>? = nil,
                            averageStrokeDistance: Measurement<UnitLength>? = nil,
                            swimStroke: SwimStroke? = nil,
                            poolLength: Measurement<UnitLength>? = nil,
                            poolLengthUnit: MeasurementDisplayType? = nil,
                            thresholdPower: Measurement<UnitPower>? = nil,
                            activeLengths: UInt16? = nil,
                            totalWork: Measurement<UnitEnergy>? = nil,
                            averageAltitude: Measurement<UnitLength>? = nil,
                            maximumAltitude: Measurement<UnitLength>? = nil,
                            gpsAccuracy: Measurement<UnitLength>? = nil,
                            averageGrade: Measurement<UnitPercent>? = nil,
                            averagePositiveGrade: Measurement<UnitPercent>? = nil,
                            averageNegitiveGrade: Measurement<UnitPercent>? = nil,
                            maximumPositiveGrade: Measurement<UnitPercent>? = nil,
                            maximumNegitiveGrade: Measurement<UnitPercent>? = nil,
                            averageTemperature: Measurement<UnitTemperature>? = nil,
                            maximumTemperature: Measurement<UnitTemperature>? = nil,
                            totalMovingTime: Measurement<UnitDuration>? = nil,
                            averagePositiveVerticalSpeed: Measurement<UnitSpeed>? = nil,
                            averageNegitiveVerticalSpeed: Measurement<UnitSpeed>? = nil,
                            maximumPositiveVerticalSpeed: Measurement<UnitSpeed>? = nil,
                            maximumNegitiveVerticalSpeed: Measurement<UnitSpeed>? = nil,
                            minimumHeartRate: UInt8? = nil,
                            averageLapTime: Measurement<UnitDuration>? = nil,
                            bestLapIndex: UInt16? = nil,
                            minimumAltitude: Measurement<UnitLength>? = nil,
                            score: Score? = nil,
                            opponentName: String? = nil,
                            maximumBallSpeed: Measurement<UnitSpeed>? = nil,
                            averageBallSpeed: Measurement<UnitSpeed>? = nil,
                            averageVerticalOscillation: Measurement<UnitLength>? = nil,
                            averageStanceTime: StanceTime? = nil,
                            averageTorqueEffectiveness: TorqueEffectiveness? = nil,
                            averagePedalSmoothness: PedalSmoothness? = nil,
                            sportIndex: UInt8? = nil,
                            timeStanding: Measurement<UnitDuration>? = nil,
                            standCount: UInt16? = nil,
                            averageStepLength: Measurement<UnitLength>? = nil,
                            totalAnaerobicTrainingEffect: UInt8? = nil,
                            averageAscentSpeed: Measurement<UnitSpeed>? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex
        self.event = event
        self.eventType = eventType
        self.startTime = startTime
        self.startPosition = startPosition
        self.sport = sport
        self.subSport = subSport
        self.totalElapsedTime = totalElapsedTime
        self.totalTimerTime = totalTimerTime
        self.totalDistance = totalDistance
        if let totalCycles = totalCycles {
            self.totalCycles = Measurement(value: Double(totalCycles), unit: self.$totalCycles.unitType)
        }
        self.totalCalories = totalCalories
        self.totalFatCalories = totalFatCalories
        self.averageSpeed = averageSpeed
        self.maximumSpeed = maximumSpeed
        
        if let hr = averageHeartRate {
            self.averageHeartRate = Measurement(value: Double(hr), unit: self.$averageHeartRate.unitType)
        }
        
        if let hr = maximumHeartRate {
            self.maximumHeartRate = Measurement(value: Double(hr), unit: self.$maximumHeartRate.unitType)
        }
        
        if let cadence = averageCadence {
            self.averageCadence = Measurement(value: Double(cadence), unit: self.$averageCadence.unitType)
        }
        
        if let cadence = maximumCadence {
            self.maximumCadence = Measurement(value: Double(cadence), unit: self.$maximumCadence.unitType)
        }
        
        self.averagePower = averagePower
        self.maximumPower = maximumPower
        self.totalAscent = totalAscent
        self.totalDescent = totalDescent
        self.totalTrainingEffect = totalTrainingEffect
        self.firstLapIndex = firstLapIndex
        
        if let laps = numberOfLaps {
            self.numberOfLaps = Measurement(value: Double(laps), unit: self.$numberOfLaps.unitType)
        }
        
        self.eventGroup = eventGroup
        self.trigger = trigger
        self.necPosition = necPosition
        self.swcPosition = swcPosition
        self.normalizedPower = normalizedPower
        self.averageStrokeDistance = averageStrokeDistance
        self.swimStroke = swimStroke
        self.poolLength = poolLength
        self.poolLengthUnit = poolLengthUnit
        self.thresholdPower = thresholdPower
        
        if let lengths = activeLengths {
            self.activeLengths = Measurement(value: Double(lengths), unit: self.$activeLengths.unitType)
        }
        
        self.totalWork = totalWork
        self.averageAltitude = averageAltitude
        self.maximumAltitude = maximumAltitude
        self.gpsAccuracy = gpsAccuracy
        self.averageGrade = averageGrade
        self.averagePositiveGrade = averagePositiveGrade
        self.averageNegitiveGrade = averageNegitiveGrade
        self.maximumPositiveGrade = maximumPositiveGrade
        self.maximumNegitiveGrade = maximumNegitiveGrade
        self.averageTemperature = averageTemperature
        self.maximumTemperature = maximumTemperature
        self.totalMovingTime = totalMovingTime
        self.averagePositiveVerticalSpeed = averagePositiveVerticalSpeed
        self.averageNegitiveVerticalSpeed = averageNegitiveVerticalSpeed
        self.maximumPositiveVerticalSpeed = maximumPositiveVerticalSpeed
        self.maximumNegitiveVerticalSpeed = maximumNegitiveVerticalSpeed
        
        if let hr = minimumHeartRate {
            self.minimumHeartRate = Measurement(value: Double(hr), unit: self.$minimumHeartRate.unitType)
        }
        
        self.averageLapTime = averageLapTime
        self.bestLapIndex = bestLapIndex
        self.minimumAltitude = minimumAltitude
        self.score = score
        self.opponentName = opponentName
        self.maximumBallSpeed = maximumBallSpeed
        self.averageBallSpeed = averageBallSpeed
        self.averageVerticalOscillation = averageVerticalOscillation
        self.averageStanceTime = averageStanceTime
        self.averageTorqueEffectiveness = averageTorqueEffectiveness
        self.averagePedalSmoothness = averagePedalSmoothness
        self.sportIndex = sportIndex
        self.timeStanding = timeStanding
        self.standCount = standCount
        self.averageStepLength = averageStepLength
        self.totalAnaerobicTrainingEffect = totalAnaerobicTrainingEffect
        self.averageAscentSpeed = averageAscentSpeed
    }
    
    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    /// - Returns: FitMessage Result
    override func decode<F>(fieldData: FieldData, definition: DefinitionMessage) -> Result<F, FitDecodingError> where F: FitMessage {
        var testDecoder = DecodeData()
        
        var fieldDict: [UInt8: FieldDefinition] = [UInt8: FieldDefinition]()
        var fieldDataDict: [UInt8: Data] = [UInt8: Data]()
        
        for definition in definition.fieldDefinitions {
            let fieldData = testDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
            
            fieldDict[definition.fieldDefinitionNumber] = definition
            fieldDataDict[definition.fieldDefinitionNumber] = fieldData
        }
        
        let msg = SessionMessage(fieldDict: fieldDict,
                                 fieldDataDict: fieldDataDict,
                                 architecture: definition.architecture)
        
        let devData = self.decodeDeveloperData(data: fieldData, definition: definition)
        msg.developerData = devData.isEmpty ? nil : devData
        
        return .success(msg as! F)
    }
    
    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {
        
        do {
            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
        } catch let error as FitEncodingError {
            return.failure(error)
        } catch {
            return.failure(FitEncodingError.fileType(error.localizedDescription))
        }
        
        guard opponentName?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("opponentName size can not exceed 255"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: SessionMessage.globalMessageNumber(),
                                           fields: UInt8(fields.count),
                                           fieldDefinitions: fields,
                                           developerFieldDefinitions: [DeveloperFieldDefinition]())
        
        return.success(defMessage)
        
    }
    
    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data Result
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {
        
        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            return.failure(self.encodeWrongDefinitionMessage())
        }
        
        return self.encodeMessageFields(localMessageType: localMessageType)
    }
}

extension SessionMessage: MessageValidator {
    
    /// Validate Message
    ///
    /// - Parameters:
    ///   - fileType: FileType the Message is being used in
    ///   - dataValidityStrategy: Data Validity Strategy
    /// - Throws: FitError
    internal func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws {
        
        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: false)
            }
        case .garminConnect:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: true)
            }
        }
    }
    
    private func validateActivity(isGarmin: Bool) throws {
        
        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"
        
        guard self.timeStamp != nil else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain timeStamp, can not be nil")
        }
        
        guard self.startTime != nil else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain startTime, can not be nil")
        }
        
        guard self.totalElapsedTime != nil else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain totalElapsedTime, can not be nil")
        }
        
        guard self.sport != nil else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain sport, can not be nil")
        }
        
        guard let event = self.event else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain event, can not be nil")
        }
        
        guard event == .session else {
            throw FitEncodingError.propertyValue("\(msg) SessionMessage event must be .session")
        }
        
        guard let eventType = self.eventType else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain eventType, can not be nil")
        }
        
        guard eventType == .stop else {
            throw FitEncodingError.propertyValue("\(msg) SessionMessage eventType must be .stop")
        }
        
    }
}
