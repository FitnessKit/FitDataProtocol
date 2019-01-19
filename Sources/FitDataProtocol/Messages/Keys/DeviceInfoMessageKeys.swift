//
//  DeviceInfoMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/18/18.
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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension DeviceInfoMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp          = 253

        /// Device Index
        case deviceIndex        = 0
        /// Device Type
        case deviceType         = 1
        /// Manufacturer
        case manufacturer       = 2
        /// Serial Number
        case serialNumber       = 3
        /// Product
        case product            = 4
        /// Software Version
        case softwareVersion    = 5
        /// Hardware Version
        case hardwareVersion    = 6
        /// Cumulative Operating Time
        case cumulativeOpTime   = 7
        /// Battery Voltage
        case batteryVoltage     = 10
        /// Battery Status
        case batteryStatus      = 11
        /// Sensor Position
        case sensorPosition     = 18
        /// Description
        case description        = 19
        /// Transmission Type
        case transmissionType   = 20
        /// Device Number
        case deviceNumber       = 21
        /// ANT Network
        case antNetwork         = 22
        /// Source Type
        case sourcetype         = 25
        /// Product Name
        case productName        = 27
    }
}

public extension DeviceInfoMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .timestamp:
            return .uint32

        case .deviceIndex:
            return .uint8
        case .deviceType:
            return .uint8
        case .manufacturer:
            return .uint16
        case .serialNumber:
            return .uint32z
        case .product:
            return .uint16
        case .softwareVersion:
            return .uint16
        case .hardwareVersion:
            return .uint8
        case .cumulativeOpTime:
            return .uint32
        case .batteryVoltage:
            return .uint16
        case .batteryStatus:
            return .uint8
        case .sensorPosition:
            return .enumtype
        case .description:
            return .string
        case .transmissionType:
            return .uint8z
        case .deviceNumber:
            return .uint16z
        case .antNetwork:
            return .enumtype
        case .sourcetype:
            return .enumtype
        case .productName:
            return .string //20
        }
    }
}

internal extension DeviceInfoMessage.FitCodingKeys {

    /// Key Base Type Resolution
    var resolution: Resolution {
        switch self {
        case .timestamp:
            return Resolution(scale: 1.0, offset: 0.0)
            
        case .deviceIndex:
            return Resolution(scale: 1.0, offset: 0.0)
        case .deviceType:
            return Resolution(scale: 1.0, offset: 0.0)
        case .manufacturer:
            return Resolution(scale: 1.0, offset: 0.0)
        case .serialNumber:
            return Resolution(scale: 1.0, offset: 0.0)
        case .product:
            return Resolution(scale: 1.0, offset: 0.0)
        case .softwareVersion:
            return Resolution(scale: 1.0, offset: 0.0)
        case .hardwareVersion:
            return Resolution(scale: 1.0, offset: 0.0)
        case .cumulativeOpTime:
            // 1 * s + 0
            return Resolution(scale: 1.0, offset: 0.0)
        case .batteryVoltage:
            // 256 * V + 0
            return Resolution(scale: 256.0, offset: 0.0)
        case .batteryStatus:
            return Resolution(scale: 1.0, offset: 0.0)
        case .sensorPosition:
            return Resolution(scale: 1.0, offset: 0.0)
        case .description:
            return Resolution(scale: 1.0, offset: 0.0)
        case .transmissionType:
            return Resolution(scale: 1.0, offset: 0.0)
        case .deviceNumber:
            return Resolution(scale: 1.0, offset: 0.0)
        case .antNetwork:
            return Resolution(scale: 1.0, offset: 0.0)
        case .sourcetype:
            return Resolution(scale: 1.0, offset: 0.0)
        case .productName:
            return Resolution(scale: 1.0, offset: 0.0)
        }
    }
}

// Encoding
extension DeviceInfoMessage.FitCodingKeys: EncodeKeyed {

    internal func encodeKeyed(value: Bool) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt8) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt16) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt32) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: Double) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
}

internal extension DeviceInfoMessage.FitCodingKeys {

    /// Create a Field Definition Message From the Key
    ///
    /// - Parameter size: Data Size, if nil will use the keys predefined size
    /// - Returns: FieldDefinition
    internal func fieldDefinition(size: UInt8) -> FieldDefinition {

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: UInt8(self.rawValue),
                                              size: size,
                                              endianAbility: self.baseType.hasEndian,
                                              baseType: self.baseType)

        return fieldDefinition
    }

    /// Create a Field Definition Message From the Key
    ///
    /// - Returns: FieldDefinition
    internal func fieldDefinition() -> FieldDefinition {

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: UInt8(self.rawValue),
                                              size: self.baseType.dataSize,
                                              endianAbility: self.baseType.hasEndian,
                                              baseType: self.baseType)

        return fieldDefinition
    }
}
