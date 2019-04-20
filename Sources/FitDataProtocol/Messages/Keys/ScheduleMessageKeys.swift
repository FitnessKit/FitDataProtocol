//
//  ScheduleMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/25/18.
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
extension ScheduleMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Manufacturer
        case manufacturer           = 0
        /// Product
        case product                = 1
        /// Serial Number
        case serialNumber           = 2
        /// Time Created
        case timeCreated            = 3
        /// Completed
        case completed              = 4
        /// Schedule Type
        case scheduleType           = 5
        /// Scheduled Time
        case scheduledTime          = 6
    }
}

extension ScheduleMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    /// Key Base Resolution
    var resolution: Resolution { return self.baseData.resolution }
    
    /// Key Base Data
    var baseData: BaseData {
        switch self {
        case .manufacturer:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .product:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .serialNumber:
            return BaseData(type: .uint32z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .timeCreated:
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .completed:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .scheduleType:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .scheduledTime:
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension ScheduleMessage.FitCodingKeys: KeyedEncoder {}

// Encoding
internal extension ScheduleMessage.FitCodingKeys {

    func encodeKeyed(value: ScheduleType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }

}

extension ScheduleMessage.FitCodingKeys: KeyedFieldDefintion {

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
