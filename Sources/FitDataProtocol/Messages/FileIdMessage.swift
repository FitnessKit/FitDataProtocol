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
import AntMessageProtocol

/// FIT Field ID Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FileIdMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 0
    }

    /// Device Serial Number
    private(set) public var deviceSerialNumber: UInt32?

    /// Date of File Creation
    private(set) public var fileCreationDate: FitTime?

    /// Manufacturer
    private(set) public var manufacturer: Manufacturer?

    /// Product
    private(set) public var product: UInt16?

    /// File Number
    private(set) public var fileNumber: UInt16?

    /// File Type
    private(set) public var fileType: FileType?

    public required init() {}

    public init(deviceSerialNumber: UInt32?, fileCreationDate: FitTime?, manufacturer: Manufacturer?, product: UInt16?, fileNumber: UInt16?, fileType: FileType?) {
        self.deviceSerialNumber = deviceSerialNumber
        self.fileCreationDate = fileCreationDate
        self.manufacturer = manufacturer
        self.product = product
        self.fileNumber = fileNumber
        self.fileType = fileType
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> FileIdMessage  {

        var deviceSerialNumber: UInt32?
        var fileCreationDate: FitTime?
        var manufacturer: Manufacturer?
        var product: UInt16?
        var fileNumber: UInt16?
        var fileType: FileType?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("FileIdMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .fileType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) == definition.baseType.invalid {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            fileType = FileType.invalid
                        }

                    } else {
                        fileType = FileType(rawType: value)
                    }

                case .manufacturer:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        manufacturer = Manufacturer.company(id: value)
                    }
                    
                case .product:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        product = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            product = UInt16(definition.baseType.invalid)
                        }
                    }

                case .serialNumber:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        deviceSerialNumber = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            deviceSerialNumber = UInt32(definition.baseType.invalid)
                        }
                    }

                case .fileCreationDate:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        fileCreationDate = FitTime(time: value)
                    }

                case .fileNumber:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        fileNumber = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            fileNumber = UInt16(definition.baseType.invalid)
                        }
                    }

                    
                case .productName:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                }
            }
        }

        return FileIdMessage(deviceSerialNumber: deviceSerialNumber,
                             fileCreationDate: fileCreationDate,
                             manufacturer: manufacturer,
                             product: product,
                             fileNumber: fileNumber,
                             fileType: fileType)
    }

}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension FileIdMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    public enum MessageKeys: Int, CodingKey {
        case fileType           = 0
        case manufacturer       = 1
        case product            = 2
        case serialNumber       = 3
        case fileCreationDate   = 4
        case fileNumber         = 5
        case productName        = 8
    }
}
