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
import FitnessUnits
import AntMessageProtocol

/// FIT Session Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SessionMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 18 }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Event
    private(set) public var event: Event?

    /// Event Type
    private(set) public var eventType: EventType?

    /// Start Time
    private(set) public var startTime: FitTime?

    /// Start Position
    private(set) public var startPosition: Position

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    /// Total Elapsed Time
    ///
    /// Includes pauses
    private(set) public var totalElapsedTime: Measurement<UnitDuration>?

    /// Total Timer Time
    ///
    /// Excludes pauses
    private(set) public var totalTimerTime: Measurement<UnitDuration>?

    /// Total Distance
    private(set) public var totalDistance: ValidatedMeasurement<UnitLength>?

    /// Total Cycles
    private(set) public var totalCycles: ValidatedBinaryInteger<UInt32>?

    /// Total Calories
    private(set) public var totalCalories: ValidatedMeasurement<UnitEnergy>?

    /// Total Fat Calories
    private(set) public var totalFatCalories: ValidatedMeasurement<UnitEnergy>?

    /// Average Speed
    private(set) public var averageSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Maximum Speed
    private(set) public var maximumSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Average Heart Rate
    private(set) public var averageHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Maximum Heart Rate
    private(set) public var maximumHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Average Cadence
    ///
    /// If nil you can use totalCycles / totalTimerTime
    private(set) public var averageCadence: ValidatedMeasurement<UnitCadence>?

    /// Maximum Cadence
    private(set) public var maximumCadence: ValidatedMeasurement<UnitCadence>?

    /// Average Power
    ///
    /// If nil you can use totalPower / totalTimerTime
    private(set) public var averagePower: ValidatedMeasurement<UnitPower>?

    /// Maximum Power
    private(set) public var maximumPower: ValidatedMeasurement<UnitPower>?

    /// Total Ascent
    private(set) public var totalAscent: ValidatedMeasurement<UnitLength>?

    /// Total Descent
    private(set) public var totalDescent: ValidatedMeasurement<UnitLength>?

    /// Total Training Effect
    private(set) public var totalTrainingEffect: ValidatedBinaryInteger<UInt8>?

    /// First Lap Index
    private(set) public var firstLapIndex: ValidatedBinaryInteger<UInt16>?

    /// Number of Laps
    private(set) public var numberOfLaps: ValidatedBinaryInteger<UInt16>?

    /// Event Group
    private(set) public var eventGroup: ValidatedBinaryInteger<UInt8>?

    /// Session Trigger
    private(set) public var trigger: SessionTrigger?

    /// NEC Position
    private(set) public var necPosition: Position

    /// SWC Position
    private(set) public var swcPosition: Position

    /// Normalized Power
    private(set) public var normalizedPower: ValidatedMeasurement<UnitPower>?

    /// Average Stroke Distance
    private(set) public var averageStrokeDistance: ValidatedMeasurement<UnitLength>?

    /// Swim Stroke
    private(set) public var swimStroke: SwimStroke?

    /// Pool Length
    private(set) public var poolLength: ValidatedMeasurement<UnitLength>?

    /// Pool Length Unit
    private(set) public var poolLengthUnit: MeasurementDisplayType?

    /// Threshold Power
    private(set) public var thresholdPower: ValidatedMeasurement<UnitPower>?

    /// Number of Active Lengths
    ///
    /// Number of active lengths of swim pool
    private(set) public var activeLengths: ValidatedBinaryInteger<UInt16>?

    /// Total Work
    private(set) public var totalWork: ValidatedMeasurement<UnitEnergy>?

    /// Average Altitude
    private(set) public var averageAltitude: ValidatedMeasurement<UnitLength>?

    /// Maximum Altitude
    private(set) public var maximumAltitude: ValidatedMeasurement<UnitLength>?

    /// GPS Accuracy
    private(set) public var gpsAccuracy: ValidatedMeasurement<UnitLength>?

    /// Average Grade
    private(set) public var averageGrade: ValidatedMeasurement<UnitPercent>?

    /// Average Positive Grade
    private(set) public var averagePositiveGrade: ValidatedMeasurement<UnitPercent>?

    /// Average Negitive Grade
    private(set) public var averageNegitiveGrade: ValidatedMeasurement<UnitPercent>?

    /// Maximum Positive Grade
    private(set) public var maximumPositiveGrade: ValidatedMeasurement<UnitPercent>?

    /// Maximum Negitive Grade
    private(set) public var maximumNegitiveGrade: ValidatedMeasurement<UnitPercent>?

    /// Average Temperature
    private(set) public var averageTemperature: ValidatedMeasurement<UnitTemperature>?

    /// Maximum Temperature
    private(set) public var maximumTemperature: ValidatedMeasurement<UnitTemperature>?

    /// Total Moving Time
    private(set) public var totalMovingTime: Measurement<UnitDuration>?

    /// Average Positive Vertical Speed
    private(set) public var averagePositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Average Negitive Vertical Speed
    private(set) public var averageNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Maximum Positive Vertical Speed
    private(set) public var maximumPositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Maximum Negitive Vertical Speed
    private(set) public var maximumNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Minimum Heart Rate
    private(set) public var minimumHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Average Lap Time
    private(set) public var averageLapTime: Measurement<UnitDuration>?

    /// Best Lap Index
    private(set) public var bestLapIndex: ValidatedBinaryInteger<UInt16>?

    /// Minimum Altitude
    private(set) public var minimumAltitude: ValidatedMeasurement<UnitLength>?

    /// Score Information
    ///
    /// Include Opponent Score, Player Score
    private(set) public var score: Score

    /// Opponent Name
    private(set) public var opponentName: String?

    /// Maximum Ball Speed
    private(set) public var maximumBallSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Average Ball Speed
    private(set) public var averageBallSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Average Vertical Oscillation
    private(set) public var averageVerticalOscillation: ValidatedMeasurement<UnitLength>?

    /// Average Stance Time
    private(set) public var averageStanceTime: StanceTime

    /// Sport Group
    private(set) public var sportIndex: ValidatedBinaryInteger<UInt8>?

    /// Enhanced Average Speed
    private(set) public var enhancedAverageSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Enhanced Maximum Speed
    private(set) public var enhancedMaximumSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Enhanced Average Altitude
    private(set) public var enhancedAverageAltitude: ValidatedMeasurement<UnitLength>?

    /// Enhanced Minimum Altitude
    private(set) public var enhancedMinimumAltitude: ValidatedMeasurement<UnitLength>?

    /// Enhanced Maximum Altitude
    private(set) public var enhancedMaximumAltitude: ValidatedMeasurement<UnitLength>?

    ///sportIndex
    public required init() {
        self.startPosition = Position(latitude: nil, longitude: nil)
        self.necPosition = Position(latitude: nil, longitude: nil)
        self.swcPosition = Position(latitude: nil, longitude: nil)
        self.score = Score(playerScore: nil, opponentScore: nil)
        self.averageStanceTime = StanceTime(percent: nil, time: nil)
    }

    public init(timeStamp: FitTime? = nil,
                messageIndex: MessageIndex? = nil,
                event: Event? = nil,
                eventType: EventType? = nil,
                startTime: FitTime? = nil,
                startPosition: Position,
                sport: Sport? = nil,
                subSport: SubSport? = nil,
                totalElapsedTime: Measurement<UnitDuration>? = nil,
                totalTimerTime: Measurement<UnitDuration>? = nil,
                totalDistance: ValidatedMeasurement<UnitLength>? = nil,
                totalCycles: ValidatedBinaryInteger<UInt32>? = nil,
                totalCalories: ValidatedMeasurement<UnitEnergy>? = nil,
                totalFatCalories: ValidatedMeasurement<UnitEnergy>? = nil,
                averageSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                maximumSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                averageHeartRate: UInt8? = nil,
                maximumHeartRate: UInt8? = nil,
                averageCadence: UInt8? = nil,
                maximumCadence: UInt8? = nil,
                averagePower: ValidatedMeasurement<UnitPower>? = nil,
                maximumPower: ValidatedMeasurement<UnitPower>? = nil,
                totalAscent: ValidatedMeasurement<UnitLength>? = nil,
                totalDescent: ValidatedMeasurement<UnitLength>? = nil,
                totalTrainingEffect: ValidatedBinaryInteger<UInt8>? = nil,
                firstLapIndex: ValidatedBinaryInteger<UInt16>? = nil,
                numberOfLaps: ValidatedBinaryInteger<UInt16>? = nil,
                eventGroup: ValidatedBinaryInteger<UInt8>? = nil,
                trigger: SessionTrigger? = nil,
                necPosition: Position,
                swcPosition: Position,
                normalizedPower: ValidatedMeasurement<UnitPower>? = nil,
                averageStrokeDistance: ValidatedMeasurement<UnitLength>? = nil,
                swimStroke: SwimStroke? = nil,
                poolLength: ValidatedMeasurement<UnitLength>? = nil,
                poolLengthUnit: MeasurementDisplayType? = nil,
                thresholdPower: ValidatedMeasurement<UnitPower>? = nil,
                activeLengths: ValidatedBinaryInteger<UInt16>? = nil,
                totalWork: ValidatedMeasurement<UnitEnergy>? = nil,
                averageAltitude: ValidatedMeasurement<UnitLength>? = nil,
                maximumAltitude: ValidatedMeasurement<UnitLength>? = nil,
                gpsAccuracy: ValidatedMeasurement<UnitLength>? = nil,
                averageGrade: ValidatedMeasurement<UnitPercent>? = nil,
                averagePositiveGrade: ValidatedMeasurement<UnitPercent>? = nil,
                averageNegitiveGrade: ValidatedMeasurement<UnitPercent>? = nil,
                maximumPositiveGrade: ValidatedMeasurement<UnitPercent>? = nil,
                maximumNegitiveGrade: ValidatedMeasurement<UnitPercent>? = nil,
                averageTemperature: ValidatedMeasurement<UnitTemperature>? = nil,
                maximumTemperature: ValidatedMeasurement<UnitTemperature>? = nil,
                totalMovingTime: Measurement<UnitDuration>? = nil,
                averagePositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                averageNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                maximumPositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                maximumNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                minimumHeartRate: UInt8? = nil,
                averageLapTime: Measurement<UnitDuration>? = nil,
                bestLapIndex: ValidatedBinaryInteger<UInt16>? = nil,
                minimumAltitude: ValidatedMeasurement<UnitLength>? = nil,
                score: Score,
                opponentName: String? = nil,
                maximumBallSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                averageBallSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                averageVerticalOscillation: ValidatedMeasurement<UnitLength>? = nil,
                averageStanceTime: StanceTime,
                sportIndex: ValidatedBinaryInteger<UInt8>? = nil,
                enhancedAverageSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                enhancedMaximumSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                enhancedAverageAltitude: ValidatedMeasurement<UnitLength>? = nil,
                enhancedMinimumAltitude: ValidatedMeasurement<UnitLength>? = nil,
                enhancedMaximumAltitude: ValidatedMeasurement<UnitLength>? = nil) {

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
        self.totalCycles = totalCycles
        self.totalCalories = totalCalories
        self.totalFatCalories = totalFatCalories
        self.averageSpeed = averageSpeed
        self.maximumSpeed = maximumSpeed

        if let hr = averageHeartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.averageHeartRate.baseType)
            self.averageHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }

        if let hr = maximumHeartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.maximumHeartRate.baseType)
            self.maximumHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }

        if let cadence = averageCadence {
            let valid = cadence.isValidForBaseType(FitCodingKeys.averageCadence.baseType)
            self.averageCadence = ValidatedMeasurement(value: Double(cadence), valid: valid, unit: UnitCadence.revolutionsPerMinute)
        }

        if let cadence = maximumCadence {
            let valid = cadence.isValidForBaseType(FitCodingKeys.maximumCadence.baseType)
            self.maximumCadence = ValidatedMeasurement(value: Double(cadence), valid: valid, unit: UnitCadence.revolutionsPerMinute)
        }
        
        self.averagePower = averagePower
        self.maximumPower = maximumPower
        self.totalAscent = totalAscent
        self.totalDescent = totalDescent
        self.totalTrainingEffect = totalTrainingEffect
        self.firstLapIndex = firstLapIndex
        self.numberOfLaps = numberOfLaps
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
        self.activeLengths = activeLengths
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
            let valid = hr.isValidForBaseType(FitCodingKeys.minimumHeartRate.baseType)
            self.minimumHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
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
        self.sportIndex = sportIndex
        self.enhancedAverageSpeed = enhancedAverageSpeed
        self.enhancedMaximumSpeed = enhancedMaximumSpeed
        self.enhancedAverageAltitude = enhancedAverageAltitude
        self.enhancedMinimumAltitude = enhancedMinimumAltitude
        self.enhancedMaximumAltitude = enhancedMaximumAltitude
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> SessionMessage  {

        var timestamp: FitTime?
        var messageIndex: MessageIndex?
        var event: Event?
        var eventType: EventType?
        var startTime: FitTime?
        var startPositionlatitude: ValidatedMeasurement<UnitAngle>?
        var startPositionlongitude: ValidatedMeasurement<UnitAngle>?
        var sport: Sport?
        var subSport: SubSport?
        var totalElapsedTime: Measurement<UnitDuration>?
        var totalTimerTime: Measurement<UnitDuration>?
        var totalDistance: ValidatedMeasurement<UnitLength>?
        var totalCycles: ValidatedBinaryInteger<UInt32>?
        var totalCalories: ValidatedMeasurement<UnitEnergy>?
        var totalFatCalories: ValidatedMeasurement<UnitEnergy>?
        var averageSpeed: ValidatedMeasurement<UnitSpeed>?
        var maximumSpeed: ValidatedMeasurement<UnitSpeed>?
        var averageHeartRate: UInt8?
        var maximumHeartRate: UInt8?
        var averageCadence: UInt8?
        var maximumCadence: UInt8?
        var averagePower: ValidatedMeasurement<UnitPower>?
        var maximumPower: ValidatedMeasurement<UnitPower>?
        var totalAscent: ValidatedMeasurement<UnitLength>?
        var totalDescent: ValidatedMeasurement<UnitLength>?
        var totalTrainingEffect: ValidatedBinaryInteger<UInt8>?
        var firstLapIndex: ValidatedBinaryInteger<UInt16>?
        var numberOfLaps: ValidatedBinaryInteger<UInt16>?
        var eventGroup: ValidatedBinaryInteger<UInt8>?
        var trigger: SessionTrigger?
        var necLatitude: ValidatedMeasurement<UnitAngle>?
        var necLongitude: ValidatedMeasurement<UnitAngle>?
        var swcLatitude: ValidatedMeasurement<UnitAngle>?
        var swcLongitude: ValidatedMeasurement<UnitAngle>?
        var normalizedPower: ValidatedMeasurement<UnitPower>?
        var averageStrokeDistance: ValidatedMeasurement<UnitLength>?
        var swimStroke: SwimStroke?
        var poolLength: ValidatedMeasurement<UnitLength>?
        var poolLengthUnit: MeasurementDisplayType?
        var thresholdPower: ValidatedMeasurement<UnitPower>?
        var activeLengths: ValidatedBinaryInteger<UInt16>?
        var totalWork: ValidatedMeasurement<UnitEnergy>?
        var averageAltitude: ValidatedMeasurement<UnitLength>?
        var maximumAltitude: ValidatedMeasurement<UnitLength>?
        var gpsAccuracy: ValidatedMeasurement<UnitLength>?
        var averageGrade: ValidatedMeasurement<UnitPercent>?
        var averagePositiveGrade: ValidatedMeasurement<UnitPercent>?
        var averageNegitiveGrade: ValidatedMeasurement<UnitPercent>?
        var maximumPositiveGrade: ValidatedMeasurement<UnitPercent>?
        var maximumNegitiveGrade: ValidatedMeasurement<UnitPercent>?
        var averageTemperature: ValidatedMeasurement<UnitTemperature>?
        var maximumTemperature: ValidatedMeasurement<UnitTemperature>?
        var totalMovingTime: Measurement<UnitDuration>?
        var averagePositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?
        var averageNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?
        var maximumPositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?
        var maximumNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?
        var minimumHeartRate: UInt8?
        var averageLapTime: Measurement<UnitDuration>?
        var bestLapIndex: ValidatedBinaryInteger<UInt16>?
        var minimumAltitude: ValidatedMeasurement<UnitLength>?
        var opponentScore: ValidatedBinaryInteger<UInt16>?
        var playerScore: ValidatedBinaryInteger<UInt16>?
        var opponentName: String?
        var maximumBallSpeed: ValidatedMeasurement<UnitSpeed>?
        var averageBallSpeed: ValidatedMeasurement<UnitSpeed>?
        var averageVerticalOscillation: ValidatedMeasurement<UnitLength>?
        var averageStancePercent: ValidatedMeasurement<UnitPercent>?
        var averageStanceTime: ValidatedMeasurement<UnitDuration>?
        var sportIndex: ValidatedBinaryInteger<UInt8>?
        var enhancedAverageSpeed: ValidatedMeasurement<UnitSpeed>?
        var enhancedMaximumSpeed: ValidatedMeasurement<UnitSpeed>?
        var enhancedAverageAltitude: ValidatedMeasurement<UnitLength>?
        var enhancedMinimumAltitude: ValidatedMeasurement<UnitLength>?
        var enhancedMaximumAltitude: ValidatedMeasurement<UnitLength>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("SessionMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .event:
                    event = Event.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .eventType:
                    eventType = EventType.decode(decoder: &localDecoder,
                                                 definition: definition,
                                                 data: fieldData,
                                                 dataStrategy: dataStrategy)

                case .startTime:
                    startTime = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                case .startPositionLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        startPositionlatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        startPositionlatitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .startPositionLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        startPositionlongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        startPositionlongitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .sport:
                    sport = Sport.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .subSport:
                    subSport = SubSport.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

                case .totalElapsedTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0, Time (includes pauses)
                        let value = value.resolution(1 / 1000)
                        totalElapsedTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .totalTimerTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0, Time (excludes pauses)
                        let value = value.resolution(1 / 1000)
                        totalTimerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .totalDistance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        totalDistance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        totalDistance = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .totalCycles:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    // 1 * cycles + 0
                    totalCycles = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                           definition: definition,
                                                                           dataStrategy: dataStrategy)

                case .totalCalories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * kcal + 0
                        totalCalories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        totalCalories = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .totalFatCalories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * kcal + 0
                        totalFatCalories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        totalFatCalories = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .averageSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        averageSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .maximumSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        maximumSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        maximumSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        averageHeartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            averageHeartRate = value.value
                        } else {
                            averageHeartRate = nil
                        }
                    }

                case .maximumHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        maximumHeartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            maximumHeartRate = value.value
                        } else {
                            maximumHeartRate = nil
                        }
                    }

                case .averageCadence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * rpm + 0
                        averageCadence = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            averageCadence = value.value
                        } else {
                            averageCadence = nil
                        }
                    }

                case .maximumCadence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * rpm + 0
                        maximumCadence = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            maximumCadence = value.value
                        } else {
                            maximumCadence = nil
                        }
                    }

                case .averagePower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        averagePower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        averagePower = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .maximumPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        maximumPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        maximumPower = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .totalAscent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        let value = value.resolution(1)
                        totalAscent = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        totalAscent = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .totalDescent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        let value = value.resolution(1)
                        totalDescent = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        totalDescent = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .totalTrainingEffect:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    totalTrainingEffect = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                                  definition: definition,
                                                                                  dataStrategy: dataStrategy)

                case .firstLapIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    firstLapIndex = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                             definition: definition,
                                                                             dataStrategy: dataStrategy)

                case .numberOfLaps:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    numberOfLaps = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                            definition: definition,
                                                                            dataStrategy: dataStrategy)

                case .eventGroup:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    eventGroup = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .trigger:
                    trigger = SessionTrigger.decode(decoder: &localDecoder,
                                                    definition: definition,
                                                    data: fieldData,
                                                    dataStrategy: dataStrategy)

                case .necLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        necLatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        necLatitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .necLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        necLongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        necLongitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .swcLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        swcLatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        swcLatitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .swcLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        swcLongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        swcLongitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .normalizedPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        normalizedPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        normalizedPower = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .trainingStressScore:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .intensityFactor:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .leftRightBalance:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .averageStrokeCount:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .averageStrokeDistance:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        averageStrokeDistance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        averageStrokeDistance = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .swimStroke:
                    swimStroke = SwimStroke.decode(decoder: &localDecoder,
                                                   definition: definition,
                                                   data: fieldData,
                                                   dataStrategy: dataStrategy)

                case .poolLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m + 0
                        let value = value.resolution(1 / 100)
                        poolLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        poolLength = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .thresholdPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        thresholdPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        thresholdPower = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .poolLengthUnit:
                    poolLengthUnit = MeasurementDisplayType.decode(decoder: &localDecoder, definition: definition, data: fieldData, dataStrategy: dataStrategy)

                case .numberActiveLengths:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    // 1 * lengths + 0
                    activeLengths = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                             definition: definition,
                                                                             dataStrategy: dataStrategy)

                case .totalWork:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * j + 0
                        totalWork = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.joules)
                    } else {
                        totalWork = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.joules)
                    }

                case .averageAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        averageAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        averageAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .maximumAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        maximumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        maximumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .gpsAccuracy:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        gpsAccuracy = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitLength.meters)
                    } else {
                        gpsAccuracy = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .averageGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        averageGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averageGrade = ValidatedMeasurement.invalidValue(definition.baseType,
                                                                         dataStrategy: dataStrategy,
                                                                         unit: UnitPercent.percent)
                    }

                case .averagePositiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        averagePositiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averagePositiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .averageNegitiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        averageNegitiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averageNegitiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .maximumPositiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        maximumPositiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        maximumPositiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .maximumNegitiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        maximumNegitiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        maximumNegitiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .averageTemperature:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * C + 0
                        averageTemperature = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitTemperature.celsius)
                    } else {
                        averageTemperature = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitTemperature.celsius)
                    }

                case .maximumTemperature:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * C + 0
                        maximumTemperature = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitTemperature.celsius)
                    } else {
                        maximumTemperature = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitTemperature.celsius)
                    }

                case .totalMovingTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        totalMovingTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }
                    
                case .averagePositiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        averagePositiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averagePositiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageNegitiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        averageNegitiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageNegitiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .maximumPositiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        maximumPositiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        maximumPositiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .maximumNegitiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        maximumNegitiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        maximumNegitiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .minimumHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        minimumHeartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            minimumHeartRate = value.value
                        } else {
                            minimumHeartRate = nil
                        }
                    }

                case .timeInHeartRateZone:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timeInSpeedZone:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timeInCadenceZone:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timeInPowerZone:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .averageLapTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        averageLapTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .bestLapIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    bestLapIndex = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                            definition: definition,
                                                                            dataStrategy: dataStrategy)

                case .minimumAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        minimumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        minimumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .playerScore:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    playerScore = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                           definition: definition,
                                                                           dataStrategy: dataStrategy)

                case .opponentScore:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    opponentScore = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                             definition: definition,
                                                                             dataStrategy: dataStrategy)

                case .opponentName:
                    opponentName = String.decode(decoder: &localDecoder,
                                                 definition: definition,
                                                 data: fieldData,
                                                 dataStrategy: dataStrategy)

                case .strokeCount:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .zoneCount:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .maximumBallSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m/s + 0,
                        let value = value.resolution(1 / 100)
                        maximumBallSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        maximumBallSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageBallSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m/s + 0,
                        let value = value.resolution(1 / 100)
                        averageBallSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageBallSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageVerticalOscillation:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * mm + 0
                        let value = value.resolution(1 / 10)
                        averageVerticalOscillation = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.millimeters)
                    } else {
                        averageVerticalOscillation = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.millimeters)
                    }

                case .averageStanceTimePercent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        averageStancePercent = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averageStancePercent = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .averageStanceTime:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * ms + 0
                        let value = value.resolution(1 / 10)
                        averageStanceTime = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.millisecond)
                    } else {
                        averageStanceTime = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitDuration.millisecond)
                    }

                case .averageFractionalCadence:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .maximumFractionalCadence:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalFractionalCycles:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .sportIndex:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    sportIndex = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .enhancedAverageSpeed:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        enhancedAverageSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        enhancedAverageSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .enhancedMaximumSpeed:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        enhancedMaximumSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        enhancedMaximumSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .enhancedAverageAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedAverageAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedAverageAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .enhancedMinimumAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedMinimumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedMinimumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .enhancedMaximumAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedMaximumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedMaximumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .averageVam:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalAnaerobicTrainingEffect:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }


        /// Start Position
        let startPosition = Position(latitude: startPositionlatitude, longitude: startPositionlongitude)
        /// NEC Position
        let necPosition = Position(latitude: necLatitude, longitude: necLongitude)
        /// SWC Position
        let swcPosition = Position(latitude: swcLatitude, longitude: swcLongitude)
        /// Score Information
        let score = Score(playerScore: playerScore, opponentScore: opponentScore)
        /// Avarage Stance Time
        let averageStance = StanceTime(percent: averageStancePercent, time: averageStanceTime)

        return SessionMessage(timeStamp: timestamp,
                              messageIndex: messageIndex,
                              event: event,
                              eventType: eventType,
                              startTime: startTime,
                              startPosition: startPosition,
                              sport: sport,
                              subSport: subSport,
                              totalElapsedTime: totalElapsedTime,
                              totalTimerTime: totalTimerTime,
                              totalDistance: totalDistance,
                              totalCycles: totalCycles,
                              totalCalories: totalCalories,
                              totalFatCalories: totalFatCalories,
                              averageSpeed: averageSpeed,
                              maximumSpeed: maximumSpeed,
                              averageHeartRate: averageHeartRate,
                              maximumHeartRate: maximumHeartRate,
                              averageCadence: averageCadence,
                              maximumCadence: maximumCadence,
                              averagePower: averagePower,
                              maximumPower: maximumPower,
                              totalAscent: totalAscent,
                              totalDescent: totalDescent,
                              totalTrainingEffect: totalTrainingEffect,
                              firstLapIndex: firstLapIndex,
                              numberOfLaps: numberOfLaps,
                              eventGroup: eventGroup,
                              trigger: trigger,
                              necPosition: necPosition,
                              swcPosition: swcPosition,
                              normalizedPower: normalizedPower,
                              averageStrokeDistance: averageStrokeDistance,
                              swimStroke: swimStroke,
                              poolLength: poolLength,
                              poolLengthUnit: poolLengthUnit,
                              thresholdPower: thresholdPower,
                              activeLengths: activeLengths,
                              totalWork: totalWork,
                              averageAltitude: averageAltitude,
                              maximumAltitude: maximumAltitude,
                              gpsAccuracy: gpsAccuracy,
                              averageGrade: averageGrade,
                              averagePositiveGrade: averagePositiveGrade,
                              averageNegitiveGrade: averageNegitiveGrade,
                              maximumPositiveGrade: maximumPositiveGrade,
                              maximumNegitiveGrade: maximumNegitiveGrade,
                              averageTemperature: averageTemperature,
                              maximumTemperature: maximumTemperature,
                              totalMovingTime: totalMovingTime,
                              averagePositiveVerticalSpeed: averagePositiveVerticalSpeed,
                              averageNegitiveVerticalSpeed: averageNegitiveVerticalSpeed,
                              maximumPositiveVerticalSpeed: maximumPositiveVerticalSpeed,
                              maximumNegitiveVerticalSpeed: maximumNegitiveVerticalSpeed,
                              minimumHeartRate: minimumHeartRate,
                              averageLapTime: averageLapTime,
                              bestLapIndex: bestLapIndex,
                              minimumAltitude: minimumAltitude,
                              score: score,
                              opponentName: opponentName,
                              maximumBallSpeed: maximumBallSpeed,
                              averageBallSpeed: averageBallSpeed,
                              averageVerticalOscillation: averageVerticalOscillation,
                              averageStanceTime: averageStance,
                              sportIndex: sportIndex,
                              enhancedAverageSpeed: enhancedAverageSpeed,
                              enhancedMaximumSpeed: enhancedMaximumSpeed,
                              enhancedAverageAltitude: enhancedAverageAltitude,
                              enhancedMinimumAltitude: enhancedMinimumAltitude,
                              enhancedMaximumAltitude: enhancedMaximumAltitude)

    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .event:
                if let event = event {
                    msgData.append(event.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .eventType:
                if let eventType = eventType {
                    msgData.append(eventType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .startTime:
                if let startTime = startTime {
                    msgData.append(startTime.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .startPositionLatitude:
                if let value = startPosition.encodeLatitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .startPositionLongitude:
                if let value = startPosition.encodeLongitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .sport:
                if let sport = sport {
                    msgData.append(sport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .subSport:
                if let subSport = subSport {
                    msgData.append(subSport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalElapsedTime:
                if var totalElapsedTime = totalElapsedTime {
                    // 1000 * s + 0, Time (includes pauses)
                    totalElapsedTime = totalElapsedTime.converted(to: UnitDuration.seconds)
                    let value = totalElapsedTime.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalTimerTime:
                if var totalTimerTime = totalTimerTime {
                    // 1000 * s + 0, Time (excludes pauses)
                    totalTimerTime = totalTimerTime.converted(to: UnitDuration.seconds)
                    let value = totalTimerTime.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalDistance:
                if var totalDistance = totalDistance {
                    // 100 * m + 0
                    totalDistance = totalDistance.converted(to: UnitLength.meters)
                    let value = totalDistance.value.resolutionUInt32(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalCycles:
                if let totalCycles = totalCycles {
                    // 1 * cycles + 0
                    msgData.append(Data(from: totalCycles.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalCalories:
                if var totalCalories = totalCalories {
                    // 1 * kcal + 0
                    totalCalories = totalCalories.converted(to: UnitEnergy.kilocalories)
                    let value = totalCalories.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalFatCalories:
                if var totalFatCalories = totalFatCalories {
                    // 1 * kcal + 0
                    totalFatCalories = totalFatCalories.converted(to: UnitEnergy.kilocalories)
                    let value = totalFatCalories.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageSpeed:
                if var averageSpeed = averageSpeed {
                    // 1000 * m/s + 0
                    averageSpeed = averageSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = averageSpeed.value.resolutionInt16(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumSpeed:
                if var maximumSpeed = maximumSpeed {
                    // 1000 * m/s + 0
                    maximumSpeed = maximumSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = maximumSpeed.value.resolutionInt16(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageHeartRate:
                if let averageHeartRate = averageHeartRate {
                    // 1 * bpm + 0
                    let value = averageHeartRate.value.resolutionUInt8(1)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumHeartRate:
                if let maximumHeartRate = maximumHeartRate {
                    // 1 * bpm + 0
                    let value = maximumHeartRate.value.resolutionUInt8(1)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageCadence:
                if let averageCadence = averageCadence {
                    // 1 * rpm + 0
                    let value = averageCadence.value.resolutionUInt8(1)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumCadence:
                if let maximumCadence = maximumCadence {
                    // 1 * rpm + 0
                    let value = maximumCadence.value.resolutionUInt8(1)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averagePower:
                if let averagePower = averagePower {
                    let value = encodePower(averagePower)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumPower:
                if let maximumPower = maximumPower {
                    let value = encodePower(maximumPower)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalAscent:
                if var totalAscent = totalAscent {
                    // 1 * m + 0
                    totalAscent = totalAscent.converted(to: UnitLength.meters)
                    let value = totalAscent.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalDescent:
                if var totalDescent = totalDescent {
                    // 1 * m + 0
                    totalDescent = totalDescent.converted(to: UnitLength.meters)
                    let value = totalDescent.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalTrainingEffect:
                if let totalTrainingEffect = totalTrainingEffect {
                    msgData.append(totalTrainingEffect.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .firstLapIndex:
                if let firstLapIndex = firstLapIndex {
                    msgData.append(Data(from: firstLapIndex.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .numberOfLaps:
                if let numberOfLaps = numberOfLaps {
                    msgData.append(Data(from: numberOfLaps.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .eventGroup:
                if let eventGroup = eventGroup {
                    msgData.append(eventGroup.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .trigger:
                if let trigger = trigger {
                    msgData.append(trigger.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .necLatitude:
                if let value = necPosition.encodeLatitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .necLongitude:
                if let value = necPosition.encodeLongitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .swcLatitude:
                if let value = swcPosition.encodeLatitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .swcLongitude:
                if let value = swcPosition.encodeLongitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .normalizedPower:
                if let normalizedPower = normalizedPower {
                    let value = encodePower(normalizedPower)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .trainingStressScore:
                break
            case .intensityFactor:
                break
            case .leftRightBalance:
                break
            case .averageStrokeCount:
                break

            case .averageStrokeDistance:
                if var averageStrokeDistance = averageStrokeDistance {
                    // 100 * m + 0
                    averageStrokeDistance = averageStrokeDistance.converted(to: UnitLength.meters)
                    let value = averageStrokeDistance.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .swimStroke:
                if let swimStroke = swimStroke {
                    msgData.append(swimStroke.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .poolLength:
                if var poolLength = poolLength {
                    // 100 * m + 0
                    poolLength = poolLength.converted(to: UnitLength.meters)
                    let value = poolLength.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .thresholdPower:
                if let thresholdPower = thresholdPower {
                    let value = encodePower(thresholdPower)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .poolLengthUnit:
                if let poolLengthUnit = poolLengthUnit {
                    msgData.append(poolLengthUnit.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .numberActiveLengths:
                if let numberActiveLengths = activeLengths {
                    // 1 * lengths + 0
                    msgData.append(Data(from: numberActiveLengths.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalWork:
                if var totalWork = totalWork {
                    // 1 * j + 0
                    totalWork = totalWork.converted(to: UnitEnergy.joules)
                    let value = totalWork.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageAltitude:
                if var averageAltitude = averageAltitude {
                    // 5 * m + 500
                    averageAltitude = averageAltitude.converted(to: UnitLength.meters)
                    let value = averageAltitude.value.resolutionUInt16(5) + 500

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumAltitude:
                if var maximumAltitude = maximumAltitude {
                    // 5 * m + 500
                    maximumAltitude = maximumAltitude.converted(to: UnitLength.meters)
                    let value = maximumAltitude.value.resolutionUInt16(5) + 500

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .gpsAccuracy:
                if var gpsAccuracy = gpsAccuracy {
                    // 1 * m + 0
                    gpsAccuracy = gpsAccuracy.converted(to: UnitLength.meters)
                    let value = gpsAccuracy.value.resolutionInt8(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageGrade:
                if let averageGrade = averageGrade {
                    let value = encodeInt16Percent(averageGrade)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averagePositiveGrade:
                if let averagePositiveGrade = averagePositiveGrade {
                    let value = encodeInt16Percent(averagePositiveGrade)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageNegitiveGrade:
                if let averageNegitiveGrade = averageNegitiveGrade {
                    let value = encodeInt16Percent(averageNegitiveGrade)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumPositiveGrade:
                if let maximumPositiveGrade = maximumPositiveGrade {
                    let value = encodeInt16Percent(maximumPositiveGrade)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumNegitiveGrade:
                if let maximumNegitiveGrade = maximumNegitiveGrade {
                    let value = encodeInt16Percent(maximumNegitiveGrade)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageTemperature:
                if var averageTemperature = averageTemperature {
                    // 1 * C + 0
                    averageTemperature = averageTemperature.converted(to: UnitTemperature.celsius)
                    let value = averageTemperature.value.resolutionInt8(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumTemperature:
                if var maximumTemperature = maximumTemperature {
                    // 1 * C + 0
                    maximumTemperature = maximumTemperature.converted(to: UnitTemperature.celsius)
                    let value = maximumTemperature.value.resolutionInt8(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalMovingTime:
                if var totalMovingTime = totalMovingTime {
                    // 1000 * s + 0
                    totalMovingTime = totalMovingTime.converted(to: UnitDuration.seconds)
                    let value = totalMovingTime.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averagePositiveVerticalSpeed:
                if let averagePositiveVerticalSpeed = averagePositiveVerticalSpeed {
                    let value = encodeVerticalSpeed(averagePositiveVerticalSpeed)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageNegitiveVerticalSpeed:
                if let averageNegitiveVerticalSpeed = averageNegitiveVerticalSpeed {
                    let value = encodeVerticalSpeed(averageNegitiveVerticalSpeed)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumPositiveVerticalSpeed:
                if let maximumPositiveVerticalSpeed = maximumPositiveVerticalSpeed {
                    let value = encodeVerticalSpeed(maximumPositiveVerticalSpeed)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .maximumNegitiveVerticalSpeed:
                if let maximumNegitiveVerticalSpeed = maximumNegitiveVerticalSpeed {
                    let value = encodeVerticalSpeed(maximumNegitiveVerticalSpeed)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .minimumHeartRate:
                if let heartRate = minimumHeartRate {
                    // 1 * bpm + 0
                    let value = heartRate.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .timeInHeartRateZone:
                break
            case .timeInSpeedZone:
                break
            case .timeInCadenceZone:
                break
            case .timeInPowerZone:
                break

            case .averageLapTime:
                if var averageLapTime = averageLapTime {
                    // 1000 * s + 0
                    averageLapTime = averageLapTime.converted(to: UnitDuration.seconds)
                    let value = averageLapTime.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .bestLapIndex:
                if let bestLapIndex = bestLapIndex {
                    msgData.append(Data(from: bestLapIndex.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .minimumAltitude:
                if var minimumAltitude = minimumAltitude {
                    // 5 * m + 500
                    minimumAltitude = minimumAltitude.converted(to: UnitLength.meters)
                    let value = minimumAltitude.value.resolutionUInt16(5) + 500

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .playerScore:
                if let playerScore = score.playerScore {
                    msgData.append(Data(from: playerScore.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .opponentScore:
                if let opponentScore = score.opponentScore {
                    msgData.append(Data(from: opponentScore.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .opponentName:
                if let opponentName = opponentName {
                    if let stringData = opponentName.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }


            case .strokeCount:
                break
            case .zoneCount:
                break

            case .maximumBallSpeed:
                if var maximumBallSpeed = maximumBallSpeed {
                    // 100 * m/s + 0
                    maximumBallSpeed = maximumBallSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = maximumBallSpeed.value.resolutionUInt16(10)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageBallSpeed:
                if var averageBallSpeed = averageBallSpeed {
                    // 100 * m/s + 0
                    averageBallSpeed = averageBallSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = averageBallSpeed.value.resolutionUInt16(10)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageVerticalOscillation:
                if var averageVerticalOscillation = averageVerticalOscillation {
                    // 10 * mm + 0
                    averageVerticalOscillation = averageVerticalOscillation.converted(to: UnitLength.millimeters)
                    let value = averageVerticalOscillation.value.resolutionUInt16(10)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageStanceTimePercent:
                if let averageStanceTimePercent = averageStanceTime.percent {
                    let value = encodeUInt16Percent(averageStanceTimePercent)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageStanceTime:
                if var averageStanceTime = averageStanceTime.time {
                    // 10 * ms + 0
                    averageStanceTime = averageStanceTime.converted(to: UnitDuration.millisecond)
                    let value = averageStanceTime.value.resolutionUInt16(10)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageFractionalCadence:
                break
            case .maximumFractionalCadence:
                break
            case .totalFractionalCycles:
                break

            case .sportIndex:
                if let sportIndex = sportIndex {
                    msgData.append(sportIndex.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedAverageSpeed:
                if var enhancedAverageSpeed = enhancedAverageSpeed {
                    // 1000 * m/s + 0
                    enhancedAverageSpeed = enhancedAverageSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = enhancedAverageSpeed.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedMaximumSpeed:
                if var enhancedMaximumSpeed = enhancedMaximumSpeed {
                    // 1000 * m/s + 0
                    enhancedMaximumSpeed = enhancedMaximumSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = enhancedMaximumSpeed.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedAverageAltitude:
                if let enhancedAverageAltitude = enhancedAverageAltitude {
                    let valData = encodeEnhancedAltitude(enhancedAverageAltitude)
                    msgData.append(valData)

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedMinimumAltitude:
                if let enhancedMinimumAltitude = enhancedMinimumAltitude {
                    let valData = encodeEnhancedAltitude(enhancedMinimumAltitude)
                    msgData.append(valData)

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedMaximumAltitude:
                if let enhancedMaximumAltitude = enhancedMaximumAltitude {
                    let valData = encodeEnhancedAltitude(enhancedMaximumAltitude)
                    msgData.append(valData)

                    fileDefs.append(key.fieldDefinition())
                }

            case .averageVam:
                break
            case .totalAnaerobicTrainingEffect:
                break

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: SessionMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            var encodedMsg = Data()

            let defHeader = RecordHeader(localMessageType: 0, isDataMessage: false)
            encodedMsg.append(defHeader.normalHeader)
            encodedMsg.append(defMessage.encode())

            let recHeader = RecordHeader(localMessageType: 0, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "SessionMessage contains no Properties Available to Encode"))
        }
    }

}


private extension SessionMessage {

    func encodePower(_ power: ValidatedMeasurement<UnitPower>) -> Data {
        var vpower = power
        // 1 * watts + 0
        vpower = vpower.converted(to: UnitPower.watts)
        let value = vpower.value.resolutionUInt16(1)

        return Data(from: value.littleEndian)
    }

    func encodeUInt16Percent(_ percent: ValidatedMeasurement<UnitPercent>) -> Data {
        // 100 * % + 0
        let value = percent.value.resolutionUInt16(100)

        return Data(from: value.littleEndian)
    }

    func encodeInt16Percent(_ percent: ValidatedMeasurement<UnitPercent>) -> Data {
        // 100 * % + 0
        let value = percent.value.resolutionInt16(100)

        return Data(from: value.littleEndian)
    }

    func encodeVerticalSpeed(_ speed: ValidatedMeasurement<UnitSpeed>) -> Data {
        var vspeed = speed
        // 1000 * m/s + 0
        vspeed = vspeed.converted(to: UnitSpeed.metersPerSecond)
        let value = vspeed.value.resolutionInt16(1000)

        return Data(from: value.littleEndian)
    }

    func encodeEnhancedAltitude(_ alt: ValidatedMeasurement<UnitLength>) -> Data {
        var altitude = alt
        // 5 * m + 500
        altitude = altitude.converted(to: UnitLength.meters)
        let value = altitude.value.resolutionUInt32(5) + 500

        return Data(from: value.littleEndian)
    }

}
