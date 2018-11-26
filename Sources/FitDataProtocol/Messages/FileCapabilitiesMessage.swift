//
//  FileCapabilitiesMessage.swift
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

/// FIT File Capabilities Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FileCapabilitiesMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 37
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// File Type
    private(set) public var fileType: FileType?

    /// Hardware Version
    private(set) public var fileFlags: FitFileFlag?

    /// Directory
    private(set) public var directory: String?

    /// Max Count
    private(set) public var maxCount: ValidatedBinaryInteger<UInt16>?

    /// Max Size
    private(set) public var maxSize: ValidatedBinaryInteger<UInt32>?

    public required init() {}

    public init(messageIndex: MessageIndex?,
                fileType: FileType?,
                fileFlags: FitFileFlag?,
                directory: String?,
                maxCount: ValidatedBinaryInteger<UInt16>?,
                maxSize: ValidatedBinaryInteger<UInt32>?) {

        self.messageIndex = messageIndex
        self.fileType = fileType
        self.fileFlags = fileFlags
        self.directory = directory
        self.maxCount = maxCount
        self.maxSize = maxSize
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> FileCapabilitiesMessage  {

        var messageIndex: MessageIndex?
        var fileType: FileType?
        var fileFlags: FitFileFlag?
        var directory: String?
        var maxCount: ValidatedBinaryInteger<UInt16>?
        var maxSize: ValidatedBinaryInteger<UInt32>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("FileCapabilitiesMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .fileType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            fileType = FileType.invalid
                        }

                    } else {
                        fileType = FileType(rawValue: value)
                    }

                case .fileFlags:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        fileFlags = FitFileFlag(rawValue: value)
                    }


                case .directory:
                    directory = String.decode(decoder: &localDecoder,
                                              definition: definition,
                                              data: fieldData,
                                              dataStrategy: dataStrategy)

                case .maxCount:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        maxCount = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        maxCount = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .maxSize:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        maxSize = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        maxSize = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        return FileCapabilitiesMessage(messageIndex: messageIndex,
                                       fileType: fileType,
                                       fileFlags: fileFlags,
                                       directory: directory,
                                       maxCount: maxCount,
                                       maxSize: maxSize)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .fileType:
                if let fileType = fileType {
                    msgData.append(fileType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .fileFlags:
                if let fileFlags = fileFlags {
                    msgData.append(fileFlags.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .directory:
                if let directory = directory {
                    if let stringData = directory.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .maxCount:
                if let maxCount = maxCount {
                    msgData.append(Data(from: maxCount.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .maxSize:
                if let maxSize = maxSize {
                    msgData.append(Data(from: maxSize.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: FileCapabilitiesMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "FileCapabilitiesMessage contains no Properties Available to Encode"))
        }
    }

}
