//
//  RecordHeader.swift
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

internal struct RecordHeader {

    private(set) var localMessageType: UInt8

    private(set) var isDataMessage: Bool

    private(set) var developerData: Bool

    internal var normalHeader: UInt8 {
        var value: UInt8 = localMessageType

        let datamsg = isDataMessage == true ? 0 : 1

        value |= UInt8(datamsg) << 6
        value |= developerData.uint8Value << 5

        return UInt8(value)
    }

    internal init(localMessageType: UInt8, isDataMessage: Bool, developerData: Bool = false) {
        self.localMessageType = min(15, localMessageType)
        self.isDataMessage = isDataMessage
        self.developerData = developerData
    }

}

internal extension RecordHeader {

    /// Decodes the Record Header
    ///
    /// - Parameters:
    ///   - decoder: DataDecoder
    ///   - data: Fitfile Data
    /// - Returns: RecordHeader
    static func decode(decoder: inout DecodeData, data: Data) -> RecordHeader {

        let head = decoder.decodeUInt8(data)

        var isDataMessage = false
        var developerData = false
        var messageType: UInt8 = 0

        if (head & 0x80 == 0x80) {

            messageType = head & 0x60 >> 5

        } else {

            if (head & 0x40 == 0x40) {

                if head & 0x20 == 0x20 {
                    developerData = true
                }

            } else {
                isDataMessage = true
            }

            messageType = head & 0xF
        }

        return RecordHeader(localMessageType: messageType,
                            isDataMessage: isDataMessage,
                            developerData: developerData)
    }
}
