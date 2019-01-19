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
import FitnessUnits
import DataDecoder

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

    func encodedResolution(value: Bool, resolution: Resolution) throws -> Data {
        return try encodedResolution(value: Double(value.uint8Value), resolution: resolution)
    }

    func encodedResolution(value: UInt8, resolution: Resolution) throws -> Data {
        return try encodedResolution(value: Double(value), resolution: resolution)
    }

    func encodedResolution(value: UInt16, resolution: Resolution) throws -> Data {
        return try encodedResolution(value: Double(value), resolution: resolution)
    }

    func encodedResolution(value: UInt32, resolution: Resolution) throws -> Data {
        return try encodedResolution(value: Double(value), resolution: resolution)
    }

    /// Encode Value into data with resolution to a BaseType Value
    ///
    /// - Parameters:
    ///   - value: Value to apply Resolution to
    ///   - resolution: Resolution
    /// - Returns: Data
    /// - Throws: FitError
    func encodedResolution(value: Double, resolution: Resolution) throws -> Data {
        switch self {
        case .enumtype, .uint8, .uint8z, .byte:
            let new = value.resolutionUInt8(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .sint8:
            let new = value.resolutionInt8(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .sint16:
            let new = value.resolutionInt16(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .uint16, .uint16z:
            let new = value.resolutionUInt16(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .sint32:
            let new = value.resolutionInt32(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .uint32, .uint32z, .float32:
            let new = value.resolutionUInt32(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .string:
            fatalError("Can not Apply Resolution to string")

        case .sint64:
            let new = value.resolutionInt64(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .uint64, .uint64z, .float64:
            let new = value.resolutionUInt64(resolution.scale, offset: resolution.offset)
            let data = Data(from: new.littleEndian)
            return data

        case .unknown:
            throw FitError(.encodeError(msg: "Unknown BaseType for Encoding"))
        }
    }
}

internal extension BaseType {

    var hasEndian: Bool {
        switch self {
        case .enumtype:
            return false
        case .sint8:
            return false
        case .uint8:
            return false
        case .sint16:
            return true
        case .uint16:
            return true
        case .sint32:
            return true
        case .uint32:
            return true
        case .string:
            return false
        case .float32:
            return true
        case .float64:
            return true
        case .uint8z:
            return false
        case .uint16z:
            return true
        case .uint32z:
            return true
        case .byte:
            return false
        case .sint64:
            return true
        case .uint64:
            return true
        case .uint64z:
            return true
        case .unknown:
            return false
        }
    }

    var dataSize: UInt8 {
        switch self {
        case .enumtype:
            return 1
        case .sint8:
            return 1
        case .uint8:
            return 1
        case .sint16:
            return 2
        case .uint16:
            return 2
        case .sint32:
            return 4
        case .uint32:
            return 4
        case .string:
            return 1
        case .float32:
            return 4
        case .float64:
            return 8
        case .uint8z:
            return 1
        case .uint16z:
            return 2
        case .uint32z:
            return 4
        case .byte:
            return 1
        case .sint64:
            return 8
        case .uint64:
            return 8
        case .uint64z:
            return 8
        case .unknown:
            return 1
        }
    }

}

// MARK: - Extensions

// MARK: BinaryInteger
internal extension BinaryInteger {

    func isValidForBaseType(_ base: BaseType) -> Bool {
        switch base {
        case .enumtype:
            return self != 0xFF
        case .sint8:
            return self != 0x7F
        case .uint8:
            return self != 0xFF
        case .sint16:
            return self != 0x7FFF
        case .uint16:
            return self != 0xFFFF
        case .sint32:
            return self != Int32.max
        case .uint32:
            return self != UInt32.max
        case .string:
            return self != 0x00
        case .float32:
            return self != UInt32.max
        case .float64:
            return self != UInt64.max
        case .uint8z:
            return self != 0x00
        case .uint16z:
            return self != 0x0000
        case .uint32z:
            return self != 0x00000000
        case .byte:
            return self != 0xFF
        case .sint64:
            return self != Int64.max
        case .uint64:
            return self != UInt64.max
        case .uint64z:
            return self != 0x0000000000000000
        case .unknown:
            return self != 0xFF
        }
    }
}

internal extension Data {

    func isValidForBaseType(_ base: BaseType) -> Bool {

        if self.count >= base.dataSize {
            return true
        }

        return false
    }
}

internal extension ValidatedMeasurement {

    static func invalidValue<T>(_ base: BaseType, dataStrategy: FitFileDecoder.DataDecodingStrategy, unit: T) -> ValidatedMeasurement<T>? {

        switch dataStrategy {
        case .nil:
            return nil
        case .useInvalid:
            switch base {
            case .enumtype:
                return ValidatedMeasurement<T>(value: Double(0xFF), valid: false, unit: unit)
            case .sint8:
                return ValidatedMeasurement<T>(value: Double(0x7F), valid: false, unit: unit)
            case .uint8:
                return ValidatedMeasurement<T>(value: Double(0xFF), valid: false, unit: unit)
            case .sint16:
                return ValidatedMeasurement<T>(value: Double(0x7FFF), valid: false, unit: unit)
            case .uint16:
                return ValidatedMeasurement<T>(value: Double(0xFFFF), valid: false, unit: unit)
            case .sint32:
                return ValidatedMeasurement<T>(value: Double(Int32.max), valid: false, unit: unit)
            case .uint32:
                return ValidatedMeasurement<T>(value: Double(UInt32.max), valid: false, unit: unit)
            case .string:
                return ValidatedMeasurement<T>(value: Double(0x00), valid: false, unit: unit)
            case .float32:
                return ValidatedMeasurement<T>(value: Double(UInt32.max), valid: false, unit: unit)
            case .float64:
                return ValidatedMeasurement<T>(value: Double(UInt64.max), valid: false, unit: unit)
            case .uint8z:
                return ValidatedMeasurement<T>(value: Double(0x00), valid: false, unit: unit)
            case .uint16z:
                return ValidatedMeasurement<T>(value: Double(0x0000), valid: false, unit: unit)
            case .uint32z:
                return ValidatedMeasurement<T>(value: Double(0x00000000), valid: false, unit: unit)
            case .byte:
                return ValidatedMeasurement<T>(value: Double(0xFF), valid: false, unit: unit)
            case .sint64:
                return ValidatedMeasurement<T>(value: Double(Int64.max), valid: false, unit: unit)
            case .uint64:
                return ValidatedMeasurement<T>(value: Double(UInt64.max), valid: false, unit: unit)
            case .uint64z:
                return ValidatedMeasurement<T>(value: Double(0x0000000000000000), valid: false, unit: unit)
            case .unknown:
                return ValidatedMeasurement<T>(value: Double(0xFF), valid: false, unit: unit)
            }
        }
    }
}


// MARK: ValidatedBinaryInteger
internal extension ValidatedBinaryInteger {


    static func validated<T>(value: T, definition: FieldDefinition, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> ValidatedBinaryInteger<T>? where T: BinaryInteger {

        if value.isValidForBaseType(definition.baseType) {
            return ValidatedBinaryInteger<T>(value: value, valid: true)
        } else {
            return ValidatedBinaryInteger<T>.invalidValue(definition.baseType, dataStrategy: dataStrategy)
        }

    }

    /// Invalid ValidatedBinaryInteger based off BaseType
    ///
    /// - Parameters:
    ///   - base: BaseType
    ///   - dataStrategy: FitFileDecoder.DataDecodingStrategy
    /// - Returns: ValidatedBinaryInteger?
    static func invalidValue(_ base: BaseType, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> ValidatedBinaryInteger? {

        switch dataStrategy {
        case .nil:
            return nil
        case .useInvalid:
            switch base {
            case .enumtype:
                return ValidatedBinaryInteger(value: 0xFF, valid: false)
            case .sint8:
                return ValidatedBinaryInteger(value: 0x7F, valid: false)
            case .uint8:
                return ValidatedBinaryInteger(value: 0xFF, valid: false)
            case .sint16:
                return ValidatedBinaryInteger(value: 0x7FFF, valid: false)
            case .uint16:
                return ValidatedBinaryInteger(value: 0xFFFF, valid: false)
            case .sint32:
                return ValidatedBinaryInteger(value: 0x7FFFFFFF, valid: false)
            case .uint32:
                return ValidatedBinaryInteger(value: 0xFFFFFFFF, valid: false)
            case .string:
                return ValidatedBinaryInteger(value: 0x00, valid: false)
            case .float32:
                return ValidatedBinaryInteger(value: 0xFFFFFFFF, valid: false)
            case .float64:
                return ValidatedBinaryInteger(value: 0xFFFFFFFFFFFFFFFF, valid: false)
            case .uint8z:
                return ValidatedBinaryInteger(value: 0x00, valid: false)
            case .uint16z:
                return ValidatedBinaryInteger(value: 0x0000, valid: false)
            case .uint32z:
                return ValidatedBinaryInteger(value: 0x00000000, valid: false)
            case .byte:
                return ValidatedBinaryInteger(value: 0xFF, valid: false)
            case .sint64:
                return ValidatedBinaryInteger(value: 0x7FFFFFFFFFFFFFFF, valid: false)
            case .uint64:
                return ValidatedBinaryInteger(value: 0xFFFFFFFFFFFFFFFF, valid: false)
            case .uint64z:
                return ValidatedBinaryInteger(value: 0x0000000000000000, valid: false)
            case .unknown:
                return ValidatedBinaryInteger(value: 0xFF, valid: false)
            }
        }

    }

}
