//
//  SourceType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/20/18.
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

/// FIT Source Type
public enum SourceType: UInt8 {
    /// ANT Public
    case ant            = 0
    /// ANT+
    case antPlus        = 1
    /// Bluetooth
    case bluetooth      = 2
    /// BLE
    case ble            = 3
    /// WIFI
    case wifi           = 4
    /// Local
    case local          = 5
    /// Invalid
    case invalid        = 255
}

internal extension SourceType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> SourceType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return SourceType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return SourceType.invalid
            }
        }
    }
}

public extension SourceType {

    /// String Value
    public var stringValue: String {
        switch self {
        case .ant:
            return "ANT"
        case .antPlus:
            return "ANT+"
        case .bluetooth:
            return "Bluetooth"
        case .ble:
            return "BLE"
        case .wifi:
            return "WIFI"
        case .local:
            return "Local"
        default:
            return "Invalid"
        }
    }
}
