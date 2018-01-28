//
//  FieldDefinition.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation
import DataDecoder

internal struct FieldDefinition {

    private(set) var fieldDefinitionNumber: UInt8

    private(set) var size: UInt8

    private(set) var endianAbility: Bool

    private(set) var baseType: BaseType
}

internal extension FieldDefinition {

    internal static func decode(decoder: inout DataDecoder) throws -> FieldDefinition {

        let messageNumber = decoder.decodeUInt8()
        let size = decoder.decodeUInt8()
        let baseType = decoder.decodeUInt8()

        let endian = (baseType & 0x80 == 0x80)
        let baseNumber = BaseType(rawValue: (baseType & 0x1F)) ?? .unknown

        return FieldDefinition(fieldDefinitionNumber: messageNumber,
                               size: size,
                               endianAbility: endian,
                               baseType: baseNumber)
    }

}
