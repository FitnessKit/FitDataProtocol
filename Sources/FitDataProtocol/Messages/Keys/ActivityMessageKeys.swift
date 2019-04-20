//
//  ActivityMessageKeys.swift
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
extension ActivityMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp          = 253

        /// Total Timer Time
        case totalTimerTime     = 0
        /// Number of Sessions
        case numberOfSessions   = 1
        /// Activity Type
        case activityType       = 2
        /// Event
        case event              = 3
        /// Event Type
        case eventType          = 4
        /// Local Timestamp
        case localTimestamp     = 5
        /// Event Group
        case eventGroup         = 6
    }
}

extension ActivityMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    /// Key Base Resolution
    var resolution: Resolution { return self.baseData.resolution }
    
    /// Key Base Data
    var baseData: BaseData {
        switch self {
        case .timestamp:
            // 1 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .totalTimerTime:
            // 1000 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .numberOfSessions:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .activityType:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .event:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .eventType:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .localTimestamp:
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .eventGroup:
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension ActivityMessage.FitCodingKeys: KeyedEncoder {}

// Encoding
internal extension ActivityMessage.FitCodingKeys {

    func encodeKeyed(value: Activity) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}

// Event Encoding
extension ActivityMessage.FitCodingKeys: KeyedEncoderEvent {}

// Field Definitions
extension ActivityMessage.FitCodingKeys: KeyedFieldDefintion {

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
