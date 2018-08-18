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
import FitnessUnits

/// FIT Record Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class RecordMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 20
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Position
    private(set) public var position: Position

    /// Distance
    private(set) public var distance: ValidatedMeasurement<UnitLength>?

    /// Time From Course
    private(set) public var timeFromCourse: ValidatedMeasurement<UnitDuration>?

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

    /// Temperature
    private(set) public var temperature: ValidatedMeasurement<UnitTemperature>?

    /// FIT Activity Type
    private(set) public var activity: ActivityType?

    /// Torque Effectiveness
    private(set) public var torqueEffectiveness: TorqueEffectiveness

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
    }

    public init(timeStamp: FitTime?,
                position: Position,
                distance: ValidatedMeasurement<UnitLength>?,
                timeFromCourse: ValidatedMeasurement<UnitDuration>?,
                totalCycles: ValidatedBinaryInteger<UInt32>?,
                accumulatedPower: ValidatedMeasurement<UnitPower>?,
                enhancedSpeed: ValidatedMeasurement<UnitSpeed>?,
                enhancedAltitude: ValidatedMeasurement<UnitLength>?,
                altitude: ValidatedMeasurement<UnitLength>?,
                speed: ValidatedMeasurement<UnitSpeed>?,
                power: ValidatedMeasurement<UnitPower>?,
                gpsAccuracy: ValidatedMeasurement<UnitLength>?,
                verticalSpeed: ValidatedMeasurement<UnitSpeed>?,
                calories: ValidatedMeasurement<UnitEnergy>?,
                heartRate: UInt8?,
                cadence: UInt8?,
                grade: ValidatedMeasurement<UnitPercent>?,
                resistance: ValidatedBinaryInteger<UInt8>?,
                temperature: ValidatedMeasurement<UnitTemperature>?,
                activity: ActivityType?,
                torqueEffectiveness: TorqueEffectiveness,
                stroke: Stroke?,
                zone: ValidatedBinaryInteger<UInt8>?,
                ballSpeed: ValidatedMeasurement<UnitSpeed>?,
                deviceIndex: DeviceIndex?) {

        self.timeStamp = timeStamp
        self.position = position
        self.distance = distance
        self.timeFromCourse = timeFromCourse
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

        if let hr = heartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.heartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.heartRate = nil
        }

        if let cadence = cadence {

            let valid = !(Int64(cadence) == BaseType.uint8.invalid)
            self.cadence = ValidatedMeasurement(value: Double(cadence), valid: valid, unit: UnitCadence.revolutionsPerMinute)

        } else {
            self.cadence = nil
        }

        self.grade = grade
        self.resistance = resistance
        self.temperature = temperature
        self.activity = activity
        self.torqueEffectiveness = torqueEffectiveness
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
        var totalCycles: ValidatedBinaryInteger<UInt32>?
        var compressedAccumulatedPower: ValidatedMeasurement<UnitPower>?
        var compressedAccumulatedPowerValue: Double?
        var longAccumulatedPower: ValidatedMeasurement<UnitPower>?
        var longAccumulatedPowerValue: Double?
        var enhancedSpeed: ValidatedMeasurement<UnitSpeed>?
        var enhancedAltitude: ValidatedMeasurement<UnitLength>?
        var altitude: ValidatedMeasurement<UnitLength>?
        var speed: ValidatedMeasurement<UnitSpeed>?
        var power: ValidatedMeasurement<UnitPower>?
        var gpsAccuracy: ValidatedMeasurement<UnitLength>?
        var verticalSpeed: ValidatedMeasurement<UnitSpeed>?
        var calories: ValidatedMeasurement<UnitEnergy>?
        var heartRate: UInt8?
        var grade: ValidatedMeasurement<UnitPercent>?
        var cadence: UInt8?
        var resistance: ValidatedBinaryInteger<UInt8>?
        var temperature: ValidatedMeasurement<UnitTemperature>?
        var activity: ActivityType?
        var rightTorqueEff: ValidatedMeasurement<UnitPercent>?
        var leftTorqueEff: ValidatedMeasurement<UnitPercent>?

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
                    let value = arch == .little ? localDecoder.decodeInt32(fieldData.fieldData).littleEndian : localDecoder.decodeInt32(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        latitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            latitude = ValidatedMeasurement(value: Double(value), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .positionLongitude:
                    let value = arch == .little ? localDecoder.decodeInt32(fieldData.fieldData).littleEndian : localDecoder.decodeInt32(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        longitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            longitude = ValidatedMeasurement(value: Double(value), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .altitude:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        altitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            altitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .heartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        heartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .cadence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * rpm + 0
                        cadence = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            cadence = UInt8(definition.baseType.invalid)
                        }
                    }

                case .distance:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        distance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            distance = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .speed:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0
                        let value = value.resolution(1 / 1000)
                        speed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            speed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .power:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = value.resolution(1)
                        power = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            power = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPower.watts)
                        }
                    }

                case .compressedSpeedDistance:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .grade:
                    let value = arch == .little ? localDecoder.decodeInt16(fieldData.fieldData).littleEndian : localDecoder.decodeInt16(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * % + 0
                        let value = value.resolution(1 / 100)
                        grade = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            grade = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .resistance:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        resistance = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            resistance = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .timeFromCourse:
                    let value = arch == .little ? localDecoder.decodeInt32(fieldData.fieldData).littleEndian : localDecoder.decodeInt32(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        timeFromCourse = ValidatedMeasurement(value: value, valid: false, unit: UnitDuration.seconds)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            timeFromCourse = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitDuration.seconds)
                        }
                    }

                case .cycleLength:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .temperature:
                    let value = localDecoder.decodeInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * C + 0
                        temperature = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitTemperature.celsius)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            temperature = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitTemperature.celsius)
                        }
                    }

                case .speedOneSecondInterval:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .cycles:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
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

                case .totalCycles:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .compressedAccumulatedPower:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = value.resolution(1)
                        compressedAccumulatedPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            compressedAccumulatedPowerValue = Double(value)
                        }
                    }

                case .accumulatedPower:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = value.resolution(1)
                        longAccumulatedPower = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            longAccumulatedPowerValue = Double(value)
                        }
                    }

                case .leftRightBalance:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

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

                case .verticalSpeed:
                    let value = arch == .little ? localDecoder.decodeInt16(fieldData.fieldData).littleEndian : localDecoder.decodeInt16(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = value.resolution(1 / 1000)
                        verticalSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            verticalSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .calories:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * kcal + 0
                        calories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            calories = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .verticalOscillation:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .stanceTimePercent:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .stanceTime:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .activityType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        activity = ActivityType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            activity = ActivityType.invalid
                        }
                    }

                case .leftTorqueEffectiveness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        leftTorqueEff = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            leftTorqueEff = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .rightTorqueEffectiveness:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 2 * percent + 0
                        let value = value.resolution(1 / 2)
                        rightTorqueEff = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            rightTorqueEff = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .leftPedalSmoothness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .rightPedalSmoothness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .combinedPedalSmoothness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .time128Second:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .strokeType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        stroke = Stroke(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            stroke = Stroke.invalid
                        }
                    }

                case .zone:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        zone = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            zone = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .ballSpeed:
                    let value = arch == .little ? localDecoder.decodeInt16(fieldData.fieldData).littleEndian : localDecoder.decodeInt16(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        //  100 * m/s + 0,
                        let value = value.resolution(1 / 100)
                        ballSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            ballSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
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
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        deviceIndex = DeviceIndex(index: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            deviceIndex = DeviceIndex(index: UInt8(definition.baseType.invalid))
                        }
                    }

                case .enhancedSpeed:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0
                        let value = value.resolution(1 / 1000)
                        enhancedSpeed = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedSpeed = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .enhancedAltitude:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedAltitude = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedAltitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

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
                    accumulatedPower = ValidatedMeasurement(value: value, valid: false, unit: UnitPower.watts)
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
                    accumulatedPower = ValidatedMeasurement(value: value, valid: false, unit: UnitPower.watts)
                }
            }
        }

        /// setup Position
        let position = Position(latitude: latitude, longitude: longitude)

        /// TorqueEffectiveness
        let torqueEff = TorqueEffectiveness(left: leftTorqueEff, right: rightTorqueEff)

        return RecordMessage(timeStamp: timestamp,
                             position: position,
                             distance: distance,
                             timeFromCourse: timeFromCourse,
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
                             heartRate: heartRate,
                             cadence: cadence,
                             grade: grade,
                             resistance: resistance,
                             temperature: temperature,
                             activity: activity,
                             torqueEffectiveness: torqueEff,
                             stroke: stroke,
                             zone: zone,
                             ballSpeed: ballSpeed,
                             deviceIndex: deviceIndex)
    }
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension RecordMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case positionLatitude                   = 0
        case positionLongitude                  = 1
        case altitude                           = 2
        case heartRate                          = 3
        case cadence                            = 4
        case distance                           = 5
        case speed                              = 6
        case power                              = 7
        case compressedSpeedDistance            = 8
        case grade                              = 9
        case resistance                         = 10
        case timeFromCourse                     = 11
        case cycleLength                        = 12
        case temperature                        = 13
        case speedOneSecondInterval             = 17
        case cycles                             = 18
        case totalCycles                        = 19
        case compressedAccumulatedPower         = 28
        case accumulatedPower                   = 29
        case leftRightBalance                   = 30
        case gpsAccuracy                        = 31
        case verticalSpeed                      = 32
        case calories                           = 33
        case verticalOscillation                = 39
        case stanceTimePercent                  = 40
        case stanceTime                         = 41
        case activityType                       = 42
        case leftTorqueEffectiveness            = 43
        case rightTorqueEffectiveness           = 44
        case leftPedalSmoothness                = 45
        case rightPedalSmoothness               = 46
        case combinedPedalSmoothness            = 47
        case time128Second                      = 48
        case strokeType                         = 49
        case zone                               = 50
        case ballSpeed                          = 51
        case cadence256                         = 52
        case fractionalCadence                  = 53
        case totalHemoglobinConcentration       = 54
        case totalHemoglobinConcentrationMin    = 55
        case totalHemoglobinConcentrationMax    = 56
        case saturatedHemoglobinPercent         = 57
        case saturatedHemoglobinPercentMin      = 58
        case saturatedHemoglobinPercentMax      = 59
        case deviceIndex                        = 62
        case enhancedSpeed                      = 73
        case enhancedAltitude                   = 78

        case timestamp                          = 253
    }
}
