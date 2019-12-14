//
//  DeveloperFieldDefinition.swift
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

public protocol DeveloperDataBox {
    
    /// Field Name
    var fieldName: String? { get }

    /// Units
    var units: String? { get }
}

/// Developer Data Value
public struct DeveloperDataValue<Value>: DeveloperDataBox {
    
    /// Field Name
    private(set) public var fieldName: String?

    /// Units
    private(set) public var units: String?

    /// Value
    private(set) var value: Value?
    
}

internal struct DeveloperDataType {
    
    /// Architecture
    private(set) var architecture: Endian

    /// Field Number
    private(set) var fieldNumber: UInt8

    /// Developer Data Index
    private(set) var dataIndex: UInt8

    /// Developer Data
    private(set) var data: Data
}

internal struct DeveloperFieldDefinition {

    private(set) var fieldNumber: UInt8

    private(set) var size: UInt8

    private(set) var dataIndex: UInt8
}

internal extension DeveloperFieldDefinition {

    static func decode(decoder: inout DecodeData, data: Data) -> Result<DeveloperFieldDefinition, FitDecodingError>  {

        let fieldNumber = decoder.decodeUInt8(data)
        let size = decoder.decodeUInt8(data)
        let dataIndex = decoder.decodeUInt8(data)

        let devField = DeveloperFieldDefinition(fieldNumber: fieldNumber,
                                                size: size,
                                                dataIndex: dataIndex)
        return.success(devField)
    }

}

extension DeveloperFieldDefinition: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    internal static func == (lhs: DeveloperFieldDefinition, rhs: DeveloperFieldDefinition) -> Bool {
        return (lhs.fieldNumber == rhs.fieldNumber) &&
            (lhs.size == rhs.size) &&
            (lhs.dataIndex == rhs.dataIndex)
    }
}
