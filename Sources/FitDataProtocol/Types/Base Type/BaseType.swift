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

/// Defines Base Type Data
public struct BaseTypeData {

    /// Base Type
    public var type: BaseType

    /// Resolution
    public var resolution: Resolution
}

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

extension BaseType: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        var encode = Data()

        var value: UInt8 = self.rawValue
        value |= self.hasEndian.uint8Value << 7

        encode.append(Data(from: value.littleEndian))

        return encode
    }
    
    /// Decode FIT Field
    ///
    /// - Parameters:
    ///   - type: Type of Field
    ///   - data: Data to Decode
    ///   - base: BaseTypeData
    ///   - arch: Endian
    /// - Returns: Decoded Value
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return BaseType(rawValue: (value & 0x1F)) as? T
        }
        
        return nil
    }
}

internal extension BaseType {

    func encodedResolution<T: BinaryInteger>(value: T, resolution: Resolution) -> Result<Data, FitEncodingError> {
        return encodedResolution(value: Double(value), resolution: resolution)
    }

    func encodedResolution<T: BinaryFloatingPoint>(value: T, resolution: Resolution) -> Result<Data, FitEncodingError> {
        return encodedResolution(value: Double(value), resolution: resolution)
    }

    func encodedResolution(value: Bool, resolution: Resolution) -> Result<Data, FitEncodingError> {
        return encodedResolution(value: Double(value.uint8Value), resolution: resolution)
    }

    func encodedResolution(value: UInt8, resolution: Resolution) -> Result<Data, FitEncodingError> {
        return encodedResolution(value: Double(value), resolution: resolution)
    }

    func encodedResolution(value: UInt16, resolution: Resolution) -> Result<Data, FitEncodingError> {
        return encodedResolution(value: Double(value), resolution: resolution)
    }

    func encodedResolution(value: UInt32, resolution: Resolution) -> Result<Data, FitEncodingError> {
        return encodedResolution(value: Double(value), resolution: resolution)
    }

    /// Encode Value into data with resolution to a BaseType Value
    ///
    /// - Parameters:
    ///   - value: Value to apply Resolution to
    ///   - resolution: Resolution
    /// - Returns: Data Result
    func encodedResolution(value: Double, resolution: Resolution) -> Result<Data, FitEncodingError> {
        switch self {
        case .enumtype, .uint8, .uint8z, .byte:

            let new = value.resolution(type: UInt8.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .sint8:
            let new = value.resolution(type: Int8.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .sint16:
            let new = value.resolution(type: Int16.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .uint16, .uint16z:
            let new = value.resolution(type: UInt16.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .sint32:
            let new = value.resolution(type: Int32.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .uint32, .uint32z, .float32:
            let new = value.resolution(type: UInt32.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .string:
            fatalError("Can not Apply Resolution to string")

        case .sint64:
            let new = value.resolution(type: Int64.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .uint64, .uint64z, .float64:
            let new = value.resolution(type: UInt64.self, ResolutionDirection.adding, resolution: resolution)
            let data = Data(from: new.littleEndian)
            return.success(data)

        case .unknown:
            return.failure(FitEncodingError.unknownBaseType)
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

        switch base {
        case .enumtype, .uint8, .byte, .unknown:
            return self != Data(from: UInt8.max)
        case .sint8:
            return self != Data(from: Int8.max)
        case .sint16:
            return self != Data(from: Int16.max)
        case .uint16:
            return self != Data(from: UInt16.max)
        case .sint32:
            return self != Data(from: Int32.max)
        case .uint32, .float32:
            return self != Data(from: UInt32.max)
        case .string, .uint8z:
            return self != Data(from: UInt8.min)
        case .float64, .uint64:
            return self.count >= base.dataSize
        case .uint16z:
            return self != Data(from: UInt16.min)
        case .uint32z:
            return self != Data(from: UInt32.min)
        case .sint64:
            return self != Data(from: UInt64.max)
        case .uint64z:
            return self != Data(from: UInt64.min)
        }
    }
}

internal extension BinaryFloatingPoint {

    func isValidForBaseType(_ base: BaseType) -> Bool {

        switch base {
        case .enumtype, .uint8, .byte, .unknown:
            return Double(self) != Double(0xFF)
        case .sint8:
            return Double(self) != Double(0x7F)
        case .sint16:
            return Double(self) != Double(0x7FFF)
        case .uint16:
            return Double(self) != Double(0xFFFF)
        case .sint32:
            return Double(self) != Double(0x7FFFFFFF)
        case .uint32, .float32:
            return Double(self) != Double(0xFFFFFFFF)
        case .string, .uint8z:
            return Double(self) != Double(0x00)
        case .float64, .uint64:
            return Double(self) != Double(UInt64.max)
        case .uint16z:
            return Double(self) != Double(0x0000)
        case .uint32z:
            return Double(self) != Double(0x00000000)
        case .sint64:
            return Double(self) != Double(0x7FFFFFFFFFFFFFFF)
        case .uint64z:
            return Double(self) != Double(0x0000000000000000)
        }
    }
}
