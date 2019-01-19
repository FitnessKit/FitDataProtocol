//
//  EventMessageKeys.swift
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
extension EventMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp          = 253

        /// Event
        case event              = 0
        /// Event Type
        case eventType          = 1
        /// Data 16
        case data16             = 2
        /// Data 32
        case data32             = 3
        /// Event Group
        case eventGroup         = 4
        /// Score
        case score              = 7
        /// Opponent Score
        case opponentScore      = 8
        /// Front Gear Number
        case frontGearNumber    = 9
        /// Front Gear
        case frontGear          = 10
        /// Rear Gear Number
        case rearGearNumber     = 11
        /// Rear Gear
        case rearGear           = 12
    }
}

public extension EventMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .timestamp:
            return .uint32

        case .event:
            return .enumtype
        case .eventType:
            return .enumtype
        case .data16:
            return .uint16
        case .data32:
            return .uint32
        case .eventGroup:
            return .uint8
        case .score:
            return .uint16
        case .opponentScore:
            return .uint16
        case .frontGearNumber:
            return .uint8z
        case .frontGear:
            return .uint8z
        case .rearGearNumber:
            return .uint8z
        case .rearGear:
            return .uint8z
        }
    }
}

internal extension EventMessage.FitCodingKeys {

    /// Key Base Type Resolution
    var resolution: Resolution {
        switch self {
        case .timestamp:
            return Resolution(scale: 1.0, offset: 0.0)

        case .event:
            return Resolution(scale: 1.0, offset: 0.0)
        case .eventType:
            return Resolution(scale: 1.0, offset: 0.0)
        case .data16:
            return Resolution(scale: 1.0, offset: 0.0)
        case .data32:
            return Resolution(scale: 1.0, offset: 0.0)
        case .eventGroup:
            return Resolution(scale: 1.0, offset: 0.0)
        case .score:
            return Resolution(scale: 1.0, offset: 0.0)
        case .opponentScore:
            return Resolution(scale: 1.0, offset: 0.0)
        case .frontGearNumber:
            return Resolution(scale: 1.0, offset: 0.0)
        case .frontGear:
            return Resolution(scale: 1.0, offset: 0.0)
        case .rearGearNumber:
            return Resolution(scale: 1.0, offset: 0.0)
        case .rearGear:
            return Resolution(scale: 1.0, offset: 0.0)
        }
    }
}

// Encoding
extension EventMessage.FitCodingKeys: EncodeKeyed {

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

internal extension EventMessage.FitCodingKeys {

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
