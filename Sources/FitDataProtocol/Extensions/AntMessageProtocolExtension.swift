//
//  AntMessageProtocolExtension.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 11/23/18.
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
import AntMessageProtocol
import DataDecoder


internal extension Sport {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Sport? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return Sport(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return Sport.invalid
            }
        }
    }
}

internal extension SubSport {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> SubSport? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return SubSport(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return SubSport.invalid
            }
        }
    }
}

internal extension DeviceType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> DeviceType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return DeviceType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return DeviceType.unknown
            }
        }
    }
}

internal extension BodyLocation {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> BodyLocation? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return BodyLocation(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return BodyLocation.invalid
            }
        }
    }
}


internal extension NetworkType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> NetworkType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return NetworkType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return NetworkType.invalid
            }
        }
    }
}

internal extension BatteryStatus {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> BatteryStatus? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return BatteryStatus(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return BatteryStatus.invalid
            }
        }
    }
}
