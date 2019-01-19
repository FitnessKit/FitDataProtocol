//
//  TotalsMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/29/18.
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

/// FIT Totals Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class TotalsMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 33 }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Timer Time
    ///
    /// Excludes pauses
    private(set) public var timerTime: Measurement<UnitDuration>?

    /// Distance
    private(set) public var distance: ValidatedMeasurement<UnitLength>?

    /// Calories
    private(set) public var calories: ValidatedMeasurement<UnitEnergy>?

    /// Sport
    private(set) public var sport: Sport?

    /// Elapsed Time
    ///
    /// Includes pauses
    private(set) public var elapsedTime: Measurement<UnitDuration>?

    /// Sessions
    private(set) public var sessions: ValidatedBinaryInteger<UInt16>?

    /// Active Time
    private(set) public var activeTime: Measurement<UnitDuration>?


    public required init() {}

    public init(timeStamp: FitTime? = nil,
                messageIndex: MessageIndex? = nil,
                timerTime: Measurement<UnitDuration>? = nil,
                distance: ValidatedMeasurement<UnitLength>? = nil,
                calories: ValidatedMeasurement<UnitEnergy>? = nil,
                sport: Sport? = nil,
                elapsedTime: Measurement<UnitDuration>? = nil,
                sessions: ValidatedBinaryInteger<UInt16>? = nil,
                activeTime: Measurement<UnitDuration>? = nil) {
        
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex
        self.timerTime = timerTime
        self.distance = distance
        self.calories = calories
        self.sport = sport
        self.elapsedTime = elapsedTime
        self.sessions = sessions
        self.activeTime = activeTime
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> TotalsMessage  {

        var timestamp: FitTime?
        var messageIndex: MessageIndex?
        var timerTime: Measurement<UnitDuration>?
        var distance: ValidatedMeasurement<UnitLength>?
        var calories: ValidatedMeasurement<UnitEnergy>?
        var sport: Sport?
        var elapsedTime: Measurement<UnitDuration>?
        var sessions: ValidatedBinaryInteger<UInt16>?
        var activeTime: Measurement<UnitDuration>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("TotalsMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
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


                case .timerTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * s + 0
                        let value = value.resolution(1)
                        timerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .distance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * m + 0
                        let value = value.resolution(1)
                        distance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        distance = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .calories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * kcal + 0
                        calories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        calories = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .sport:
                    sport = Sport.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .elapsedTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * s + 0
                        let value = value.resolution(1)
                        elapsedTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .sessions:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    sessions = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                        definition: definition,
                                                                        dataStrategy: dataStrategy)

                case .activeTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * s + 0
                        let value = value.resolution(1)
                        activeTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                }

            }
        }

        return TotalsMessage(timeStamp: timestamp,
                             messageIndex: messageIndex,
                             timerTime: timerTime,
                             distance: distance,
                             calories: calories,
                             sport: sport,
                             elapsedTime: elapsedTime,
                             sessions: sessions,
                             activeTime: activeTime)
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
            case .timestamp:
                if let _ = timeStamp { fileDefs.append(key.fieldDefinition()) }

            case .timerTime:
                if let _ = timerTime { fileDefs.append(key.fieldDefinition()) }
            case .distance:
                if let _ = distance { fileDefs.append(key.fieldDefinition()) }
            case .calories:
                if let _ = calories { fileDefs.append(key.fieldDefinition()) }
            case .sport:
                if let _ = sport { fileDefs.append(key.fieldDefinition()) }
            case .elapsedTime:
                if let _ = elapsedTime { fileDefs.append(key.fieldDefinition()) }
            case .sessions:
                if let _ = sessions { fileDefs.append(key.fieldDefinition()) }
            case .activeTime:
                if let _ = activeTime { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: TotalsMessage.globalMessageNumber(),
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
            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())
                }


            case .timerTime:
                if var timerTime = timerTime {
                    timerTime = timerTime.converted(to: UnitDuration.seconds)
                    let valueData = try key.encodeKeyed(value: timerTime.value)
                    msgData.append(valueData)
                }

            case .distance:
                if var distance = distance {
                    distance = distance.converted(to: UnitLength.meters)
                    let valueData = try key.encodeKeyed(value: distance.value)
                    msgData.append(valueData)
                }

            case .calories:
                if var calories = calories {
                    calories = calories.converted(to: UnitEnergy.kilocalories)
                    let valueData = try key.encodeKeyed(value: calories.value)
                    msgData.append(valueData)
                }

            case .sport:
                if let sport = sport {
                    let valueData = try key.encodeKeyed(value: sport)
                    msgData.append(valueData)
                }

            case .elapsedTime:
                if var elapsedTime = elapsedTime {
                    elapsedTime = elapsedTime.converted(to: UnitDuration.seconds)
                    let valueData = try key.encodeKeyed(value: elapsedTime.value)
                    msgData.append(valueData)
                }

            case .sessions:
                if let sessions = sessions {
                    let valueData = try key.encodeKeyed(value: sessions.value)
                    msgData.append(valueData)
                }

            case .activeTime:
                if var activeTime = activeTime {
                    activeTime = activeTime.converted(to: UnitDuration.seconds)
                    let valueData = try key.encodeKeyed(value: activeTime.value)
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
