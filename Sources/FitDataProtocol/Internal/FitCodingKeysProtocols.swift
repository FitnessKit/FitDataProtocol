//
//  FitCodingKeysProtocols.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/19/19.
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

/// Protocol for Encoding FitMessage keys
internal protocol KeyedEncoder {

    func encodeKeyed(value: Bool) throws -> Data

    func encodeKeyed(value: UInt8) throws -> Data
    
    func encodeKeyed(value: ValidatedBinaryInteger<UInt8>) throws -> Data

    func encodeKeyed(value: UInt16) throws -> Data

    func encodeKeyed(value: ValidatedBinaryInteger<UInt16>) throws -> Data

    func encodeKeyed(value: UInt32) throws -> Data

    func encodeKeyed(value: ValidatedBinaryInteger<UInt32>) throws -> Data

    func encodeKeyed(value: Double) throws -> Data
}

/// Protocol for Creating Field Definition Message from FitMessage keys
internal protocol KeyedFieldDefintion {
    /// Create a Field Definition Message From the Key
    ///
    /// - Parameter size: Data Size, if nil will use the keys predefined size
    /// - Returns: FieldDefinition
    func fieldDefinition(size: UInt8) -> FieldDefinition

    /// Create a Field Definition Message From the Key
    ///
    /// - Returns: FieldDefinition
    func fieldDefinition() -> FieldDefinition
}
