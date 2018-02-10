//
//  DataExtension.swift
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


extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    /// Smartly Decodes String
    var smartString: String? {
        var stringvalue: String?

        if self[(self.count - 1)] == 0 {
            stringvalue = String(bytes: self[0..<(self.count - 1)], encoding: .utf8)
        } else {
            stringvalue = String(bytes: self[0..<(self.count - 1)], encoding: .ascii)
        }

        return stringvalue
    }

    /// Provide Segments of the Data
    ///
    /// - Parameters:
    ///   - size: Size of the Segments
    /// - Returns: Array of Segmented Data
    func segment(size _size: Int, offset: Int = 0) -> [Data] {

        var messages: [Data] = [Data]()

        let myData = self
        let length = self.count
        var internalOffset = offset

        repeat {

            let thisChuckSize = length - internalOffset > _size ? _size : length - internalOffset

            let chunk = myData.subdata(in: Range(internalOffset..<(internalOffset + thisChuckSize)))

            internalOffset = internalOffset + thisChuckSize

            messages.append(chunk)

        } while (internalOffset < length)

        return messages
    }

}
