//
//  MetZoneMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/25/18.
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

/// FIT MET Zone Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class MetZoneMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 10 }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Heart Rate High Level
    private(set) public var heartRate: ValidatedMeasurement<UnitCadence>?

    /// Calories per Minute
    private(set) public var calories: ValidatedMeasurement<UnitEnergy>?

    /// Fat Calories per Minute
    private(set) public var fatCalories: ValidatedMeasurement<UnitEnergy>?

    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                heartRate: UInt8? = nil,
                calories: ValidatedMeasurement<UnitEnergy>? = nil,
                fatCalories: ValidatedMeasurement<UnitEnergy>? = nil) {

        self.messageIndex = messageIndex

        if let hr = heartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.highBpm.baseType)
            self.heartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }
        
        self.calories = calories
        self.fatCalories = fatCalories
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> MetZoneMessage  {

        var messageIndex: MessageIndex?
        var heartRate: UInt8?
        var calories: ValidatedMeasurement<UnitEnergy>?
        var fatCalories: ValidatedMeasurement<UnitEnergy>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("MetZoneMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                case .highBpm:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        heartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            heartRate = value.value
                        } else {
                            heartRate = nil
                        }
                    }

                case .calories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * kcal / min + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        calories = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        calories = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .fatCalories:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * kcal / min + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        fatCalories = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        fatCalories = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                }
            }
        }

        return MetZoneMessage(messageIndex: messageIndex,
                              heartRate: heartRate,
                              calories: calories,
                              fatCalories: fatCalories)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage
    /// - Throws: FitError
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> DefinitionMessage {

        //try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let _ = messageIndex { fileDefs.append(key.fieldDefinition()) }

            case .highBpm:
                if let _ = heartRate { fileDefs.append(key.fieldDefinition()) }
            case .calories:
                if let _ = calories { fileDefs.append(key.fieldDefinition()) }
            case .fatCalories:
                if let _ = fatCalories { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: MetZoneMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return defMessage
        } else {
            throw self.encodeNoPropertiesAvailable()
        }
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data representation
    /// - Throws: FitError
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) throws -> Data {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            throw self.encodeWrongDefinitionMessage()
        }

        var msgData = Data()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())
                }

            case .highBpm:
                if let heartRate = heartRate {
                    let valueData = try key.encodeKeyed(value: heartRate.value)
                    msgData.append(valueData)
                }

            case .calories:
                if var calories = calories {
                    calories = calories.converted(to: UnitEnergy.kilocalories)
                    let valueData = try key.encodeKeyed(value: calories.value)
                    msgData.append(valueData)
                }

            case .fatCalories:
                if var fatCalories = fatCalories {
                    fatCalories = fatCalories.converted(to: UnitEnergy.kilocalories)
                    let valueData = try key.encodeKeyed(value: fatCalories.value)
                    msgData.append(valueData)
                }

            }
        }

        if msgData.count > 0 {
            return encodedDataMessage(localMessageType: localMessageType, msgData: msgData)
        } else {
            throw self.encodeNoPropertiesAvailable()
        }
    }
}
