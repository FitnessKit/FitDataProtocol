//
//  FieldDescriptionMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 10/26/19.
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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension FieldDescriptionMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Data Index
        case dataIndex          = 0
        /// Definition Number
        case definitionNumber   = 1
        /// Base Type ID
        case baseTypeId         = 2
        /// Field Name
        case fieldName          = 3
        /// Scale
        case scale              = 6
        /// Offset
        case offset             = 7
        /// Units
        case units              = 8
        /// Base Units
        case baseUnits          = 13
        /// Message Numbrer
        case messageNumber      = 14
        /// Field Number
        case fieldNumber        = 15
    }
}

extension FieldDescriptionMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .dataIndex:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .definitionNumber:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .baseTypeId:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .fieldName:
            // 64
            return BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .scale:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .offset:
            return BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .units:
            // 16
            return BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .baseUnits:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .messageNumber:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .fieldNumber:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension FieldDescriptionMessage.FitCodingKeys: KeyedEncoder {}

// FitFile Encoding
extension FieldDescriptionMessage.FitCodingKeys: KeyedEncoderFitFile {}

extension FieldDescriptionMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
