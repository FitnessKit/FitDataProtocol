//
//  RecordMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
//

import Foundation
import DataDecoder
import FitnessUnits

/// FIT Record Message
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class RecordMessage: FitMessage, FitMessageKeys {

    public override func globalMessageNumber() -> UInt16 {
        return 20
    }

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

    public typealias FitCodingKeys = MessageKeys

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

    /// Zone
    private(set) public var zone: UInt8?

    /// Device Index
    private(set) public var deviceIndex: UInt8?

    internal override init() {}

    public init(timeStamp: FitTime?, distance: Measurement<UnitLength>?, timeFromCourse: Measurement<UnitDuration>?, totalCycles: UInt32?, accumulatedPower: Measurement<UnitPower>?, enhancedSpeed: Measurement<UnitSpeed>?, enhancedAltitude: Measurement<UnitLength>?, altitude: Measurement<UnitLength>?, speed: Measurement<UnitSpeed>?, power: Measurement<UnitPower>?, verticalSpeed: Measurement<UnitSpeed>?, calories: Measurement<UnitEnergy>?, heartRate: UInt8?, cadence: UInt8?, resistance: UInt8?, temperature: Measurement<UnitTemperature>?, activity: ActivityType?, zone: UInt8?, deviceIndex: UInt8?) {

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
        self.zone = zone
        self.deviceIndex = deviceIndex
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> RecordMessage  {

        var timestamp: FitTime?
        var distance: Measurement<UnitLength>?
        var timeFromCourse: Measurement<UnitDuration>?
        var totalCycles: UInt32?
        var accumulatedPower: Measurement<UnitPower>?
        var enhancedSpeed: Measurement<UnitSpeed>?
        var enhancedAltitude: Measurement<UnitLength>?
        var altitude: Measurement<UnitLength>?
        var speed: Measurement<UnitSpeed>?
        var power: Measurement<UnitPower>?
        var verticalSpeed: Measurement<UnitSpeed>?
        var calories: Measurement<UnitEnergy>?
        var heartRate: UInt8?
        var cadence: UInt8?
        var resistance: UInt8?
        var temperature: Measurement<UnitTemperature>?
        var activity: ActivityType?
        var zone: UInt8?
        var deviceIndex: UInt8?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

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
                        //print("Altitude: \(String(describing: altitude))")
                    }

                case .heartRate:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        heartRate = value
                    }

                case .cadence:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * rpm + 0
                        cadence = value
                    }

                case .distance:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = Double(value) / 100
                        distance = Measurement(value: value, unit: UnitLength.meters)
                    }

                case .speed:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0
                        let value = Double(value) / 1000
                        speed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                        //print("Speed: \(String(describing: speed))")
                    }

                case .power:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = Double(value)
                        power = Measurement(value: value, unit: UnitPower.watts)
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
                    }

                case .timeFromCourse:
                    let value = arch == .little ? localDecoder.decodeInt32().littleEndian : localDecoder.decodeInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0
                        let value = Double(value) / 1000
                        timeFromCourse = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .cycleLength:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .temperature:
                    let value = localDecoder.decodeInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * C + 0
                        temperature = Measurement(value: Double(value), unit: UnitTemperature.celsius)
                    }

                case .speedOneSecondInterval:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .cycles:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * cycles + 0
                        totalCycles = value
                    }

                case .totalCycles:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .compressedAccumulatedPower:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .accumulatedPower:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1 * watts + 0
                        let value = Double(value)
                        accumulatedPower = Measurement(value: value, unit: UnitPower.watts)
                    }

                case .leftRightBalance:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .gpsAccuracy:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .verticalSpeed:
                    let value = arch == .little ? localDecoder.decodeInt16().littleEndian : localDecoder.decodeInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0,
                        let value = Double(value) / 1000
                        verticalSpeed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                        //print("Vertical Speed: \(String(describing: verticalSpeed))")
                    }

                case .calories:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * kcal + 0
                        calories = Measurement(value: Double(value), unit: UnitEnergy.kilocalories)
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
                    activity = ActivityType(rawValue: value)

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
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .zone:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) == definition.baseType.invalid {
                        zone = value
                    }

                case .ballSpeed:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

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
                    if UInt64(value) == definition.baseType.invalid {
                        deviceIndex = value
                    }

                case .enhancedSpeed:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  1000 * m/s + 0
                        let value = Double(value) / 1000
                        enhancedSpeed = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                        //print("Enhanced Speed: \(String(describing: enhancedSpeed))")
                    }

                case .enhancedAltitude:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  5 * m + 500
                        let value = Double(value) / 5 - 500
                        enhancedAltitude = Measurement(value: value, unit: UnitLength.meters)
                        //print("Enhanced Altitude: \(String(describing: enhancedAltitude))")
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

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
                             verticalSpeed: verticalSpeed,
                             calories: calories,
                             heartRate: heartRate,
                             cadence: cadence,
                             resistance: resistance,
                             temperature: temperature,
                             activity: activity,
                             zone: zone,
                             deviceIndex: deviceIndex)
    }
}
