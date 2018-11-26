//
//  FileIdMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
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

/// FIT Field ID Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FileIdMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 0
    }

    /// Device Serial Number
    private(set) public var deviceSerialNumber: ValidatedBinaryInteger<UInt32>?

    /// Date of File Creation
    private(set) public var fileCreationDate: FitTime?

    /// Manufacturer
    private(set) public var manufacturer: Manufacturer?

    /// Product
    private(set) public var product: ValidatedBinaryInteger<UInt16>?

    /// File Number
    private(set) public var fileNumber: ValidatedBinaryInteger<UInt16>?

    /// File Type
    private(set) public var fileType: FileType?

    /// Product Name
    private(set) public var productName: String?

    public required init() {}

    public init(deviceSerialNumber: ValidatedBinaryInteger<UInt32>?,
                fileCreationDate: FitTime?,
                manufacturer: Manufacturer?,
                product: ValidatedBinaryInteger<UInt16>?,
                fileNumber: ValidatedBinaryInteger<UInt16>?,
                fileType: FileType?,
                productName: String?) {
        
        self.deviceSerialNumber = deviceSerialNumber
        self.fileCreationDate = fileCreationDate
        self.manufacturer = manufacturer
        self.product = product
        self.fileNumber = fileNumber
        self.fileType = fileType
        self.productName = productName
    }


    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> FileIdMessage  {

        var deviceSerialNumber: ValidatedBinaryInteger<UInt32>?
        var fileCreationDate: FitTime?
        var manufacturer: Manufacturer?
        var product: ValidatedBinaryInteger<UInt16>?
        var fileNumber: ValidatedBinaryInteger<UInt16>?
        var fileType: FileType?
        var productName: String?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("FileIdMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

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

                case .manufacturer:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        manufacturer = Manufacturer.company(id: value)
                    }
                    
                case .product:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        product = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        product = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .serialNumber:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        deviceSerialNumber = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        deviceSerialNumber = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .fileCreationDate:
                    fileCreationDate = FitTime.decode(decoder: &localDecoder,
                                                      endian: arch,
                                                      definition: definition,
                                                      data: fieldData)

                case .fileNumber:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        fileNumber = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        fileNumber = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .productName:
                    productName = String.decode(decoder: &localDecoder,
                                                definition: definition,
                                                data: fieldData,
                                                dataStrategy: dataStrategy)
                }
            }
        }

        return FileIdMessage(deviceSerialNumber: deviceSerialNumber,
                             fileCreationDate: fileCreationDate,
                             manufacturer: manufacturer,
                             product: product,
                             fileNumber: fileNumber,
                             fileType: fileType,
                             productName: productName)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FileIdMessage.FitCodingKeys.allCases {

            switch key {
            case .fileType:
                if let fileType = fileType {
                    msgData.append(fileType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .manufacturer:
                if let manufacturer = manufacturer {
                    msgData.append(Data(from: manufacturer.manufacturerID.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .product:
                if let product = product {
                    msgData.append(Data(from: product.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .serialNumber:
                if let deviceSerialNumber = deviceSerialNumber {
                    msgData.append(Data(from: deviceSerialNumber.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .fileCreationDate:
                if let fileCreationDate = fileCreationDate {
                    msgData.append(fileCreationDate.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .fileNumber:
                if let fileNumber = fileNumber {
                    msgData.append(Data(from: fileNumber.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .productName:
                if let productName = productName {

                    if let stringData = productName.data(using: .utf8) {
                        msgData.append(stringData)

                        //20 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }

                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: FileIdMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "FileIdMessage contains no Properties Available to Encode"))
        }

    }

}
