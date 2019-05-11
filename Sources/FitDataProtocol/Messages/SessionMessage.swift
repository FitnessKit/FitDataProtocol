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
    ///
    /// Sesson end time
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Event
    ///
    /// - note: Event should be .session
    private(set) public var event: Event?

    /// Event Type
    ///
    /// - note: EventType should be .stop
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

    /// Velocità Ascensionale Media
    ///
    /// VAM - Average Ascent Speed
    private(set) public var averageAscentSpeed: ValidatedMeasurement<UnitSpeed>?

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
                averageAscentSpeed: ValidatedMeasurement<UnitSpeed>? = nil) {

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
        self.averageAscentSpeed = averageAscentSpeed

    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: SessionMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
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
        var averageAscentSpeed: ValidatedMeasurement<UnitSpeed>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("SessionMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)
                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        startPositionlatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        startPositionlatitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .startPositionLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        totalElapsedTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .totalTimerTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0, Time (excludes pauses)
                        let value = value.resolution(.removing, resolution: key.resolution)
                        totalTimerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .totalDistance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .maximumSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averagePower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        averagePower = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .maximumPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        maximumPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        maximumPower = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .totalAscent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        totalAscent = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        totalAscent = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .totalDescent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        necLatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        necLatitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .necLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        necLongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        necLongitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .swcLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        swcLatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        swcLatitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .swcLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        swcLongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        swcLongitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .normalizedPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        poolLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        poolLength = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .thresholdPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * watts + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        averageAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .maximumAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = value.resolution(.removing, resolution: key.resolution)
                        maximumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        maximumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .gpsAccuracy:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averagePositiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averagePositiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .averageNegitiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageNegitiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averageNegitiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .maximumPositiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        maximumPositiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        maximumPositiveGrade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .maximumNegitiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        totalMovingTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }
                    
                case .averagePositiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averagePositiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averagePositiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageNegitiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageNegitiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageNegitiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .maximumPositiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
                        maximumPositiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        maximumPositiveVerticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .maximumNegitiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
                        maximumBallSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        maximumBallSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageBallSpeed:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageBallSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageBallSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .averageVerticalOscillation:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * mm + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageVerticalOscillation = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.millimeters)
                    } else {
                        averageVerticalOscillation = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.millimeters)
                    }

                case .averageStanceTimePercent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * % + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageStancePercent = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        averageStancePercent = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .averageStanceTime:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * ms + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        enhancedAverageSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        enhancedAverageSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .enhancedMaximumSpeed:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(.removing, resolution: key.resolution)
                        enhancedMaximumSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        enhancedMaximumSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .enhancedAverageAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = value.resolution(.removing, resolution: key.resolution)
                        enhancedAverageAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedAverageAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .enhancedMinimumAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = value.resolution(.removing, resolution: key.resolution)
                        enhancedMinimumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedMinimumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .enhancedMaximumAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = value.resolution(.removing, resolution: key.resolution)
                        enhancedMaximumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedMaximumAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .totalAnaerobicTrainingEffect:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .averageVam:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * m/s + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        averageAscentSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        averageAscentSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                }
            }
        }

        /// Determine which Avg Speed to use
        let recordAvgSpeed = preferredValue(valueOne: averageSpeed, valueTwo: enhancedAverageSpeed)

        /// Determine which Avg Speed to use
        let recordMaxSpeed = preferredValue(valueOne: maximumSpeed, valueTwo: enhancedMaximumSpeed)

        /// Determine which Avg Altitude to use
        let recordAvgAltitude = preferredValue(valueOne: averageAltitude, valueTwo: enhancedAverageAltitude)

        /// Determine which Min Altitude to use
        let recordMinAltitude = preferredValue(valueOne: minimumAltitude, valueTwo: enhancedMinimumAltitude)

        /// Determine which Max Altitude to use
        let recordMaxAltitude = preferredValue(valueOne: maximumAltitude, valueTwo: enhancedMaximumAltitude)


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

        let msg = SessionMessage(timeStamp: timestamp,
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
                                 averageSpeed: recordAvgSpeed,
                                 maximumSpeed: recordMaxSpeed,
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
                                 averageAltitude: recordAvgAltitude,
                                 maximumAltitude: recordMaxAltitude,
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
                                 minimumAltitude: recordMinAltitude,
                                 score: score,
                                 opponentName: opponentName,
                                 maximumBallSpeed: maximumBallSpeed,
                                 averageBallSpeed: averageBallSpeed,
                                 averageVerticalOscillation: averageVerticalOscillation,
                                 averageStanceTime: averageStance,
                                 sportIndex: sportIndex,
                                 averageAscentSpeed: averageAscentSpeed)

        return.success(msg as! F)
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
        
        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let _ = messageIndex { fileDefs.append(key.fieldDefinition()) }
            case .timestamp:
                if let _ = timeStamp { fileDefs.append(key.fieldDefinition()) }

            case .event:
                if let _ = event { fileDefs.append(key.fieldDefinition()) }
            case .eventType:
                if let _ = eventType { fileDefs.append(key.fieldDefinition()) }
            case .startTime:
                if let _ = startTime { fileDefs.append(key.fieldDefinition()) }
            case .startPositionLatitude:
                if let _ = startPosition.latitude { fileDefs.append(key.fieldDefinition()) }
            case .startPositionLongitude:
                if let _ = startPosition.longitude { fileDefs.append(key.fieldDefinition()) }
            case .sport:
                if let _ = sport { fileDefs.append(key.fieldDefinition()) }
            case .subSport:
                if let _ = subSport { fileDefs.append(key.fieldDefinition()) }
            case .totalElapsedTime:
                if let _ = totalElapsedTime { fileDefs.append(key.fieldDefinition()) }
            case .totalTimerTime:
                if let _ = totalTimerTime { fileDefs.append(key.fieldDefinition()) }
            case .totalDistance:
                if let _ = totalDistance { fileDefs.append(key.fieldDefinition()) }
            case .totalCycles:
                if let _ = totalCycles { fileDefs.append(key.fieldDefinition()) }
            case .totalCalories:
                if let _ = totalCalories { fileDefs.append(key.fieldDefinition()) }
            case .totalFatCalories:
                if let _ = totalFatCalories { fileDefs.append(key.fieldDefinition()) }
            case .averageSpeed:
                /// use enhancedAverageSpeed
                break
            case .maximumSpeed:
                /// use enhancedMaximumSpeed
                break
            case .averageHeartRate:
                if let _ = averageHeartRate { fileDefs.append(key.fieldDefinition()) }
            case .maximumHeartRate:
                if let _ = maximumHeartRate { fileDefs.append(key.fieldDefinition()) }
            case .averageCadence:
                if let _ = averageCadence { fileDefs.append(key.fieldDefinition()) }
            case .maximumCadence:
                if let _ = maximumCadence { fileDefs.append(key.fieldDefinition()) }
            case .averagePower:
                if let _ = averagePower { fileDefs.append(key.fieldDefinition()) }
            case .maximumPower:
                if let _ = maximumPower { fileDefs.append(key.fieldDefinition()) }
            case .totalAscent:
                if let _ = totalAscent { fileDefs.append(key.fieldDefinition()) }
            case .totalDescent:
                if let _ = totalDescent { fileDefs.append(key.fieldDefinition()) }
            case .totalTrainingEffect:
                if let _ = totalTrainingEffect { fileDefs.append(key.fieldDefinition()) }
            case .firstLapIndex:
                if let _ = firstLapIndex { fileDefs.append(key.fieldDefinition()) }
            case .numberOfLaps:
                if let _ = numberOfLaps { fileDefs.append(key.fieldDefinition()) }
            case .eventGroup:
                if let _ = eventGroup { fileDefs.append(key.fieldDefinition()) }
            case .trigger:
                if let _ = trigger { fileDefs.append(key.fieldDefinition()) }
            case .necLatitude:
                if let _ = necPosition.encodeLatitude() { fileDefs.append(key.fieldDefinition()) }
            case .necLongitude:
                if let _ = necPosition.longitude { fileDefs.append(key.fieldDefinition()) }
            case .swcLatitude:
                if let _ = swcPosition.latitude { fileDefs.append(key.fieldDefinition()) }
            case .swcLongitude:
                if let _ = swcPosition.longitude { fileDefs.append(key.fieldDefinition()) }
            case .normalizedPower:
                if let _ = normalizedPower { fileDefs.append(key.fieldDefinition()) }
            case .trainingStressScore:
                break
            case .intensityFactor:
                break
            case .leftRightBalance:
                break
            case .averageStrokeCount:
                break
            case .averageStrokeDistance:
                if let _ = averageStrokeDistance { fileDefs.append(key.fieldDefinition()) }
            case .swimStroke:
                if let _ = swimStroke { fileDefs.append(key.fieldDefinition()) }
            case .poolLength:
                if let _ = poolLength { fileDefs.append(key.fieldDefinition()) }
            case .thresholdPower:
                if let _ = thresholdPower { fileDefs.append(key.fieldDefinition()) }
            case .poolLengthUnit:
                if let _ = poolLengthUnit { fileDefs.append(key.fieldDefinition()) }
            case .numberActiveLengths:
                if let _ = activeLengths { fileDefs.append(key.fieldDefinition()) }
            case .totalWork:
                if let _ = totalWork { fileDefs.append(key.fieldDefinition()) }
            case .averageAltitude:
                /// use enhancedAverageAltitude
                break
            case .maximumAltitude:
                /// use enhancedMaximumAltitude
                break
            case .gpsAccuracy:
                if let _ = gpsAccuracy { fileDefs.append(key.fieldDefinition()) }
            case .averageGrade:
                if let _ = averageGrade { fileDefs.append(key.fieldDefinition()) }
            case .averagePositiveGrade:
                if let _ = averagePositiveGrade { fileDefs.append(key.fieldDefinition()) }
            case .averageNegitiveGrade:
                if let _ = averageNegitiveGrade { fileDefs.append(key.fieldDefinition()) }
            case .maximumPositiveGrade:
                if let _ = maximumPositiveGrade { fileDefs.append(key.fieldDefinition()) }
            case .maximumNegitiveGrade:
                if let _ = maximumNegitiveGrade { fileDefs.append(key.fieldDefinition()) }
            case .averageTemperature:
                if let _ = averageTemperature { fileDefs.append(key.fieldDefinition()) }
            case .maximumTemperature:
                if let _ = maximumTemperature { fileDefs.append(key.fieldDefinition()) }
            case .totalMovingTime:
                if let _ = totalMovingTime { fileDefs.append(key.fieldDefinition()) }
            case .averagePositiveVerticalSpeed:
                if let _ = averagePositiveVerticalSpeed { fileDefs.append(key.fieldDefinition()) }
            case .averageNegitiveVerticalSpeed:
                if let _ = averageNegitiveVerticalSpeed { fileDefs.append(key.fieldDefinition()) }
            case .maximumPositiveVerticalSpeed:
                if let _ = maximumPositiveVerticalSpeed { fileDefs.append(key.fieldDefinition()) }
            case .maximumNegitiveVerticalSpeed:
                if let _ = maximumNegitiveVerticalSpeed { fileDefs.append(key.fieldDefinition()) }
            case .minimumHeartRate:
                if let _ = minimumHeartRate { fileDefs.append(key.fieldDefinition()) }
            case .timeInHeartRateZone:
                break
            case .timeInSpeedZone:
                break
            case .timeInCadenceZone:
                break
            case .timeInPowerZone:
                break
            case .averageLapTime:
                if let _ = averageLapTime { fileDefs.append(key.fieldDefinition()) }
            case .bestLapIndex:
                if let _ = bestLapIndex { fileDefs.append(key.fieldDefinition()) }
            case .minimumAltitude:
                /// use enhancedMinimumAltitude
                break
            case .playerScore:
                if let _ = score.playerScore { fileDefs.append(key.fieldDefinition()) }
            case .opponentScore:
                if let _ = score.opponentScore { fileDefs.append(key.fieldDefinition()) }
            case .opponentName:
                if let stringData = opponentName?.data(using: .utf8) {
                    //16 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("opponentName size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .strokeCount:
                break
            case .zoneCount:
                break
            case .maximumBallSpeed:
                if let _ = maximumBallSpeed { fileDefs.append(key.fieldDefinition()) }
            case .averageBallSpeed:
                if let _ = averageBallSpeed { fileDefs.append(key.fieldDefinition()) }
            case .averageVerticalOscillation:
                if let _ = averageVerticalOscillation { fileDefs.append(key.fieldDefinition()) }
            case .averageStanceTimePercent:
                if let _ = averageStanceTime.percent { fileDefs.append(key.fieldDefinition()) }
            case .averageStanceTime:
                if let _ = averageStanceTime.time { fileDefs.append(key.fieldDefinition()) }
            case .averageFractionalCadence:
                break
            case .maximumFractionalCadence:
                break
            case .totalFractionalCycles:
                break
            case .sportIndex:
                if let _ = sportIndex { fileDefs.append(key.fieldDefinition()) }
            case .enhancedAverageSpeed:
                if let _ = averageSpeed { fileDefs.append(key.fieldDefinition()) }
            case .enhancedMaximumSpeed:
                if let _ = maximumSpeed { fileDefs.append(key.fieldDefinition()) }
            case .enhancedAverageAltitude:
                if let _ = averageAltitude { fileDefs.append(key.fieldDefinition()) }
            case .enhancedMinimumAltitude:
                if let _ = minimumAltitude { fileDefs.append(key.fieldDefinition()) }
            case .enhancedMaximumAltitude:
                if let _ = maximumAltitude { fileDefs.append(key.fieldDefinition()) }
            case .totalAnaerobicTrainingEffect:
                break
            case .averageVam:
                if let _ = averageAscentSpeed { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: SessionMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return.success(defMessage)
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
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

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())
                }

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())
                }

            case .event:
                if let event = event {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: event)) {
                        return.failure(error)
                    }
                }

            case .eventType:
                if let eventType = eventType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: eventType)) {
                        return.failure(error)
                    }
                }

            case .startTime:
                if let startTime = startTime {
                    msgData.append(startTime.encode())
                }

            case .startPositionLatitude:
                if let value = startPosition.encodeLatitude() {
                    msgData.append(value)
                }

            case .startPositionLongitude:
                if let value = startPosition.encodeLongitude() {
                    msgData.append(value)
                }

            case .sport:
                if let sport = sport {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: sport)) {
                        return.failure(error)
                    }
                }

            case .subSport:
                if let subSport = subSport {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: subSport)) {
                        return.failure(error)
                    }
                }

            case .totalElapsedTime:
                if var totalElapsedTime = totalElapsedTime {
                    totalElapsedTime = totalElapsedTime.converted(to: UnitDuration.seconds)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalElapsedTime.value)) {
                        return.failure(error)
                    }
                }

            case .totalTimerTime:
                if var totalTimerTime = totalTimerTime {
                    totalTimerTime = totalTimerTime.converted(to: UnitDuration.seconds)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalTimerTime.value)) {
                        return.failure(error)
                    }
                }

            case .totalDistance:
                if var totalDistance = totalDistance {
                    totalDistance = totalDistance.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalDistance.value)) {
                        return.failure(error)
                    }
                }

            case .totalCycles:
                if let totalCycles = totalCycles {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalCycles)) {
                        return.failure(error)
                    }
                }

            case .totalCalories:
                if var totalCalories = totalCalories {
                    totalCalories = totalCalories.converted(to: UnitEnergy.kilocalories)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalCalories.value)) {
                        return.failure(error)
                    }
                }

            case .totalFatCalories:
                if var totalFatCalories = totalFatCalories {
                    totalFatCalories = totalFatCalories.converted(to: UnitEnergy.kilocalories)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalFatCalories.value)) {
                        return.failure(error)
                    }
                }

            case .averageSpeed:
                /// use EnhancedAverageSpeed
                break
            case .maximumSpeed:
                /// use enhancedMaximumSpeed
                break
            case .averageHeartRate:
                if let averageHeartRate = averageHeartRate {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageHeartRate.value)) {
                        return.failure(error)
                    }
                }

            case .maximumHeartRate:
                if let maximumHeartRate = maximumHeartRate {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maximumHeartRate.value)) {
                        return.failure(error)
                    }
                }

            case .averageCadence:
                if let averageCadence = averageCadence {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageCadence.value)) {
                        return.failure(error)
                    }
                }

            case .maximumCadence:
                if let maximumCadence = maximumCadence {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maximumCadence.value)) {
                        return.failure(error)
                    }
                }

            case .averagePower:
                if var power = averagePower {
                    power = power.converted(to: UnitPower.watts)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: power.value)) {
                        return.failure(error)
                    }
                }

            case .maximumPower:
                if var power = maximumPower {
                    power = power.converted(to: UnitPower.watts)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: power.value)) {
                        return.failure(error)
                    }
                }

            case .totalAscent:
                if var totalAscent = totalAscent {
                    totalAscent = totalAscent.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalAscent.value)) {
                        return.failure(error)
                    }
                }

            case .totalDescent:
                if var totalDescent = totalDescent {
                    totalDescent = totalDescent.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalDescent.value)) {
                        return.failure(error)
                    }
                }

            case .totalTrainingEffect:
                if let totalTrainingEffect = totalTrainingEffect {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalTrainingEffect)) {
                        return.failure(error)
                    }
                }

            case .firstLapIndex:
                if let firstLapIndex = firstLapIndex {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: firstLapIndex)) {
                        return.failure(error)
                    }
                }

            case .numberOfLaps:
                if let numberOfLaps = numberOfLaps {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: numberOfLaps)) {
                        return.failure(error)
                    }
                }

            case .eventGroup:
                if let eventGroup = eventGroup {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: eventGroup)) {
                        return.failure(error)
                    }
                }

            case .trigger:
                if let trigger = trigger {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: trigger)) {
                        return.failure(error)
                    }
                }

            case .necLatitude:
                if let value = necPosition.encodeLatitude() {
                    msgData.append(value)
                }

            case .necLongitude:
                if let value = necPosition.encodeLongitude() {
                    msgData.append(value)
                }

            case .swcLatitude:
                if let value = swcPosition.encodeLatitude() {
                    msgData.append(value)
                }

            case .swcLongitude:
                if let value = swcPosition.encodeLongitude() {
                    msgData.append(value)
                }

            case .normalizedPower:
                if var normalizedPower = normalizedPower {
                    normalizedPower = normalizedPower.converted(to: UnitPower.watts)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: normalizedPower.value)) {
                        return.failure(error)
                    }
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
                    averageStrokeDistance = averageStrokeDistance.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageStrokeDistance.value)) {
                        return.failure(error)
                    }
                }

            case .swimStroke:
                if let swimStroke = swimStroke {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: swimStroke)) {
                        return.failure(error)
                    }
                }

            case .poolLength:
                if var poolLength = poolLength {
                    // 100 * m + 0
                    poolLength = poolLength.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: poolLength.value)) {
                        return.failure(error)
                    }
                }

            case .thresholdPower:
                if var thresholdPower = thresholdPower {
                    thresholdPower = thresholdPower.converted(to: UnitPower.watts)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: thresholdPower.value)) {
                        return.failure(error)
                    }
                }

            case .poolLengthUnit:
                if let poolLengthUnit = poolLengthUnit {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: poolLengthUnit)) {
                        return.failure(error)
                    }
                }

            case .numberActiveLengths:
                if let numberActiveLengths = activeLengths {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: numberActiveLengths)) {
                        return.failure(error)
                    }
                }

            case .totalWork:
                if var totalWork = totalWork {
                    totalWork = totalWork.converted(to: UnitEnergy.joules)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalWork.value)) {
                        return.failure(error)
                    }
                }

            case .averageAltitude:
                /// use enhancedAverageAltitude
                break
            case .maximumAltitude:
                /// use enhancedMaximumAltitude
                break
            case .gpsAccuracy:
                if var gpsAccuracy = gpsAccuracy {
                    gpsAccuracy = gpsAccuracy.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: gpsAccuracy.value)) {
                        return.failure(error)
                    }
                }

            case .averageGrade:
                if let averageGrade = averageGrade {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageGrade.value)) {
                        return.failure(error)
                    }
                }

            case .averagePositiveGrade:
                if let averagePositiveGrade = averagePositiveGrade {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averagePositiveGrade.value)) {
                        return.failure(error)
                    }
                }

            case .averageNegitiveGrade:
                if let averageNegitiveGrade = averageNegitiveGrade {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageNegitiveGrade.value)) {
                        return.failure(error)
                    }
                }

            case .maximumPositiveGrade:
                if let maximumPositiveGrade = maximumPositiveGrade {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maximumPositiveGrade.value)) {
                        return.failure(error)
                    }
                }

            case .maximumNegitiveGrade:
                if let maximumNegitiveGrade = maximumNegitiveGrade {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maximumNegitiveGrade.value)) {
                        return.failure(error)
                    }
                }

            case .averageTemperature:
                if var averageTemperature = averageTemperature {
                    averageTemperature = averageTemperature.converted(to: UnitTemperature.celsius)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageTemperature.value)) {
                        return.failure(error)
                    }
                }

            case .maximumTemperature:
                if var maximumTemperature = maximumTemperature {
                    maximumTemperature = maximumTemperature.converted(to: UnitTemperature.celsius)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maximumTemperature.value)) {
                        return.failure(error)
                    }
                }

            case .totalMovingTime:
                if var totalMovingTime = totalMovingTime {
                    totalMovingTime = totalMovingTime.converted(to: UnitDuration.seconds)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: totalMovingTime.value)) {
                        return.failure(error)
                    }
                }

            case .averagePositiveVerticalSpeed:
                if var vspeed = averagePositiveVerticalSpeed {
                    vspeed = vspeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: vspeed.value)) {
                        return.failure(error)
                    }
                }

            case .averageNegitiveVerticalSpeed:
                if var vspeed = averageNegitiveVerticalSpeed {
                    vspeed = vspeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: vspeed.value)) {
                        return.failure(error)
                    }
                }

            case .maximumPositiveVerticalSpeed:
                if var vspeed = maximumPositiveVerticalSpeed {
                    vspeed = vspeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: vspeed.value)) {
                        return.failure(error)
                    }
                }

            case .maximumNegitiveVerticalSpeed:
                if var vspeed = maximumNegitiveVerticalSpeed {
                    vspeed = vspeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: vspeed.value)) {
                        return.failure(error)
                    }
                }

            case .minimumHeartRate:
                if let heartRate = minimumHeartRate {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: heartRate.value)) {
                        return.failure(error)
                    }
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
                    averageLapTime = averageLapTime.converted(to: UnitDuration.seconds)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageLapTime.value)) {
                        return.failure(error)
                    }
                }

            case .bestLapIndex:
                if let bestLapIndex = bestLapIndex {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: bestLapIndex)) {
                        return.failure(error)
                    }
                }

            case .minimumAltitude:
                /// use enhancedMinimumAltitude
                break
            case .playerScore:
                if let playerScore = score.playerScore {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: playerScore)) {
                        return.failure(error)
                    }
                }

            case .opponentScore:
                if let opponentScore = score.opponentScore {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: opponentScore)) {
                        return.failure(error)
                    }
                }

            case .opponentName:
                if let opponentName = opponentName {
                    if let stringData = opponentName.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .strokeCount:
                break
            case .zoneCount:
                break

            case .maximumBallSpeed:
                if var maximumBallSpeed = maximumBallSpeed {
                    maximumBallSpeed = maximumBallSpeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maximumBallSpeed.value)) {
                        return.failure(error)
                    }
                }

            case .averageBallSpeed:
                if var averageBallSpeed = averageBallSpeed {
                    averageBallSpeed = averageBallSpeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageBallSpeed.value)) {
                        return.failure(error)
                    }
                }

            case .averageVerticalOscillation:
                if var averageVerticalOscillation = averageVerticalOscillation {
                    averageVerticalOscillation = averageVerticalOscillation.converted(to: UnitLength.millimeters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageVerticalOscillation.value)) {
                        return.failure(error)
                    }
                }

            case .averageStanceTimePercent:
                if let averageStanceTimePercent = averageStanceTime.percent {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageStanceTimePercent.value)) {
                        return.failure(error)
                    }
                }

            case .averageStanceTime:
                if var averageStanceTime = averageStanceTime.time {
                    // 10 * ms + 0
                    averageStanceTime = averageStanceTime.converted(to: UnitDuration.millisecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageStanceTime.value)) {
                        return.failure(error)
                    }
                }

            case .averageFractionalCadence:
                break
            case .maximumFractionalCadence:
                break
            case .totalFractionalCycles:
                break

            case .sportIndex:
                if let sportIndex = sportIndex {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: sportIndex)) {
                        return.failure(error)
                    }
                }

            case .enhancedAverageSpeed:
                if var enhancedAverageSpeed = averageSpeed {
                    enhancedAverageSpeed = enhancedAverageSpeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: enhancedAverageSpeed.value)) {
                        return.failure(error)
                    }
                }

            case .enhancedMaximumSpeed:
                if var enhancedMaximumSpeed = maximumSpeed {
                    enhancedMaximumSpeed = enhancedMaximumSpeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: enhancedMaximumSpeed.value)) {
                        return.failure(error)
                    }
                }

            case .enhancedAverageAltitude:
                if var altitude = averageAltitude {
                    altitude = altitude.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: altitude.value)) {
                        return.failure(error)
                    }
                }

            case .enhancedMinimumAltitude:
                if var altitude = minimumAltitude {
                    altitude = altitude.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: altitude.value)) {
                        return.failure(error)
                    }
                }

            case .enhancedMaximumAltitude:
                if var altitude = maximumAltitude {
                    altitude = altitude.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: altitude.value)) {
                        return.failure(error)
                    }
                }

            case .totalAnaerobicTrainingEffect:
                break
            case .averageVam:
                if var averageAscentSpeed = averageAscentSpeed {
                    averageAscentSpeed = averageAscentSpeed.converted(to: UnitSpeed.metersPerSecond)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: averageAscentSpeed.value)) {
                        return.failure(error)
                    }
                }

            }
        }

        if msgData.message.count > 0 {
            return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData.message))
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
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

        guard self.event != nil else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain event, can not be nil")
        }

        guard self.eventType != nil else {
            throw FitEncodingError.fileType("\(msg) require SessionMessage to contain eventType, can not be nil")
        }

    }
}
