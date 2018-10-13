//
//  EventType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/20/18.
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

/// Event Types
///
public enum EventType: UInt8 {
    /// Start
    case start          = 0
    /// Stop
    case stop           = 1
    /// Consecutive
    @available(*, deprecated, message: "no longer available ...")
    case consecutive    = 2
    /// Marker
    case marker         = 3
    /// Stop All
    case stopAll        = 4
    /// Begin
    @available(*, deprecated, message: "no longer available ...")
    case begin          = 5
    /// End
    @available(*, deprecated, message: "no longer available ...")
    case end            = 6
    /// End All
    @available(*, deprecated, message: "no longer available ...")
    case endAll         = 7
    /// Stop Disable
    case stopDisable    = 8
    /// Stop Disable All
    case stopDisableAll = 9
    /// Invalid
    case invalid        = 255
}

internal extension EventType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> EventType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if UInt64(value) != definition.baseType.invalid {
            return EventType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return EventType.invalid
            }
        }

    }
}
