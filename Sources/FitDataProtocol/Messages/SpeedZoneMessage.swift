//
//  SpeedZoneMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/18.
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

/// FIT Speed Zone Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SpeedZoneMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 53 }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Speed Zone Name
    private(set) public var name: String?

    /// Speed Zone High Level
    private(set) public var highLevel: ValidatedMeasurement<UnitSpeed>?

    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                name: String? = nil,
                highLevel: ValidatedMeasurement<UnitSpeed>? = nil) {
        
        self.messageIndex = messageIndex
        self.name = name
        self.highLevel = highLevel
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> SpeedZoneMessage  {

        var messageIndex: MessageIndex?
        var name: String?
        var highLevel: ValidatedMeasurement<UnitSpeed>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("SpeedZoneMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .highValue:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * m/s + 0
                        let value = value.resolution(1 / 1000)
                        highLevel = ValidatedMeasurement(value: value, valid: true, unit: UnitSpeed.metersPerSecond)
                    } else {
                        highLevel = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitSpeed.metersPerSecond)
                    }

                case .name:
                    name = String.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        return SpeedZoneMessage(messageIndex: messageIndex,
                                name: name,
                                highLevel: highLevel)
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
            case .highValue:
                if var _ = highLevel { fileDefs.append(key.fieldDefinition()) }
            case .name:
                if let stringData = name?.data(using: .utf8) {
                    //16 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        throw FitError(.encodeError(msg: "name size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .messageIndex:
                if let _ = messageIndex { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: SpeedZoneMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return defMessage
        } else {
            throw FitError(.encodeError(msg: "SpeedZoneMessage contains no Properties Available to Encode"))
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
            throw FitError(.encodeError(msg: "Wrong DefinitionMessage used for Encoding SpeedZoneMessage"))
        }

        var msgData = Data()

        for key in FitCodingKeys.allCases {

            switch key {
            case .highValue:
                if var highLevel = highLevel {
                    // 1000 * m/s + 0
                    highLevel = highLevel.converted(to: UnitSpeed.metersPerSecond)
                    let value = highLevel.value.resolutionUInt16(1000, offset: 0.0)

                    msgData.append(Data(from: value.littleEndian))
                }

            case .name:
                if let name = name {
                    if let stringData = name.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())
                }
            }
        }

        if msgData.count > 0 {
            return encodedDataMessage(localMessageType: localMessageType, msgData: msgData)
        } else {
            throw FitError(.encodeError(msg: "SpeedZoneMessage contains no Properties Available to Encode"))
        }
    }
}
