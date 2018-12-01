//
//  RecordMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
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

/// FIT Record Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class RecordMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 20 }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Position
    private(set) public var position: Position

    /// Distance
    private(set) public var distance: ValidatedMeasurement<UnitLength>?

    /// Time From Course
    private(set) public var timeFromCourse: ValidatedMeasurement<UnitDuration>?

    /// Cycles
    private(set) public var cycles: ValidatedBinaryInteger<UInt8>?

    /// Total Cycles
    private(set) public var totalCycles: ValidatedBinaryInteger<UInt32>?

    /// Accumulated Power
    private(set) public var accumulatedPower: ValidatedMeasurement<UnitPower>?

    /// Enhanced Speed
    private(set) public var enhancedSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Enhanced Altitude
    private(set) public var enhancedAltitude: ValidatedMeasurement<UnitLength>?

    /// Altitude
    private(set) public var altitude: ValidatedMeasurement<UnitLength>?

    /// Speed
    private(set) public var speed: ValidatedMeasurement<UnitSpeed>?

    /// Power
    private(set) public var power: ValidatedMeasurement<UnitPower>?

    /// GPS Accuracy
    private(set) public var gpsAccuracy: ValidatedMeasurement<UnitLength>?

    /// Vertical Speed
    private(set) public var verticalSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Calories
    private(set) public var calories: ValidatedMeasurement<UnitEnergy>?

    /// Vertical Oscillation
    private(set) public var verticalOscillation: ValidatedMeasurement<UnitLength>?

    /// Stance Time
    private(set) public var stanceTime: StanceTime

    /// Heart Rate
    private(set) public var heartRate: ValidatedMeasurement<UnitCadence>?

    /// Cadence
    private(set) public var cadence: ValidatedMeasurement<UnitCadence>?

    /// Grade
    private(set) public var grade: ValidatedMeasurement<UnitPercent>?

    /// Resistance
    ///
    /// Relative. 0 is none  254 is Max
    private(set) public var resistance: ValidatedBinaryInteger<UInt8>?

    /// Cycle Length
    private(set) public var cycleLength: ValidatedMeasurement<UnitLength>?

    /// Temperature
    private(set) public var temperature: ValidatedMeasurement<UnitTemperature>?

    /// FIT Activity Type
    private(set) public var activity: ActivityType?

    /// Torque Effectiveness
    private(set) public var torqueEffectiveness: TorqueEffectiveness

    /// Pedal Smoothness
    private(set) public var pedalSmoothness: PedalSmoothness

    /// Stroke Type
    private(set) public var stroke: Stroke?

    /// Zone
    private(set) public var zone: ValidatedBinaryInteger<UInt8>?

    /// Ball Speed
    private(set) public var ballSpeed: ValidatedMeasurement<UnitSpeed>?

    /// Device Index
    private(set) public var deviceIndex: DeviceIndex?

    public required init() {
        self.position = Position(latitude: nil, longitude: nil)
        self.torqueEffectiveness = TorqueEffectiveness(left: nil, right: nil)
        self.pedalSmoothness = PedalSmoothness(right: nil, left: nil, combined: nil)
        self.stanceTime = StanceTime(percent: nil, time: nil)
    }

    public init(timeStamp: FitTime? = nil,
                position: Position,
                distance: ValidatedMeasurement<UnitLength>? = nil,
                timeFromCourse: ValidatedMeasurement<UnitDuration>? = nil,
                cycles: ValidatedBinaryInteger<UInt8>? = nil,
                totalCycles: ValidatedBinaryInteger<UInt32>? = nil,
                accumulatedPower: ValidatedMeasurement<UnitPower>? = nil,
                enhancedSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                enhancedAltitude: ValidatedMeasurement<UnitLength>? = nil,
                altitude: ValidatedMeasurement<UnitLength>? = nil,
                speed: ValidatedMeasurement<UnitSpeed>? = nil,
                power: ValidatedMeasurement<UnitPower>? = nil,
                gpsAccuracy: ValidatedMeasurement<UnitLength>? = nil,
                verticalSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                calories: ValidatedMeasurement<UnitEnergy>? = nil,
                verticalOscillation: ValidatedMeasurement<UnitLength>? = nil,
                stanceTime: StanceTime,
                heartRate: UInt8? = nil,
                cadence: UInt8? = nil,
                grade: ValidatedMeasurement<UnitPercent>? = nil,
                resistance: ValidatedBinaryInteger<UInt8>? = nil,
                cycleLength: ValidatedMeasurement<UnitLength>? = nil,
                temperature: ValidatedMeasurement<UnitTemperature>? = nil,
                activity: ActivityType? = nil,
                torqueEffectiveness: TorqueEffectiveness,
                pedalSmoothness: PedalSmoothness,
                stroke: Stroke? = nil,
                zone: ValidatedBinaryInteger<UInt8>? = nil,
                ballSpeed: ValidatedMeasurement<UnitSpeed>? = nil,
                deviceIndex: DeviceIndex? = nil) {

        self.timeStamp = timeStamp
        self.position = position
        self.distance = distance
        self.timeFromCourse = timeFromCourse
        self.cycles = cycles
        self.totalCycles = totalCycles
        self.accumulatedPower = accumulatedPower
        self.enhancedSpeed = enhancedSpeed
        self.enhancedAltitude = enhancedAltitude
        self.altitude = altitude
        self.speed = speed
        self.power = power
        self.gpsAccuracy = gpsAccuracy
        self.verticalSpeed = verticalSpeed
        self.calories = calories
        self.verticalOscillation = verticalOscillation
        self.stanceTime = stanceTime

        if let hr = heartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.heartRate.baseType)
            self.heartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }

        if let cadence = cadence {
            let valid = cadence.isValidForBaseType(FitCodingKeys.cadence.baseType)
            self.cadence = ValidatedMeasurement(value: Double(cadence), valid: valid, unit: UnitCadence.genericUnitsPerMinute)
        }
        
        self.grade = grade
        self.resistance = resistance
        self.cycleLength = cycleLength
        self.temperature = temperature
        self.activity = activity
        self.torqueEffectiveness = torqueEffectiveness
        self.pedalSmoothness = pedalSmoothness
        self.stroke = stroke
        self.zone = zone
        self.ballSpeed = ballSpeed
        self.deviceIndex = deviceIndex
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> RecordMessage  {

        var timestamp: FitTime?
        var latitude: ValidatedMeasurement<UnitAngle>?
        var longitude: ValidatedMeasurement<UnitAngle>?
        var distance: ValidatedMeasurement<UnitLength>?
        var timeFromCourse: ValidatedMeasurement<UnitDuration>?
        var cycles: ValidatedBinaryInteger<UInt8>?
        var totalCycles: ValidatedBinaryInteger<UInt32>?
        var compressedAccumulatedPower: ValidatedMeasurement<UnitPower>?
        var compressedAccumulatedPowerValue: ValidatedMeasurement<UnitPower>?
        var longAccumulatedPower: ValidatedMeasurement<UnitPower>?
        var longAccumulatedPowerValue: ValidatedMeasurement<UnitPower>?
        var enhancedSpeed: ValidatedMeasurement<UnitSpeed>?
        var enhancedAltitude: ValidatedMeasurement<UnitLength>?
        var altitude: ValidatedMeasurement<UnitLength>?
        var speed: ValidatedMeasurement<UnitSpeed>?
        var power: ValidatedMeasurement<UnitPower>?
        var gpsAccuracy: ValidatedMeasurement<UnitLength>?
        var verticalSpeed: ValidatedMeasurement<UnitSpeed>?
        var calories: ValidatedMeasurement<UnitEnergy>?
        var verticalOscillation: ValidatedMeasurement<UnitLength>?
        var stancePercent: ValidatedMeasurement<UnitPercent>?
        var stanceTime: ValidatedMeasurement<UnitDuration>?
        var heartRate: UInt8?
        var grade: ValidatedMeasurement<UnitPercent>?
        var cadence: UInt8?
        var resistance: ValidatedBinaryInteger<UInt8>?
        var cycleLength: ValidatedMeasurement<UnitLength>?
        var temperature: ValidatedMeasurement<UnitTemperature>?
        var activity: ActivityType?
        var rightTorqueEff: ValidatedMeasurement<UnitPercent>?
        var leftTorqueEff: ValidatedMeasurement<UnitPercent>?
        var leftPedal: ValidatedMeasurement<UnitPercent>?
        var rightPedal: ValidatedMeasurement<UnitPercent>?
        var combinedPedal: ValidatedMeasurement<UnitPercent>?
        var stroke: Stroke?
        var zone: ValidatedBinaryInteger<UInt8>?
        var ballSpeed: ValidatedMeasurement<UnitSpeed>?

        var deviceIndex: DeviceIndex?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("RecordMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .positionLatitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        latitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        latitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .positionLongitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        longitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {
                        longitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitAngle.garminSemicircle)
                    }

                case .altitude:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        altitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        altitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .heartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        heartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heartRate = UInt8.max
                        }
                    }

                case .cadence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * rpm + 0
                        cadence = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            cadence = value.value
                        } else {
                            cadence = nil
                        }
                    }

                case .distance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        distance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        distance = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .speed:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0
                        let value = value.resolution(1 / 1000)
                        speed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        speed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .power:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1 * watts + 0
                        let value = value.resolution(1)
                        power = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        power = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .compressedSpeedDistance:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .grade:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        grade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        grade = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .resistance:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    resistance = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .timeFromCourse:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        timeFromCourse = ValidatedMeasurement(value: value, valid: false, unit: UnitDuration.seconds)
                    } else {
                        timeFromCourse = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitDuration.seconds)
                    }

                case .cycleLength:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        cycleLength = ValidatedMeasurement(value: value, valid: false, unit: UnitLength.meters)
                    } else {
                        cycleLength = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .temperature:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * C + 0
                        temperature = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitTemperature.celsius)
                    } else {
                        temperature = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitTemperature.celsius)
                    }

                case .speedOneSecondInterval:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .cycles:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    // 1 * cycles + 0
                    cycles = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                     definition: definition,
                                                                     dataStrategy: dataStrategy)

                case .totalCycles:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    // 1 * cycles + 0
                    totalCycles = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                           definition: definition,
                                                                           dataStrategy: dataStrategy)

                case .compressedAccumulatedPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1 * watts + 0
                        let value = value.resolution(1)
                        compressedAccumulatedPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        compressedAccumulatedPowerValue = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .accumulatedPower:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1 * watts + 0
                        let value = value.resolution(1)
                        longAccumulatedPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {
                        longAccumulatedPowerValue = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPower.watts)
                    }

                case .leftRightBalance:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .gpsAccuracy:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        gpsAccuracy = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitLength.meters)
                    } else {
                        gpsAccuracy = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .verticalSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        verticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        verticalSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .calories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * kcal + 0
                        calories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        calories = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .verticalOscillation:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * mm + 0
                        let value = value.resolution(1 / 10)
                        verticalOscillation = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.millimeters)
                    } else {
                        verticalOscillation = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.millimeters)
                    }

                case .stanceTimePercent:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        stancePercent = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        stancePercent = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .stanceTime:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * ms + 0
                        let value = value.resolution(1 / 10)
                        stanceTime = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.millisecond)
                    } else {
                        stanceTime = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitDuration.millisecond)
                    }

                case .activityType:
                    activity = ActivityType.decode(decoder: &localDecoder,
                                                   definition: definition,
                                                   data: fieldData,
                                                   dataStrategy: dataStrategy)

                case .leftTorqueEffectiveness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        leftTorqueEff = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        leftTorqueEff = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .rightTorqueEffectiveness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        rightTorqueEff = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        rightTorqueEff = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .leftPedalSmoothness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        leftPedal = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        leftPedal = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .rightPedalSmoothness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        rightPedal = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        rightPedal = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .combinedPedalSmoothness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        combinedPedal = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        combinedPedal = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .time128Second:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .strokeType:
                    stroke = Stroke.decode(decoder: &localDecoder,
                                           definition: definition,
                                           data: fieldData,
                                           dataStrategy: dataStrategy)

                case .zone:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    zone = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                   definition: definition,
                                                                   dataStrategy: dataStrategy)

                case .ballSpeed:
                    let value = decodeInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m/s + 0,
                        let value = value.resolution(1 / 100)
                        ballSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        ballSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .cadence256:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .fractionalCadence:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalHemoglobinConcentration:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalHemoglobinConcentrationMin:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .totalHemoglobinConcentrationMax:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .saturatedHemoglobinPercent:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .saturatedHemoglobinPercentMin:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .saturatedHemoglobinPercentMax:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .deviceIndex:
                    deviceIndex = DeviceIndex.decode(decoder: &localDecoder,
                                                     definition: definition,
                                                     data: fieldData,
                                                     dataStrategy: dataStrategy)

                case .enhancedSpeed:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  1000 * m/s + 0
                        let value = value.resolution(1 / 1000)
                        enhancedSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        enhancedSpeed = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .enhancedAltitude:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        enhancedAltitude = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                }
            }
        }

        /// Determine which Accumulated Power to use
        var accumulatedPower: ValidatedMeasurement<UnitPower>?

        /// Try to use the Compressed Firt
        if let compressed = compressedAccumulatedPower {
            accumulatedPower = compressed
        } else {
            /// If the compressed value is there and strategy in use invalid
            if let value = compressedAccumulatedPowerValue {
                if dataStrategy == .useInvalid {
                    accumulatedPower = value
                }
            }
        }

        /// Prefer the Long Values
        if let power = longAccumulatedPower {
            accumulatedPower = power
        } else {
            /// If the long value is there and strategy in use invalid
            if let value = longAccumulatedPowerValue {
                if dataStrategy == .useInvalid {
                    accumulatedPower = value
                }
            }
        }

        /// setup Position
        let position = Position(latitude: latitude, longitude: longitude)

        /// TorqueEffectiveness
        let torqueEff = TorqueEffectiveness(left: leftTorqueEff, right: rightTorqueEff)

        /// PedalSmoothness
        let pedal = PedalSmoothness(right: rightPedal, left: leftPedal, combined: combinedPedal)

        /// Stance Time
        let stance = StanceTime(percent: stancePercent, time: stanceTime)

        return RecordMessage(timeStamp: timestamp,
                             position: position,
                             distance: distance,
                             timeFromCourse: timeFromCourse,
                             cycles: cycles,
                             totalCycles: totalCycles,
                             accumulatedPower: accumulatedPower,
                             enhancedSpeed: enhancedSpeed,
                             enhancedAltitude: enhancedAltitude,
                             altitude: altitude,
                             speed: speed,
                             power: power,
                             gpsAccuracy: gpsAccuracy,
                             verticalSpeed: verticalSpeed,
                             calories: calories,
                             verticalOscillation: verticalOscillation,
                             stanceTime: stance,
                             heartRate: heartRate,
                             cadence: cadence,
                             grade: grade,
                             resistance: resistance,
                             cycleLength: cycleLength,
                             temperature: temperature,
                             activity: activity,
                             torqueEffectiveness: torqueEff,
                             pedalSmoothness: pedal,
                             stroke: stroke,
                             zone: zone,
                             ballSpeed: ballSpeed,
                             deviceIndex: deviceIndex)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .positionLatitude:
                if let value = position.encodeLatitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .positionLongitude:
                if let value = position.encodeLongitude() {
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .altitude:
                if var altitude = altitude {
                    // 5 * m + 500
                    altitude = altitude.converted(to: UnitLength.meters)
                    let value = altitude.value.resolutionUInt16(5) + 500

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .heartRate:
                if let heartRate = heartRate {
                    // 1 * bpm + 0
                    let value = heartRate.value.resolutionUInt8(1)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .cadence:
                if let cadence = cadence {
                    // 1 * rpm + 0
                    let value = cadence.value.resolutionUInt8(1)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .distance:
                if var distance = distance {
                    // 100 * m + 0
                    distance = distance.converted(to: UnitLength.meters)
                    let value = distance.value.resolutionUInt32(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .speed:
                if var speed = speed {
                    // 1000 * m/s + 0
                    speed = speed.converted(to: UnitSpeed.metersPerSecond)
                    let value = speed.value.resolutionUInt16(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .power:
                if let power = power {
                    let value = encodePowerUInt16(power)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .compressedSpeedDistance:
                break

            case .grade:
                if let grade = grade {
                    let value = encodeInt16Percent(grade)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .resistance:
                if let resistance = resistance {
                    msgData.append(resistance.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .timeFromCourse:
                if var timeFromCourse = timeFromCourse {
                    // 1000 * s + 0
                    timeFromCourse = timeFromCourse.converted(to: UnitDuration.seconds)
                    let value = timeFromCourse.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .cycleLength:
                if var cycleLength = cycleLength {
                    // 100 * m + 0
                    cycleLength = cycleLength.converted(to: UnitLength.meters)
                    let value = cycleLength.value.resolutionUInt8(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .temperature:
                if var temperature = temperature {
                    // 1 * C + 0
                    temperature = temperature.converted(to: UnitTemperature.celsius)
                    let value = temperature.value.resolutionInt8(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .speedOneSecondInterval:
                break

            case .cycles:
                if let cycles = cycles {
                    // 1 * cycles + 0
                    msgData.append(cycles.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .totalCycles:
                if let totalCycles = totalCycles {
                    // 1 * cycles + 0
                    msgData.append(Data(from: totalCycles.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .compressedAccumulatedPower:
                break // not supported
//                if var accumulatedPower = accumulatedPower {
//                    // 1 * watts + 0
//                    accumulatedPower = accumulatedPower.converted(to: UnitPower.watts)
//                    let value = accumulatedPower.value.resolutionUInt16(1)
//
//                    /// If we can create a compressed Accumulated Power
//                    if value != UInt16.max {
//                        msgData.append(Data(from: value.littleEndian))
//
//                        fileDefs.append(key.fieldDefinition())
//                    }
//                }

            case .accumulatedPower:
                if var accumulatedPower = accumulatedPower {
                    // 1 * watts + 0
                    accumulatedPower = accumulatedPower.converted(to: UnitPower.watts)
                    let value = accumulatedPower.value.resolutionUInt32(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .leftRightBalance:
                break

            case .gpsAccuracy:
                if var gpsAccuracy = gpsAccuracy {
                    // 1 * m + 0
                    gpsAccuracy = gpsAccuracy.converted(to: UnitLength.meters)
                    let value = gpsAccuracy.value.resolutionUInt8(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .verticalSpeed:
                if let verticalSpeed = verticalSpeed {
                    let value = encodeVerticalSpeed(verticalSpeed)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .calories:
                if var calories = calories {
                    // 1 * kcal + 0
                    calories = calories.converted(to: UnitEnergy.kilocalories)
                    let value = calories.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .verticalOscillation:
                if var verticalOscillation = verticalOscillation {
                    // 10 * mm + 0
                    verticalOscillation = verticalOscillation.converted(to: UnitLength.millimeters)
                    let value = verticalOscillation.value.resolutionUInt16(10)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .stanceTimePercent:
                if let stancePercent = stanceTime.percent {
                    // 100 * % + 0
                    let value = encodeUInt16Percent(stancePercent)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .stanceTime:
                if var stance = stanceTime.time {
                    // 10 * ms + 0
                    stance = stance.converted(to: UnitDuration.millisecond)
                    let value = stance.value.resolutionUInt16(10)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .activityType:
                if let activityType = activity {
                    msgData.append(activityType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .leftTorqueEffectiveness:
                if let left = torqueEffectiveness.left {
                    // 2 * percent + 0
                    let value = left.value.resolutionUInt8(2)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .rightTorqueEffectiveness:
                if let right = torqueEffectiveness.right {
                    // 2 * percent + 0
                    let value = right.value.resolutionUInt8(2)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .leftPedalSmoothness:
                if let left = pedalSmoothness.left {
                    // 2 * percent + 0
                    let value = left.value.resolutionUInt8(2)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .rightPedalSmoothness:
                if let right = pedalSmoothness.right {
                    // 2 * percent + 0
                    let value = right.value.resolutionUInt8(2)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .combinedPedalSmoothness:
                if let combined = pedalSmoothness.combined {
                    // 2 * percent + 0
                    let value = combined.value.resolutionUInt8(2)
                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .time128Second:
                break

            case .strokeType:
                if let strokeType = stroke {
                    msgData.append(strokeType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .zone:
                if let zone = zone {
                    msgData.append(zone.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .ballSpeed:
                if var ballSpeed = ballSpeed {
                    // 100 * m/s + 0
                    ballSpeed = ballSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = ballSpeed.value.resolutionInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .cadence256:
                break
            case .fractionalCadence:
                break
            case .totalHemoglobinConcentration:
                break
            case .totalHemoglobinConcentrationMin:
                break
            case .totalHemoglobinConcentrationMax:
                break
            case .saturatedHemoglobinPercent:
                break
            case .saturatedHemoglobinPercentMin:
                break
            case .saturatedHemoglobinPercentMax:
                break

            case .deviceIndex:
                if let deviceIndex = deviceIndex {
                    msgData.append(deviceIndex.index)

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedSpeed:
                if var enhancedSpeed = enhancedSpeed {
                    // 1000 * m/s + 0
                    enhancedSpeed = enhancedSpeed.converted(to: UnitSpeed.metersPerSecond)
                    let value = enhancedSpeed.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .enhancedAltitude:
                if let enhancedAltitude = enhancedAltitude {
                    let valData = encodeEnhancedAltitude(enhancedAltitude)
                    msgData.append(valData)

                    fileDefs.append(key.fieldDefinition())
                }

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: RecordMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "RecordMessage contains no Properties Available to Encode"))
        }
    }

}

private extension RecordMessage {

    func encodePowerUInt16(_ power: ValidatedMeasurement<UnitPower>) -> Data {
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
