//
//  FileCreatorMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
//

import Foundation
import DataDecoder

/// FIT File Creator Message
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FileCreatorMessage: FitMessage, FitMessageKeys {

    public override func globalMessageNumber() -> UInt16 {
        return 49
    }

    public enum MessageKeys: Int, CodingKey {
        case softwareVersion    = 0
        case hardwareVersion    = 1
    }

    public typealias FitCodingKeys = MessageKeys

    /// Software Version
    private(set) public var softwareVersion: UInt16?

    /// Hardware Version
    private(set) public var hardwareVersion: UInt8?

    internal override init() {}

    public init(softwareVersion: UInt16?, hardwareVersion: UInt8?) {
        self.softwareVersion = softwareVersion
        self.hardwareVersion = hardwareVersion
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> FileCreatorMessage  {

        var softwareVersion: UInt16?
        var hardwareVersion: UInt8?

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

                case .softwareVersion:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        softwareVersion = value
                    }


                case .hardwareVersion:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        hardwareVersion = value
                    }

                }
            }
        }

        return FileCreatorMessage(softwareVersion: softwareVersion,
                                  hardwareVersion: hardwareVersion)
    }
}
