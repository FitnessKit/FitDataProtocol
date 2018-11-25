//
//  BloodPressureMessageKeys.swift
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
extension BloodPressureMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Systolic Pressure
        case systolicPressure       = 0
        /// Diastolic Pressure
        case diastolicPressure      = 1
        /// Mean Arterial Pressure
        case meanArterialPressure   = 2
        /// Map Sample Mean
        case mapSampleMean          = 3
        /// Map Morning Values
        case mapMorningValues       = 4
        /// Map Evening Values
        case mapEveningValues       = 5
        /// Heart Rate
        case heartRate              = 6
        /// Heart Rate Type
        case heartRateType          = 7
        /// Status
        case status                 = 8
        /// User Profile Index
        case userProfileIndex       = 9

        /// Timestamp
        case timestamp              = 253

    }
}

public extension BloodPressureMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {

        switch self {
        case .systolicPressure:
            return .uint16
        case .diastolicPressure:
            return .uint16
        case .meanArterialPressure:
            return .uint16
        case .mapSampleMean:
            return .uint16
        case .mapMorningValues:
            return .uint16
        case .mapEveningValues:
            return .uint16
        case .heartRate:
            return .uint8
        case .heartRateType:
            return .enumtype
        case .status:
            return .enumtype
        case .userProfileIndex:
            return .uint16
        case .timestamp:
            return .uint32
        }
    }

}

internal extension BloodPressureMessage.FitCodingKeys {

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
