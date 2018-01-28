//
//  BaseType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
//

import Foundation


internal enum BaseType: UInt8 {
    case enumtype       = 0
    case sint8          = 1
    case uint8          = 2
    case sint16         = 3
    case uint16         = 4
    case sint32         = 5
    case uint32         = 6
    case string         = 7  //Null terminated string UTF-8
    case float32        = 8
    case float64        = 9
    case uint8z         = 10
    case uint16z        = 11
    case uint32z        = 12
    case byte           = 13
    case sint64         = 14
    case uint64         = 15
    case uint64z        = 16

    case unknown        = 255
}


internal extension BaseType {

    var invalid: UInt64 {
        switch self {
        case .enumtype:
            return 0xFF

        case .sint8:
            return 0x7F

        case .uint8:
            return 0xFF

        case .sint16:
            return 0x7FFF

        case .uint16:
            return 0xFFFF

        case .sint32:
            return 0x7FFFFFFF

        case .uint32:
            return 0xFFFFFFFF

        case .string:
            return 0x00

        case .float32:
            return 0xFFFFFFFF

        case .float64:
            return 0xFFFFFFFFFFFFFFFF

        case .uint8z:
            return 0x00

        case .uint16z:
            return 0x0000

        case .uint32z:
            return 0x00000000

        case .byte:
            return 0xFF

        case .sint64:
            return 0x7FFFFFFFFFFFFFFF

        case .uint64:
            return 0xFFFFFFFFFFFFFFFF

        case .uint64z:
            return 0x0000000000000000

        case .unknown:
            return 0xFF

        }
    }
}
