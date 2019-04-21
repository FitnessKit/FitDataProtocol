//
//  MessageData.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/19.
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

/// FIT Message Data Wrapper
///
/// Typically used for Encoding
internal class MessageData {
    
    /// Holder of the Message Data
    private(set) public var message: Data
    
    init() {
        self.message = Data()
    }
}

internal extension MessageData {
    
    /// Checks if we should Append data if Result has not errors
    ///
    /// - Parameter value: Result<Data, FitEncodingError>
    /// - Returns: FitEncodingError if Result was in Error
    func shouldAppend(_ value: Result<Data, FitEncodingError>) -> FitEncodingError? {
        switch value {
        case .success(let valueData):
            message.append(valueData)
            return nil
        case .failure(let error):
            return error
        }
    }
}

internal extension MessageData {
    
    func append(_ other: UInt8) {
        message.append(other)
    }

    func append(_ other: Data) {
        message.append(other)
    }
    
    /// Append a buffer of bytes to the data.
    ///
    /// - parameter buffer: The buffer of bytes to append. The size is calculated from `SourceType` and `buffer.count`.
    func append<SourceType>(_ buffer: UnsafeBufferPointer<SourceType>) {
        message.append(buffer)
    }
    
    func append(contentsOf bytes: [UInt8]) {
        message.append(contentsOf: bytes)
    }
    
    /// Adds the elements of a sequence or collection to the end of this
    /// collection.
    ///
    /// The collection being appended to allocates any additional necessary
    /// storage to hold the new elements.
    ///
    /// The following example appends the elements of a `Range<Int>` instance to
    /// an array of integers:
    ///
    ///     var numbers = [1, 2, 3, 4, 5]
    ///     numbers.append(contentsOf: 10...15)
    ///     print(numbers)
    ///     // Prints "[1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]"
    ///
    /// - Parameter newElements: The elements to append to the collection.
    ///
    /// - Complexity: O(*m*), where *m* is the length of `newElements`.
    func append<S>(contentsOf elements: S) where S : Sequence, S.Element == Data.Element {
        message.append(contentsOf: elements)
    }

}
