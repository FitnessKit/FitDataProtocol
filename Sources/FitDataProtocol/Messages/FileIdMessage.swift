//
//  FileIdMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation
import DataDecoder

/// FIT Field ID Message
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FileIdMessage: FitMessage, FitMessageKeys {

    public override func globalMessageNumber() -> UInt16 {
        return 0
    }

    public enum MessageKeys: Int, CodingKey {
        case fileType           = 0
        case manufacturer       = 1
        case product            = 2
        case serialNumber       = 3
        case fileCreationDate   = 4
        case fileNumber         = 5
        case productName        = 8
    }

    public typealias FitCodingKeys = MessageKeys

    /// Device Serial Number
    private(set) public var deviceSerialNumber: UInt32?

    /// Date of File Creation
    private(set) public var fileCreationDate: FitTime?

    /// Manufacturer
    private(set) public var manufacturer: AntManufacturer?

    /// Product
    private(set) public var product: UInt16?

    /// File Number
    private(set) public var fileNumber: UInt16?

    /// File Type
    private(set) public var fileType: FileType?

    public required init() {}

    public init(deviceSerialNumber: UInt32?, fileCreationDate: FitTime?, manufacturer: AntManufacturer?, product: UInt16?, fileNumber: UInt16?, fileType: FileType?) {
        self.deviceSerialNumber = deviceSerialNumber
        self.fileCreationDate = fileCreationDate
        self.manufacturer = manufacturer
        self.product = product
        self.fileNumber = fileNumber
        self.fileType = fileType
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> FileIdMessage  {

        var deviceSerialNumber: UInt32?
        var fileCreationDate: FitTime?
        var manufacturer: AntManufacturer?
        var product: UInt16?
        var fileNumber: UInt16?
        var fileType: FileType?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .fileType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) == definition.baseType.invalid {
                        fileType = FileType.invalid
                    }
                    fileType = FileType(rawType: value)

                case .manufacturer:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        manufacturer = AntManufacturer(rawValue: value)
                    }

                case .product:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        product = value
                    }

                case .serialNumber:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        deviceSerialNumber = value
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
                    }

                    
                case .productName:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("productName")
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
