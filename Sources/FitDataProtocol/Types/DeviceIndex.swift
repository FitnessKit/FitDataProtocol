//
//  DeviceIndex.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/4/18.
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
import FitnessUnits

/// Device Index
public struct DeviceIndex {

    /// Is File Creator
    public let isFileCreator: Bool

    /// Validity of Index
    public let isInvalid: Bool

    /// Index
    public let index: UInt8

    public init(isCreator: Bool) {
        self.isFileCreator = true
        self.isInvalid = false
        self.index = 0
    }

    public init(index: UInt8) {
        self.index = index

        if index == 0 {
            self.isFileCreator = true
        } else {
            self.isFileCreator = false
        }

        if index == 255 {
            self.isInvalid = true
        } else {
            self.isInvalid = false
        }
    }
}

internal extension DeviceIndex {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> DeviceIndex? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return DeviceIndex(index: value)
        } else {

            if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                return DeviceIndex(index: value.value)
            } else {
                return nil
            }
        }
    }
}
