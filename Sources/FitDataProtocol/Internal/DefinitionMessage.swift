//
//  DefinitionMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation
import DataDecoder

internal enum Endian: UInt8 {
    /// Little
    case little     = 0
    /// Big
    case big        = 1
}

internal struct DefinitionMessage {

    private(set) var architecture: Endian

    private(set) var globalMessageNumber: UInt16

    private(set) var fieldDefinitions: [FieldDefinition]

    private(set) var developerFieldDefinitions: [DeveloperFieldDefinition]

}


internal extension DefinitionMessage {

    internal static func decode(decoder: inout DataDecoder, header: RecordHeader) throws -> DefinitionMessage {

        // Reserved Byte
        let _ = decoder.decodeUInt8()

        let archvalue = decoder.decodeUInt8();

        guard let architecture = Endian(rawValue: archvalue) else { throw FitError(message: "Architecture Type is invalid.") }

        var globalMessage = decoder.decodeUInt16()

        switch architecture {
        case .little:
            globalMessage = globalMessage.littleEndian
        case .big:
            globalMessage = globalMessage.bigEndian
        }

        let fields = decoder.decodeUInt8()

        var definitions: [FieldDefinition] = [FieldDefinition]()

        for _ in 0..<fields {
            let fieldDef = try FieldDefinition.decode(decoder: &decoder)

            definitions.append(fieldDef)
        }

        var devDefinitions: [DeveloperFieldDefinition] = [DeveloperFieldDefinition]()
        if header.developerData == true {
            let devFields = decoder.decodeUInt8()

            for _ in 0..<devFields {

                let fieldDef = try DeveloperFieldDefinition.decode(decoder: &decoder)

                devDefinitions.append(fieldDef)
            }
        }

        return DefinitionMessage(architecture: architecture,
                                 globalMessageNumber: globalMessage,
                                 fieldDefinitions: definitions,
                                 developerFieldDefinitions: devDefinitions)
    }

}
