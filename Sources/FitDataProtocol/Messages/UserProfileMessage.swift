//
//  UserProfileMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
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

/// FIT File User Profile Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class UserProfileMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 3
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Friendly Name
    private(set) public var friendlyName: String?

    /// Weight
    private(set) public var weight: ValidatedMeasurement<UnitMass>?

    /// Speed Setting
    private(set) public var speedSetting: PositionDisplayType?

    /// Distance Setting
    private(set) public var distanceSetting: PositionDisplayType?

    /// Power Setting
    private(set) public var powerSetting: PowerDisplayType?

    /// Position Setting
    private(set) public var positionSetting: PositionDisplayType?

    /// Temperature Setting
    private(set) public var temperatureSetting: MeasurementDisplayType?

    /// Local ID
    private(set) public var localID: ValidatedBinaryInteger<UInt16>?

    /// Height Setting
    private(set) public var heightSetting: MeasurementDisplayType?

    /// Running Step Length
    private(set) public var runningStepLength: ValidatedMeasurement<UnitLength>?

    /// Walking Step Length
    private(set) public var walkingStepLength: ValidatedMeasurement<UnitLength>?

    /// Gender
    private(set) public var gender: Gender?

    /// Age in Years
    private(set) public var age: ValidatedMeasurement<UnitDuration>?

    /// Height
    private(set) public var height: ValidatedMeasurement<UnitLength>?

    /// Language
    private(set) public var language: Language?

    /// Resting Heart Rate
    private(set) public var restingHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Max Running Heart Rate
    private(set) public var maxRunningHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Max Biking Heart Rate
    private(set) public var maxBikingHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Max Heart Rate
    private(set) public var maxHeartRate: ValidatedMeasurement<UnitCadence>?

    public required init() {}

    public init(timeStamp: FitTime?,
                messageIndex: MessageIndex?,
                friendlyName: String?,
                weight: ValidatedMeasurement<UnitMass>?,
                speedSetting: PositionDisplayType?,
                distanceSetting: PositionDisplayType?,
                powerSetting: PowerDisplayType?,
                positionSetting: PositionDisplayType?,
                temperatureSetting: MeasurementDisplayType?,
                localID: ValidatedBinaryInteger<UInt16>?,
                heightSetting: MeasurementDisplayType?,
                runningStepLength: ValidatedMeasurement<UnitLength>?,
                walkingStepLength: ValidatedMeasurement<UnitLength>?,
                gender: Gender?,
                age: ValidatedMeasurement<UnitDuration>?,
                height: ValidatedMeasurement<UnitLength>?,
                language: Language?,
                restingHeartRate: UInt8?,
                maxRunningHeartRate: UInt8?,
                maxBikingHeartRate: UInt8?,
                maxHeartRate: UInt8? ) {

        self.timeStamp = timeStamp
        self.messageIndex = messageIndex

        self.friendlyName = friendlyName
        self.weight = weight
        self.speedSetting = speedSetting
        self.distanceSetting = distanceSetting
        self.powerSetting = powerSetting
        self.positionSetting = positionSetting
        self.temperatureSetting = temperatureSetting
        self.localID = localID
        self.heightSetting = heightSetting
        self.runningStepLength = runningStepLength
        self.walkingStepLength = walkingStepLength
        self.gender = gender
        self.age = age
        self.height = height
        self.language = language

        if let hr = restingHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.restingHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.restingHeartRate = nil
        }

        if let hr = maxRunningHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.maxRunningHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.maxRunningHeartRate = nil
        }

        if let hr = maxBikingHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.maxBikingHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.maxBikingHeartRate = nil
        }

        if let hr = maxHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.maxHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.maxHeartRate = nil
        }

    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> UserProfileMessage  {

        var timestamp: FitTime?
        var messageIndex: MessageIndex?
        var friendlyName: String?
        var weight: ValidatedMeasurement<UnitMass>?
        var speedSetting: PositionDisplayType?
        var distanceSetting: PositionDisplayType?
        var powerSetting: PowerDisplayType?
        var positionSetting: PositionDisplayType?
        var temperatureSetting: MeasurementDisplayType?
        var localID: ValidatedBinaryInteger<UInt16>?
        var heightSetting: MeasurementDisplayType?
        var runningStepLength: ValidatedMeasurement<UnitLength>?
        var walkingStepLength: ValidatedMeasurement<UnitLength>?
        var gender: Gender?
        var age: ValidatedMeasurement<UnitDuration>?
        var height: ValidatedMeasurement<UnitLength>?
        var language: Language?
        var restingHeartRate: UInt8?
        var maxRunningHeartRate: UInt8?
        var maxBikingHeartRate: UInt8?
        var maxHeartRate: UInt8?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("UserProfileMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .friendlyName:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        friendlyName = stringData.smartString
                    }

                case .gender:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        gender = Gender(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            gender = Gender.invalid
                        }
                    }

                case .age:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        /// 1 * years + 0
                        age = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitDuration.year)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            age = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitDuration.year)
                        }
                    }

                case .height:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  100 * m + 0
                        let value = value.resolution(1 / 100)
                        height = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            height = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .weight:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        //  10 * kg + 0
                        let value = value.resolution(1 / 10)
                        weight = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            weight = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitMass.kilograms)
                        }
                    }

                case .language:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        language = Language(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            language = Language.invalid
                        }
                    }

                case .elevationSetting:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .weightSetting:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .restingHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        restingHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            restingHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .defaultMaxRunningHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        maxRunningHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maxRunningHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .defaultMaxBikingHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        maxBikingHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maxBikingHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .defaultMaxHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        maxHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maxHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .heartRateSetting:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .speedSetting:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        speedSetting = PositionDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            speedSetting = PositionDisplayType.invalid
                        }
                    }

                case .distanceSetting:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        distanceSetting = PositionDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            distanceSetting = PositionDisplayType.invalid
                        }
                    }

                case .powerSetting:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        powerSetting = PowerDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            powerSetting = PowerDisplayType.invalid
                        }
                    }

                case .activityClass:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .positionSetting:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        positionSetting = PositionDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            positionSetting = PositionDisplayType.invalid
                        }
                    }

                case .temperatureSetting:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        temperatureSetting = MeasurementDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            temperatureSetting = MeasurementDisplayType.invalid
                        }
                    }

                case .localID:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        localID = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            localID = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .globalID:
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .heightSetting:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        heightSetting = MeasurementDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heightSetting = MeasurementDisplayType.invalid
                        }
                    }

                case .runningStepLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * m + 0, User defined running step length set to 0 for auto length
                        let value = value.resolution(1 / 1000)
                        runningStepLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            runningStepLength = ValidatedMeasurement(value: Double(UInt16(definition.baseType.invalid)), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .walkingStepLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * m + 0, User defined running step length set to 0 for auto length
                        let value = value.resolution(1 / 1000)
                        walkingStepLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            walkingStepLength = ValidatedMeasurement(value: Double(UInt16(definition.baseType.invalid)), valid: false, unit: UnitLength.meters)
                        }
                    }

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

        return UserProfileMessage(timeStamp: timestamp,
                                  messageIndex: messageIndex,
                                  friendlyName: friendlyName,
                                  weight: weight,
                                  speedSetting: speedSetting,
                                  distanceSetting: distanceSetting,
                                  powerSetting: powerSetting,
                                  positionSetting: positionSetting,
                                  temperatureSetting: temperatureSetting,
                                  localID: localID,
                                  heightSetting: heightSetting,
                                  runningStepLength: runningStepLength,
                                  walkingStepLength: walkingStepLength,
                                  gender: gender,
                                  age: age,
                                  height: height,
                                  language: language,
                                  restingHeartRate: restingHeartRate,
                                  maxRunningHeartRate: maxRunningHeartRate,
                                  maxBikingHeartRate: maxBikingHeartRate,
                                  maxHeartRate: maxHeartRate)
    }
}
