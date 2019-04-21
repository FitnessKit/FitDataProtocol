//
//  Error.swift
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

/// FitDataProtocol Error Reasons
public enum ErrorReasons {
    /// Protocol Version Not Supported
    case protocolVersionNotSupported
    /// Not a Fit File
    case nonFitFile

    /// CRC Value Invalid
    case invalidHeaderCrc
    /// CRC Value Invalid
    case invalidFileCrc

    /// FIT File Conversion Issue
    case fitFileConversion

    /// Generic
    case generic(String)
}

/// FitDataProtocol Error
public struct FitError: Error {

    /// Type of Error
    public let type: ErrorReasons

    /// Create FitError With Error Reason
    ///
    /// - Parameter type: Error Reason
    public init(_ type: ErrorReasons) {
        self.type = type
    }

    /// Create FitError
    ///
    /// - Parameter message: Generic Message Type with Message
    public init(message: String) {
        self.type = .generic(message)
    }
}

/// Errors for FIT File Encoding
public enum FitEncodingError: Error {
    /// No Messages
    case noMessages
    /// Multiple FileIdMessages
    case multipleFileIdMessage
    /// Resulting File is too large
    case tooManyMessages
    /// FIT Message Not supported
    case notSupported
    /// Property Size Issue
    case properySize(String)
    /// No Properties available to Encdode
    case noProperties(String)
    /// File Type
    ///
    /// Many FIT File Types have specific requirements for the messages
    /// or properties that must be used.
    case fileType(String)
    /// Wrong Definition Message
    case wrongDefinitionMessage(String)
    /// Base Type Issue
    case unknownBaseType
}

extension FitEncodingError: LocalizedError {
    
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .noMessages:
            return "No Messages to Encode"
        case .multipleFileIdMessage:
            return "messages can not contain second FileIdMessage"
        case .tooManyMessages:
            return "Fit File has to many Messages. Can only encode \(UInt32.max) bytes"
        case .notSupported:
            return "Message not currently supported for Encode"
        case .properySize(let msg):
            return msg
        case .noProperties(let msg):
            return msg
        case .fileType(let msg):
            return msg
        case .wrongDefinitionMessage(let msg):
            return msg
        case .unknownBaseType:
            return "Unknown BaseType"
        }
    }
}
