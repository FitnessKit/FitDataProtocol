//
//  DeveloperDataIdMessage.swift
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

/// FIT Developer Data ID Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeveloperDataIdMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 207
    }

    /// Developer ID
    private(set) public var developerId: Data?

    /// Application ID
    private(set) public var applicationId: Data?

    /// Application Version
    private(set) public var applicationVersion: ValidatedBinaryInteger<UInt32>?

    /// Manufacturer
    private(set) public var manufacturer: Manufacturer?

    /// Data Index
    private(set) public var dataIndex: ValidatedBinaryInteger<UInt8>?

    public required init() {}

    public init(developerId: Data?,
                applicationId: Data?,
                applicationVersion: ValidatedBinaryInteger<UInt32>?,
                manufacturer: Manufacturer?,
                dataIndex: ValidatedBinaryInteger<UInt8>?) {
        
        self.developerId = developerId
        self.applicationId = applicationId
        self.applicationVersion = applicationVersion
        self.manufacturer = manufacturer
        self.dataIndex = dataIndex
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> DeveloperDataIdMessage  {

        var developerId: Data?
        var applicationId: Data?
        var applicationVersion: ValidatedBinaryInteger<UInt32>?
        var manufacturer: Manufacturer?
        var dataIndex: ValidatedBinaryInteger<UInt8>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("DeveloperDataIdMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .developerId:
                    let value = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if value.isValidForBaseType(definition.baseType) {
                        developerId = value
                    }

                case .applicationId:
                    let value = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if value.isValidForBaseType(definition.baseType) {
                        applicationId = value
                    }

                case .manufacturerId:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        manufacturer = Manufacturer.company(id: value)
                    }
                    
                case .dataIndex:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        dataIndex = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        dataIndex = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .applicationVersion:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        applicationVersion = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        applicationVersion = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                }
            }
        }

        return DeveloperDataIdMessage(developerId: developerId,
                                      applicationId: applicationId,
                                      applicationVersion: applicationVersion,
                                      manufacturer: manufacturer,
                                      dataIndex: dataIndex)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .developerId:
                if let developerId = developerId {
                    msgData.append(developerId)

                    fileDefs.append(key.fieldDefinition())
                }

            case .applicationId:
                if let applicationId = applicationId {
                    msgData.append(applicationId)

                    fileDefs.append(key.fieldDefinition())
                }

            case .manufacturerId:
                if let manufacturer = manufacturer {
                    msgData.append(Data(from: manufacturer.manufacturerID.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .dataIndex:
                if let dataIndex = dataIndex {
                    msgData.append(dataIndex.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .applicationVersion:
                if let applicationVersion = applicationVersion {
                    msgData.append(Data(from: applicationVersion.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: DeveloperDataIdMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "DeveloperDataIdMessage contains no Properties Available to Encode"))
        }
    }

}
