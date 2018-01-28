//
//  UInt8Extension.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation

internal extension UInt8 {
    var boolValue: Bool {
        switch self {
        case 0x01:
            return true
        case 0x00:
            return false
        default:
            return false
        }
    }
}
