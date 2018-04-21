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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class RecordMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 20
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Distance
    private(set) public var distance: Measurement<UnitLength>?

    /// Time From Course
    private(set) public var timeFromCourse: Measurement<UnitDuration>?

    /// Total Cycles
    private(set) public var totalCycles: UInt32?

    /// Accumulated Power
    private(set) public var accumulatedPower: Measurement<UnitPower>?

    /// Enhanced Speed
    private(set) public var enhancedSpeed: Measurement<UnitSpeed>?

    /// Enhanced Altitude
    private(set) public var enhancedAltitude: Measurement<UnitLength>?

    /// Altitude
    private(set) public var altitude: Measurement<UnitLength>?

    /// Speed
    private(set) public var speed: Measurement<UnitSpeed>?

    /// Power
    private(set) public var power: Measurement<UnitPower>?

    /// GPS Accuracy
    private(set) public var gpsAccuracy: Measurement<UnitLength>?

    /// Vertical Speed
    private(set) public var verticalSpeed: Measurement<UnitSpeed>?

    /// Calories
    private(set) public var calories: Measurement<UnitEnergy>?

    /// Heart Rate
    private(set) public var heartRate: Measurement<UnitCadence>?

    /// Cadence
    private(set) public var cadence: Measurement<UnitCadence>?

    /// Resistance
    ///
    /// Relative. 0 is none  254 is Max
    private(set) public var resistance: UInt8?

    /// Temperature
    private(set) public var temperature: Measurement<UnitTemperature>?

    /// FIT Activity Type
    private(set) public var activity: ActivityType?

    /// Stroke Type
    private(set) public var stroke: Stroke?

    /// Zone
    private(set) public var zone: UInt8?

    /// Ball Speed
    private(set) public var ballSpeed: Measurement<UnitSpeed>?

    /// Device Index
    private(set) public var deviceIndex: DeviceIndex?

    public required init() {}

    public init(timeStamp: FitTime?, distance: Measurement<UnitLength>?, timeFromCourse: Measurement<UnitDuration>?, totalCycles: UInt32?, accumulatedPower: Measurement<UnitPower>?, enhancedSpeed: Measurement<UnitSpeed>?, enhancedAltitude: Measurement<UnitLength>?, altitude: Measurement<UnitLength>?, speed: Measurement<UnitSpeed>?, power: Measurement<UnitPower>?, gpsAccuracy: Measurement<UnitLength>?, verticalSpeed: Measurement<UnitSpeed>?, calories: Measurement<UnitEnergy>?, heartRate: UInt8?, cadence: UInt8?, resistance: UInt8?, temperature: Measurement<UnitTemperature>?, activity: ActivityType?, stroke: Stroke?, zone: UInt8?, ballSpeed: Measurement<UnitSpeed>?, deviceIndex: DeviceIndex?) {

        self.timeStamp = timeStamp
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
            self.heartRate = Measurement(value: Double(hr), unit: UnitCadence.beatsPerMinute)
        } else {
            self.heartRate = nil
        }

        if let cadence = cadence {
            self.cadence = Measurement(value: Double(cadence), unit: UnitCadence.revolutionsPerMinute)
        } else {
            self.cadence = nil
        }

        self.resistance = resistance
        self.temperature = temperature
        self.activity = activity
        self.stroke = stroke
        self.zone = zone
        self.ballSpeed = ballSpeed
        self.deviceIndex = deviceIndex
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> RecordMessage  {

        var timestamp: FitTime?
        var distance: Measurement<UnitLength>?
        var timeFromCourse: Measurement<UnitDuration>?
        var totalCycles: UInt32?
        var compressedAccumulatedPower: Measurement<UnitPower>?
        var compressedAccumulatedPowerValue: Double?
        var longAccumulatedPower: Measurement<UnitPower>?
        var longAccumulatedPowerValue: Double?
        var enhancedSpeed: Measurement<UnitSpeed>?
        var enhancedAltitude: Measurement<UnitLength>?
        var altitude: Measurement<UnitLength>?
        var speed: Measurement<UnitSpeed>?
        var power: Measurement<UnitPower>?
        var gpsAccuracy: Measurement<UnitLength>?
        var verticalSpeed: Measurement<UnitSpeed>?
        var calories: Measurement<UnitEnergy>?
        var heartRate: UInt8?
        var cadence: UInt8?
        var resistance: UInt8?
        var temperature: Measurement<UnitTemperature>?
        var activity: ActivityType?
        var stroke: Stroke?
        var zone: UInt8?
        var ballSpeed: Measurement<UnitSpeed>?

        var deviceIndex: DeviceIndex?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                //print("RecordMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .positionLatitude:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .positionLongitude:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .altitude:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        altitude = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            altitude = Measurement(value: Double(definition.baseType.invalid), unit: UnitLength.meters)
                        }
                    }

                case .heartRate:
                    let value = localDecoder.decodeUInt8()
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
                    let value = localDecoder.decodeUInt8()
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
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = Double(value) / 100
                        distance = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            distance = Measurement(value: Double(definition.baseType.invalid), unit: UnitLength.meters)
                        }
                    }

                case .speed:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0
                        let value = Double(value) / 1000
                        speed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            speed = Measurement(value: Double(definition.baseType.invalid), unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .power:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = Double(value)
                        power = Measurement(value: value, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            power = Measurement(value: Double(definition.baseType.invalid), unit: UnitPower.watts)
                        }
                    }

                case .compressedSpeedDistance:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .grade:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .resistance:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        resistance = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            resistance = UInt8(definition.baseType.invalid)
                        }
                    }

                case .timeFromCourse:
                    let value = arch == .little ? localDecoder.decodeInt32().littleEndian : localDecoder.decodeInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0
                        let value = Double(value) / 1000
                        timeFromCourse = Measurement(value: value, unit: UnitDuration.seconds)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            timeFromCourse = Measurement(value: Double(definition.baseType.invalid), unit: UnitDuration.seconds)
                        }
                    }

                case .cycleLength:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .temperature:
                    let value = localDecoder.decodeInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * C + 0
                        temperature = Measurement(value: Double(value), unit: UnitTemperature.celsius)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            temperature = Measurement(value: Double(definition.baseType.invalid), unit: UnitTemperature.celsius)
                        }
                    }

                case .speedOneSecondInterval:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .cycles:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * cycles + 0
                        totalCycles = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            totalCycles = UInt32(definition.baseType.invalid)
                        }
                    }

                case .totalCycles:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .compressedAccumulatedPower:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = Double(value)
                        compressedAccumulatedPower = Measurement(value: value, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            compressedAccumulatedPowerValue = Double(value)
                        }
                    }

                case .accumulatedPower:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = Double(value)
                        longAccumulatedPower = Measurement(value: value, unit: UnitPower.watts)
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
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .gpsAccuracy:
                    let value = localDecoder.decodeInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * m + 0
                        gpsAccuracy = Measurement(value: Double(value), unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            gpsAccuracy = Measurement(value: Double(definition.baseType.invalid), unit: UnitLength.meters)
                        }
                    }

                case .verticalSpeed:
                    let value = arch == .little ? localDecoder.decodeInt16().littleEndian : localDecoder.decodeInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = Double(value) / 1000
                        verticalSpeed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            verticalSpeed = Measurement(value: Double(definition.baseType.invalid), unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .calories:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * kcal + 0
                        calories = Measurement(value: Double(value), unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            calories = Measurement(value: Double(definition.baseType.invalid), unit: UnitEnergy.kilocalories)
                        }
                    }

                case .verticalOscillation:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .stanceTimePercent:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .stanceTime:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .activityType:
                    let value = localDecoder.decodeUInt8()
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
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .rightTorqueEffectiveness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .leftPedalSmoothness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .rightPedalSmoothness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .combinedPedalSmoothness:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .time128Second:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .strokeType:
                    let value = localDecoder.decodeUInt8()
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
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        zone = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            zone = UInt8(definition.baseType.invalid)
                        }
                    }

                case .ballSpeed:
                    let value = arch == .little ? localDecoder.decodeInt16().littleEndian : localDecoder.decodeInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  100 * m/s + 0,
                        let value = Double(value) / 100
                        ballSpeed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            ballSpeed = Measurement(value: Double(definition.baseType.invalid), unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .cadence256:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .fractionalCadence:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .totalHemoglobinConcentration:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .totalHemoglobinConcentrationMin:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .totalHemoglobinConcentrationMax:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .saturatedHemoglobinPercent:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .saturatedHemoglobinPercentMin:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .saturatedHemoglobinPercentMax:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .deviceIndex:
                    let value = localDecoder.decodeUInt8()
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
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0
                        let value = Double(value) / 1000
                        enhancedSpeed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedSpeed = Measurement(value: Double(definition.baseType.invalid), unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .enhancedAltitude:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedAltitude = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            enhancedAltitude = Measurement(value: Double(definition.baseType.invalid), unit: UnitLength.meters)
                        }
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

                }
            }
        }

        /// Determine which Accumulated Power to use
        var accumulatedPower: Measurement<UnitPower>?

        /// Try to use the Compressed Firt
        if let compressed = compressedAccumulatedPower {
            accumulatedPower = compressed
        } else {
            /// If the compressed value is there and strategy in use invalid
            if let value = compressedAccumulatedPowerValue {
                if dataStrategy == .useInvalid {
                    accumulatedPower = Measurement(value: value, unit: UnitPower.watts)
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
                    accumulatedPower = Measurement(value: value, unit: UnitPower.watts)
                }
            }
        }

        return RecordMessage(timeStamp: timestamp,
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
                             resistance: resistance,
                             temperature: temperature,
                             activity: activity,
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
