//
//  ScheduleMessage.swift
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
import AntMessageProtocol

/// FIT Schedule Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ScheduleMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 28 }

    /// Manufacturer
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var manufacturer: Manufacturer?

    /// Product
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var product: ValidatedBinaryInteger<UInt16>?

    /// Serial Number
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var serialNumber: ValidatedBinaryInteger<UInt32>?

    /// Time Created
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var timeCreated: FitTime?

    /// Completed
    ///
    /// True if Activity has been started
    private(set) public var completed: Bool?

    /// Schedule Type
    private(set) public var scheduleType: ScheduleType?

    /// Scheduled Time
    private(set) public var scheduledTime: FitTime?

    public required init() {}

    public init(manufacturer: Manufacturer? = nil,
                product: ValidatedBinaryInteger<UInt16>? = nil,
                serialNumber: ValidatedBinaryInteger<UInt32>? = nil,
                timeCreated: FitTime? = nil,
                completed: Bool? = nil,
                scheduleType: ScheduleType? = nil,
                scheduledTime: FitTime? = nil) {

        self.manufacturer = manufacturer
        self.product = product
        self.serialNumber = serialNumber
        self.timeCreated = timeCreated
        self.completed = completed
        self.scheduleType = scheduleType
        self.scheduledTime = scheduledTime
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> ScheduleMessage  {

        var manufacturer: Manufacturer?
        var product: ValidatedBinaryInteger<UInt16>?
        var serialNumber: ValidatedBinaryInteger<UInt32>?
        var timeCreated: FitTime?
        var completed: Bool?
        var scheduleType: ScheduleType?
        var scheduledTime: FitTime?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ScheduleMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .manufacturer:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        manufacturer = Manufacturer.company(id: value)
                    }

                case .product:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    product = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                       definition: definition,
                                                                       dataStrategy: dataStrategy)

                case .serialNumber:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    serialNumber = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                            definition: definition,
                                                                            dataStrategy: dataStrategy)

                case .timeCreated:
                    timeCreated = FitTime.decode(decoder: &localDecoder,
                                                 endian: arch,
                                                 definition: definition,
                                                 data: fieldData)

                case .completed:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        completed = value.boolValue
                    }

                case .scheduleType:
                    scheduleType = ScheduleType.decode(decoder: &localDecoder,
                                                       definition: definition,
                                                       data: fieldData,
                                                       dataStrategy: dataStrategy)

                case .scheduledTime:
                    scheduledTime = FitTime.decode(decoder: &localDecoder,
                                                   endian: arch,
                                                   definition: definition,
                                                   data: fieldData,
                                                   isLocal: true)

                }
            }
        }

        return ScheduleMessage(manufacturer: manufacturer,
                               product: product,
                               serialNumber: serialNumber,
                               timeCreated: timeCreated,
                               completed: completed,
                               scheduleType: scheduleType,
                               scheduledTime: scheduledTime)
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
            case .manufacturer:
                if let _ = manufacturer { fileDefs.append(key.fieldDefinition()) }
            case .product:
                if let _ = product { fileDefs.append(key.fieldDefinition()) }
            case .serialNumber:
                if let _ = serialNumber { fileDefs.append(key.fieldDefinition()) }
            case .timeCreated:
                if let _ = timeCreated { fileDefs.append(key.fieldDefinition()) }
            case .completed:
                if let _ = completed { fileDefs.append(key.fieldDefinition()) }
            case .scheduleType:
                if let _ = scheduleType { fileDefs.append(key.fieldDefinition()) }
            case .scheduledTime:
                if let _ = scheduledTime { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ScheduleMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return defMessage
        } else {
            throw FitError(.encodeError(msg: "ScheduleMessage contains no Properties Available to Encode"))
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
            throw FitError(.encodeError(msg: "Wrong DefinitionMessage used for Encoding ScheduleMessage"))
        }

        var msgData = Data()

        for key in FitCodingKeys.allCases {

            switch key {
            case .manufacturer:
                if let manufacturer = manufacturer {
                    msgData.append(Data(from: manufacturer.manufacturerID.littleEndian))
                }

            case .product:
                if let product = product {
                    msgData.append(Data(from: product.value.littleEndian))
                }

            case .serialNumber:
                if let serialNumber = serialNumber {
                    msgData.append(Data(from: serialNumber.value.littleEndian))
                }

            case .timeCreated:
                if let timeCreated = timeCreated {
                    msgData.append(timeCreated.encode())
                }

            case .completed:
                if let completed = completed {
                    msgData.append(completed.uint8Value)
                }

            case .scheduleType:
                if let scheduleType = scheduleType {
                    msgData.append(scheduleType.rawValue)
                }

            case .scheduledTime:
                if let scheduledTime = scheduledTime {
                    msgData.append(scheduledTime.encode())
                }
            }
        }

        if msgData.count > 0 {
            var encodedMsg = Data()

            let recHeader = RecordHeader(localMessageType: localMessageType, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "ScheduleMessage contains no Properties Available to Encode"))
        }
    }

}
