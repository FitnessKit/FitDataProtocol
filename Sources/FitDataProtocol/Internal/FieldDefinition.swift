//
//  FieldDefinition.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
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
import DataDecoder

internal struct FieldDefinition {

    private(set) var fieldDefinitionNumber: UInt8

    private(set) var size: UInt8

    private(set) var endianAbility: Bool

    private(set) var baseType: BaseType

    internal init(fieldDefinitionNumber: UInt8, size: UInt8, endianAbility: Bool, baseType: BaseType) {
        self.fieldDefinitionNumber = fieldDefinitionNumber
        self.size = size
        self.endianAbility = endianAbility
        self.baseType = baseType
    }

    internal init(fieldDefinitionNumber: UInt8, size: UInt8, type: BaseTypeData) {
        self.fieldDefinitionNumber = fieldDefinitionNumber
        self.size = size
        self.endianAbility = type.type.hasEndian
        self.baseType = type.type
    }

    internal init(fieldDefinitionNumber: UInt8, type: BaseTypeData) {
        self.fieldDefinitionNumber = fieldDefinitionNumber
        self.size = type.type.dataSize
        self.endianAbility = type.type.hasEndian
        self.baseType = type.type
    }
}

internal extension FieldDefinition {

    /// Encodes the FieldDefinition into Data
    ///
    /// - Returns: Data representation
    func encode() -> Data {
        var msgData = Data()

        msgData.append(fieldDefinitionNumber)
        msgData.append(size)

        var value: UInt8 = baseType.rawValue
        value |= endianAbility.uint8Value << 7

        msgData.append(value)

        return msgData
    }
}

extension FieldDefinition: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    internal static func == (lhs: FieldDefinition, rhs: FieldDefinition) -> Bool {
        return (lhs.fieldDefinitionNumber == rhs.fieldDefinitionNumber) &&
            (lhs.size == rhs.size) &&
            (lhs.endianAbility == rhs.endianAbility) &&
            (lhs.baseType == rhs.baseType)
    }
}

internal extension FieldDefinition {

    static func decode(decoder: inout DecodeData, data: Data) -> Result<FieldDefinition, FitDecodingError> {

        let messageNumber = decoder.decodeUInt8(data)
        let size = decoder.decodeUInt8(data)
        let baseType = decoder.decodeUInt8(data)

        let endian = (baseType & 0x80 == 0x80)
        let baseNumber = BaseType(rawValue: (baseType & 0x1F)) ?? .unknown

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: messageNumber,
                                              size: size,
                                              endianAbility: endian,
                                              baseType: baseNumber)

        return.success(fieldDefinition)
    }
}
