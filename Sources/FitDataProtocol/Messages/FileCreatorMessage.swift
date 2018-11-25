//
//  FileCreatorMessage.swift
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

/// FIT File Creator Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FileCreatorMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 49
    }

    /// Software Version
    private(set) public var softwareVersion: ValidatedBinaryInteger<UInt16>?

    /// Hardware Version
    private(set) public var hardwareVersion: ValidatedBinaryInteger<UInt8>?

    public required init() {}

    public init(softwareVersion: ValidatedBinaryInteger<UInt16>?, hardwareVersion: ValidatedBinaryInteger<UInt8>?) {
        self.softwareVersion = softwareVersion
        self.hardwareVersion = hardwareVersion
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> FileCreatorMessage  {

        var softwareVersion: ValidatedBinaryInteger<UInt16>?
        var hardwareVersion: ValidatedBinaryInteger<UInt8>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("FileCreatorMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .softwareVersion:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        softwareVersion = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        softwareVersion = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .hardwareVersion:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        hardwareVersion = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        hardwareVersion = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                }
            }
        }

        return FileCreatorMessage(softwareVersion: softwareVersion,
                                  hardwareVersion: hardwareVersion)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode() throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .softwareVersion:
                if let softwareVersion = softwareVersion {
                    msgData.append(Data(from: softwareVersion.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .hardwareVersion:
                if let hardwareVersion = hardwareVersion {
                    msgData.append(Data(from: hardwareVersion.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: FileCreatorMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "FileCreatorMessage contains no Properties Available to Encode"))
        }

    }

}
