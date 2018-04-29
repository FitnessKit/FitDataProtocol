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

    //Generic
    case generic(String)
}

/// FitDataProtocol Error
public struct FitError: Error {

    /// Type of Error
    public let type: ErrorReasons

    public init(_ type: ErrorReasons) {
        self.type = type
    }

    public init(message: String) {
        self.type = .generic(message)
    }
}
