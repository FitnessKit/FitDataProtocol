//
//  BaseType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
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

/// FIT Base Type
public enum BaseType: UInt8 {
    /// Enum
    case enumtype       = 0
    /// sInt8
    case sint8          = 1
    /// UInt8
    case uint8          = 2
    /// SInt16
    case sint16         = 3
    /// UInt16
    case uint16         = 4
    /// SInt32
    case sint32         = 5
    /// UInt32
    case uint32         = 6
    /// string
    ///
    /// Null terminated string UTF-8
    case string         = 7
    /// Float32
    case float32        = 8
    /// Float64
    case float64        = 9
    /// UInt8 zero
    case uint8z         = 10
    /// UInt16 zero
    case uint16z        = 11
    /// UInt32 zero
    case uint32z        = 12
    /// Byte
    case byte           = 13
    /// SInt64
    case sint64         = 14
    /// UInt64
    case uint64         = 15
    /// UInt64 zero
    case uint64z        = 16

    /// Unknown
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
