//
//  WeightScaleMessageKeys.swift
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
import AntMessageProtocol
import FitnessUnits

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension WeightScaleMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp              = 253

        /// Weight
        case weight                 = 0
        /// Percent Fat
        case percentFat             = 1
        /// Percent Hyration
        case percentHydration       = 2
        /// Visceral Fat Mass
        case visceralFatMass        = 3
        /// Bone Mass
        case boneMass               = 4
        /// Muscle Mass
        case muscleMass             = 5
        /// Basal METs
        case basalMet               = 7
        /// Physique Rating
        case physiqueRating         = 8
        /// Active METs
        case activeMet              = 9
        /// Metabolic Age
        case metabolicAge           = 10
        /// Visceral Fat Rating
        case visceralFatRating      = 11
        /// User Profile Index
        case userProfileIndex       = 12
    }
}

public extension WeightScaleMessage.FitCodingKeys {
    /// Key Base Type
    public var baseType: BaseType { return self.baseData.type }
}

internal extension WeightScaleMessage.FitCodingKeys {

    /// Key Base Resolution
    internal var resolution: Resolution { return self.baseData.resolution }

    /// Key Base Data
    internal var baseData: BaseData {
        switch self {
        case .timestamp:
            // 1 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))

        case .weight:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .percentFat:
            // 100 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .percentHydration:
            // 100 * % + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .visceralFatMass:
            // 100 * kg + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .boneMass:
            // 100 * kg + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .muscleMass:
            // 100 * kg + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .basalMet:
            // 4 * kcal/day + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 4.0, offset: 0.0))
        case .physiqueRating:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .activeMet:
            // 4 * kcal/day + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 4.0, offset: 0.0))
        case .metabolicAge:
            /// 1 * years
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .visceralFatRating:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .userProfileIndex:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

// Encoding
extension WeightScaleMessage.FitCodingKeys: KeyedEncoder {

    internal func encodeKeyed(value: Bool) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt8) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt8>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt16) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt16>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt32) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt32>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: Double) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
}

extension WeightScaleMessage.FitCodingKeys: KeyedFieldDefintion {

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
