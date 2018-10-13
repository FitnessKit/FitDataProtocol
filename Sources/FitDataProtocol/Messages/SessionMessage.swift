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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SessionMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 18
    }

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
    /// Excludeds pauses
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
    private(set) public var poolLength: Measurement<UnitLength>?

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

    public init(timeStamp: FitTime?,
                messageIndex: MessageIndex?,
                event: Event?,
                eventType: EventType?,
                startTime: FitTime?,
                startPosition: Position,
                sport: Sport?,
                subSport: SubSport?,
                totalElapsedTime: Measurement<UnitDuration>?,
                totalTimerTime: Measurement<UnitDuration>?,
                totalDistance: ValidatedMeasurement<UnitLength>?,
                totalCycles: ValidatedBinaryInteger<UInt32>?,
                totalCalories: ValidatedMeasurement<UnitEnergy>?,
                totalFatCalories: ValidatedMeasurement<UnitEnergy>?,
                averageSpeed: ValidatedMeasurement<UnitSpeed>?,
                maximumSpeed: ValidatedMeasurement<UnitSpeed>?,
                averageHeartRate: UInt8?,
                maximumHeartRate: UInt8?,
                averageCadence: UInt8?,
                maximumCadence: UInt8?,
                averagePower: ValidatedMeasurement<UnitPower>?,
                maximumPower: ValidatedMeasurement<UnitPower>?,
                totalAscent: ValidatedMeasurement<UnitLength>?,
                totalDescent: ValidatedMeasurement<UnitLength>?,
                totalTrainingEffect: ValidatedBinaryInteger<UInt8>?,
                firstLapIndex: ValidatedBinaryInteger<UInt16>?,
                numberOfLaps: ValidatedBinaryInteger<UInt16>?,
                eventGroup: ValidatedBinaryInteger<UInt8>?,
                trigger: SessionTrigger?,
                necPosition: Position,
                swcPosition: Position,
                normalizedPower: ValidatedMeasurement<UnitPower>?,
                averageStrokeDistance: ValidatedMeasurement<UnitLength>?,
                swimStroke: SwimStroke?,
                poolLength: Measurement<UnitLength>?,
                poolLengthUnit: MeasurementDisplayType?,
                thresholdPower: ValidatedMeasurement<UnitPower>?,
                activeLengths: ValidatedBinaryInteger<UInt16>?,
                totalWork: ValidatedMeasurement<UnitEnergy>?,
                averageAltitude: ValidatedMeasurement<UnitLength>?,
                maximumAltitude: ValidatedMeasurement<UnitLength>?,
                gpsAccuracy: ValidatedMeasurement<UnitLength>?,
                averageGrade: ValidatedMeasurement<UnitPercent>?,
                averagePositiveGrade: ValidatedMeasurement<UnitPercent>?,
                averageNegitiveGrade: ValidatedMeasurement<UnitPercent>?,
                maximumPositiveGrade: ValidatedMeasurement<UnitPercent>?,
                maximumNegitiveGrade: ValidatedMeasurement<UnitPercent>?,
                averageTemperature: ValidatedMeasurement<UnitTemperature>?,
                maximumTemperature: ValidatedMeasurement<UnitTemperature>?,
                totalMovingTime: Measurement<UnitDuration>?,
                averagePositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?,
                averageNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?,
                maximumPositiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?,
                maximumNegitiveVerticalSpeed: ValidatedMeasurement<UnitSpeed>?,
                minimumHeartRate: UInt8?,
                averageLapTime: Measurement<UnitDuration>?,
                bestLapIndex: ValidatedBinaryInteger<UInt16>?,
                minimumAltitude: ValidatedMeasurement<UnitLength>?,
                score: Score,
                opponentName: String?,
                maximumBallSpeed: ValidatedMeasurement<UnitSpeed>?,
                averageBallSpeed: ValidatedMeasurement<UnitSpeed>?,
                averageVerticalOscillation: ValidatedMeasurement<UnitLength>?,
                averageStanceTime: StanceTime,
                sportIndex: ValidatedBinaryInteger<UInt8>?,
                enhancedAverageSpeed: ValidatedMeasurement<UnitSpeed>?,
                enhancedMaximumSpeed: ValidatedMeasurement<UnitSpeed>?,
                enhancedAverageAltitude: ValidatedMeasurement<UnitLength>?,
                enhancedMinimumAltitude: ValidatedMeasurement<UnitLength>?,
                enhancedMaximumAltitude: ValidatedMeasurement<UnitLength>?) {

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

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.averageHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.averageHeartRate = nil
        }

        if let hr = maximumHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.maximumHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.maximumHeartRate = nil
        }

        if let cadence = averageCadence {

            let valid = !(Int64(cadence) == BaseType.uint8.invalid)
            self.averageCadence = ValidatedMeasurement(value: Double(cadence), valid: valid, unit: UnitCadence.revolutionsPerMinute)

        } else {
            self.averageCadence = nil
        }

        if let cadence = maximumCadence {

            let valid = !(Int64(cadence) == BaseType.uint8.invalid)
            self.maximumCadence = ValidatedMeasurement(value: Double(cadence), valid: valid, unit: UnitCadence.revolutionsPerMinute)

        } else {
            self.maximumCadence = nil
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

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.minimumHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.minimumHeartRate = nil
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
        var poolLength: Measurement<UnitLength>?
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
                    event = Event.decode(decoder: &localDecoder, definition: definition, data: fieldData, dataStrategy: dataStrategy)

                case .eventType:
                    eventType = EventType.decode(decoder: &localDecoder, definition: definition, data: fieldData, dataStrategy: dataStrategy)

                case .startTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        startTime = FitTime(time: value)
                    }

                case .startPositionLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        startPositionlatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            startPositionlatitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .startPositionLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        startPositionlongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            startPositionlongitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .sport:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        sport = Sport(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            sport = Sport.invalid
                        }
                    }

                case .subSport:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        subSport = SubSport(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            subSport = SubSport.invalid
                        }
                    }

                case .totalElapsedTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0, Time (includes pauses)
                        let value = value.resolution(1 / 1000)
                        totalElapsedTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .totalTimerTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0, Time (excludes pauses)
                        let value = value.resolution(1 / 1000)
                        totalTimerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .totalDistance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        totalDistance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalDistance = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .totalCycles:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * cycles + 0
                        totalCycles = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalCycles = ValidatedBinaryInteger(value: UInt32(definition.baseType.invalid), valid: false)
                        }
                    }

                case .totalCalories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * kcal + 0
                        totalCalories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalCalories = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .totalFatCalories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * kcal + 0
                        totalFatCalories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalFatCalories = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .averageSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        averageSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .maximumSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        maximumSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .averageHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        averageHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .maximumHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        maximumHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .averageCadence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * rpm + 0
                        averageCadence = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageCadence = UInt8(definition.baseType.invalid)
                        }
                    }

                case .maximumCadence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * rpm + 0
                        maximumCadence = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumCadence = UInt8(definition.baseType.invalid)
                        }
                    }

                case .averagePower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        averagePower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averagePower = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPower.watts)
                        }
                    }

                case .maximumPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        maximumPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumPower = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPower.watts)
                        }
                    }

                case .totalAscent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * m + 0
                        let value = value.resolution(1)
                        totalAscent = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalAscent = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .totalDescent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * m + 0
                        let value = value.resolution(1)
                        totalDescent = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalDescent = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .totalTrainingEffect:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        totalTrainingEffect = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalTrainingEffect = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .firstLapIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        firstLapIndex = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            firstLapIndex = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .numberOfLaps:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        numberOfLaps = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            numberOfLaps = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .eventGroup:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        eventGroup = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            eventGroup = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .trigger:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        trigger = SessionTrigger(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            trigger = SessionTrigger.invalid
                        }
                    }

                case .necLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        necLatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            necLatitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .necLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        necLongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            necLongitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .swcLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        swcLatitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            swcLatitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .swcLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        swcLongitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            swcLongitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .normalizedPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        normalizedPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            normalizedPower = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPower.watts)
                        }
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
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        averageStrokeDistance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageStrokeDistance = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .swimStroke:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        swimStroke = SwimStroke(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            swimStroke = SwimStroke.invalid
                        }
                    }

                case .poolLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  100 * m + 0
                        let value = value.resolution(1 / 100)
                        poolLength = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            poolLength = Measurement(value: Double(UInt16(definition.baseType.invalid)), unit: UnitLength.meters)
                        }
                    }

                case .thresholdPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        thresholdPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            thresholdPower = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPower.watts)
                        }
                    }

                case .poolLengthUnit:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        poolLengthUnit = MeasurementDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            poolLengthUnit = MeasurementDisplayType.invalid
                        }
                    }

                case .numberActiveLengths:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * lengths + 0
                        activeLengths = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            activeLengths = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .totalWork:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * j + 0
                        totalWork = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.joules)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalWork = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.joules)
                        }
                    }

                case .averageAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        averageAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .maximumAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        maximumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .gpsAccuracy:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * m + 0
                        gpsAccuracy = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            gpsAccuracy = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .averageGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        averageGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageGrade = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .averagePositiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        averagePositiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averagePositiveGrade = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .averageNegitiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        averageNegitiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageNegitiveGrade = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .maximumPositiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        maximumPositiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumPositiveGrade = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .maximumNegitiveGrade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        maximumNegitiveGrade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumNegitiveGrade = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .averageTemperature:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * C + 0
                        averageTemperature = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitTemperature.celsius)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageTemperature = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitTemperature.celsius)
                        }
                    }

                case .maximumTemperature:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * C + 0
                        maximumTemperature = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitTemperature.celsius)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumTemperature = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitTemperature.celsius)
                        }
                    }

                case .totalMovingTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        totalMovingTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }
                    
                case .averagePositiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        averagePositiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averagePositiveVerticalSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .averageNegitiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        averageNegitiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageNegitiveVerticalSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .maximumPositiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        maximumPositiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumPositiveVerticalSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .maximumNegitiveVerticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        maximumNegitiveVerticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumNegitiveVerticalSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .minimumHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        minimumHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            minimumHeartRate = UInt8(definition.baseType.invalid)
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
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        averageLapTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .bestLapIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        bestLapIndex = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            bestLapIndex = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .minimumAltitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        minimumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            minimumAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .playerScore:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        playerScore = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            playerScore = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .opponentScore:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        opponentScore = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            opponentScore = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .opponentName:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        opponentName = stringData.smartString
                    }

                case .strokeCount:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .zoneCount:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .maximumBallSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * m/s + 0,
                        let value = value.resolution(1 / 100)
                        maximumBallSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maximumBallSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .averageBallSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * m/s + 0,
                        let value = value.resolution(1 / 100)
                        averageBallSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageBallSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .averageVerticalOscillation:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 10 * mm + 0
                        let value = value.resolution(1 / 10)
                        averageVerticalOscillation = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.millimeters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageVerticalOscillation = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.millimeters)
                        }
                    }

                case .averageStanceTimePercent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        averageStancePercent = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageStancePercent = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .averageStanceTime:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 10 * ms + 0
                        let value = value.resolution(1 / 10)
                        averageStanceTime = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.millisecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            averageStanceTime = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitDuration.millisecond)
                        }
                    }

                case .averageFractionalCadence:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .maximumFractionalCadence:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalFractionalCycles:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .sportIndex:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        sportIndex = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            sportIndex = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .enhancedAverageSpeed:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        enhancedAverageSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedAverageSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .enhancedMaximumSpeed:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        enhancedMaximumSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedMaximumSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .enhancedAverageAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedAverageAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedAverageAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .enhancedMinimumAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedMinimumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedMinimumAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .enhancedMaximumAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedMaximumAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedMaximumAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .averageVam:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalAnaerobicTrainingEffect:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timestamp:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

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
}
