//
//  TotalsMessageKeys.swift
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
extension TotalsMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Message Index
        case messageIndex       = 254
        /// Timestamp
        case timestamp          = 253

        /// Total Timer Time
        case timerTime          = 0
        /// Total Distance
        case distance           = 1
        /// Total Calories
        case calories           = 2
        /// Sport
        case sport              = 3
        /// Elapsed Time
        case elapsedTime        = 4
        /// Sessions
        case sessions           = 5
        /// Active Time
        case activeTime         = 6
    }
}

public extension TotalsMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .messageIndex:
            return .uint16
        case .timestamp:
            return .uint32

        case .timerTime:
            return .uint32
        case .distance:
            return .uint32
        case .calories:
            return .uint32
        case .sport:
            return .enumtype
        case .elapsedTime:
            return .uint32
        case .sessions:
            return .uint16
        case .activeTime:
            return .uint32
        }
    }

}

//// Encoding
//internal extension TotalsMessage.FitCodingKeys {
//
//    internal func encodeKeyed(value: Sport) throws -> Data {
//        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
//    }
//
//    internal func encodeKeyed(value: SubSport) throws -> Data {
//        return try self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
//    }
//}

internal extension TotalsMessage.FitCodingKeys {

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
