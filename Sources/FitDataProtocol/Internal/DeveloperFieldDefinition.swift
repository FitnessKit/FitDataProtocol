//
//  DeveloperFieldDefinition.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation
import DataDecoder

internal struct DeveloperFieldDefinition {

    private(set) var fieldNumber: UInt8

    private(set) var size: UInt8

    private(set) var dataIndex: UInt8
}

internal extension DeveloperFieldDefinition {

    internal static func decode(decoder: inout DataDecoder) throws -> DeveloperFieldDefinition {

        let fieldNumber = decoder.decodeUInt8()
        let size = decoder.decodeUInt8()
        let dataIndex = decoder.decodeUInt8()

        return DeveloperFieldDefinition(fieldNumber: fieldNumber,
                                        size: size,
                                        dataIndex: dataIndex)
    }

}
