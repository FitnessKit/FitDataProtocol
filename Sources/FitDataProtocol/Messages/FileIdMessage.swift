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
    public override class func globalMessageNumber() -> UInt16 { return 0 }

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

    public init(deviceSerialNumber: ValidatedBinaryInteger<UInt32>? = nil,
                fileCreationDate: FitTime? = nil,
                manufacturer: Manufacturer? = nil,
                product: ValidatedBinaryInteger<UInt16>? = nil,
                fileNumber: ValidatedBinaryInteger<UInt16>? = nil,
                fileType: FileType? = nil,
                productName: String? = nil) {
        
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
                        fileType = FileType(rawValue: value)
                    } else {
                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            fileType = FileType.invalid
                        }
                    }

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
                    deviceSerialNumber = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                                  definition: definition,
                                                                                  dataStrategy: dataStrategy)

                case .fileCreationDate:
                    fileCreationDate = FitTime.decode(decoder: &localDecoder,
                                                      endian: arch,
                                                      definition: definition,
                                                      data: fieldData)

                case .fileNumber:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    fileNumber = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                          definition: definition,
                                                                          dataStrategy: dataStrategy)

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

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage
    /// - Throws: FitError
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> DefinitionMessage {

        /// Validation is done in the encoder right now
        //try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .fileType:
                if let _ = fileType { fileDefs.append(key.fieldDefinition()) }
            case .manufacturer:
                if let _ = manufacturer { fileDefs.append(key.fieldDefinition()) }
            case .product:
                if let _ = product { fileDefs.append(key.fieldDefinition()) }
            case .serialNumber:
                if let _ = deviceSerialNumber { fileDefs.append(key.fieldDefinition()) }
            case .fileCreationDate:
                if let _ = fileCreationDate { fileDefs.append(key.fieldDefinition()) }
            case .fileNumber:
                if let _ = fileNumber { fileDefs.append(key.fieldDefinition()) }
            case .productName:
                if let stringData = productName?.data(using: .utf8) {
                    //20 typical size... but we will count the String
                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: FileIdMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return defMessage
        } else {
            throw FitError(.encodeError(msg: "FileIdMessage contains no Properties Available to Encode"))
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
            throw FitError(.encodeError(msg: "Wrong DefinitionMessage used for Encoding FileIdMessage"))
        }

        var msgData = Data()

        for key in FileIdMessage.FitCodingKeys.allCases {

            switch key {
            case .fileType:
                if let fileType = fileType {
                    msgData.append(fileType.rawValue)
                }

            case .manufacturer:
                if let manufacturer = manufacturer {
                    msgData.append(Data(from: manufacturer.manufacturerID.littleEndian))
                }

            case .product:
                if let product = product {
                    msgData.append(Data(from: product.value.littleEndian))
                }

            case .serialNumber:
                if let deviceSerialNumber = deviceSerialNumber {
                    msgData.append(Data(from: deviceSerialNumber.value.littleEndian))
                }

            case .fileCreationDate:
                if let fileCreationDate = fileCreationDate {
                    msgData.append(fileCreationDate.encode())
                }

            case .fileNumber:
                if let fileNumber = fileNumber {
                    msgData.append(Data(from: fileNumber.value.littleEndian))
                }

            case .productName:
                if let productName = productName {
                    if let stringData = productName.data(using: .utf8) {
                        msgData.append(stringData)
                    }
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
            throw FitError(.encodeError(msg: "FileIdMessage contains no Properties Available to Encode"))
        }

    }

}
