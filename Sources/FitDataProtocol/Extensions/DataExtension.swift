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
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
    
    func to<T>(type: T.Type) -> T? where T: ExpressibleByIntegerLiteral {
        var value: T = 0
        guard count >= MemoryLayout.size(ofValue: value) else { return nil }
        _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
        return value
    }
    
    func to<T>(type: T.Type) -> T where T: ExpressibleByIntegerLiteral {
        var value: T = 0
        _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
        return value as T
    }

    /// Smartly Decodes String
    var smartString: String? {
        var stringvalue: String?

        guard self.count > 1 else { return stringvalue }

        stringvalue = String(bytes: self, encoding: .utf8)

        if self[(self.endIndex - 1)] == 0 {
            stringvalue = String(bytes: self, encoding: .utf8)
        } else {
            stringvalue = String(bytes: self, encoding: .ascii)
        }

        if let checkString = stringvalue {
            /* Wrong trimming
             In German I got"Laufen\0\0n\0\0\u{04}Èî»p\0\0\0\u{04})Ä\u{13}\u{08}" for
             the sport message  „Running“. The trimming with “\0 “at the end
             doesn’t work. I am using the prefix function to get
             the substring “Laufen” until “\0 “.
            */

            let substring = checkString.prefix(while: { (character) -> Bool in
                return character != "\0"
            })
            let trimmed = String(substring)
            
            if trimmed.isEmpty {
                return nil
            }
            
            return trimmed
        }
        
        return nil
    }

    /// Provide Segments of the Data
    ///
    /// - Parameters:
    ///   - size: Size of the Segments
    ///   - offset: Starting Index position
    /// - Returns: Array of Segmented Data
    func segment(size: Int, offset: Int = 0) -> [Data] {
        return stride(from: offset, to: count, by: size).map {
            self[$0 ..< Swift.min($0 + size, count)]
        }
    }

}

extension Data: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        return self
    }
    
    /// Decode FIT Field
    ///
    /// - Parameters:
    ///   - type: Type of Field
    ///   - data: Data to Decode
    ///   - base: BaseTypeData
    ///   - arch: Endian
    /// - Returns: Decoded Value
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if data.isEmpty == false {
            return data as? T
        }
        
        return nil
    }
}
