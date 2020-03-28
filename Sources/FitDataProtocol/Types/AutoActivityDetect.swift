//
//  AutoActivityDetect.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/15/19.
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

/// Auto Activity Detect
public struct AutoActivityDetect: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    
    /// None
    public static let none          = AutoActivityDetect([])
    /// Running
    public static let running       = AutoActivityDetect(rawValue: 0x00000001)
    /// Cycling
    public static let cycling       = AutoActivityDetect(rawValue: 0x00000002)
    /// Swimming
    public static let swimming      = AutoActivityDetect(rawValue: 0x00000004)
    /// Walking
    public static let walking       = AutoActivityDetect(rawValue: 0x00000008)
    /// Elliptical
    public static let elliptical    = AutoActivityDetect(rawValue: 0x00000020)
    /// Sedentary
    public static let sedentary     = AutoActivityDetect(rawValue: 0x00000400)
}

// MARK: - FitFieldCodeable
extension AutoActivityDetect: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
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
        if let value = base.type.decode(type: UInt32.self, data: data, resolution: base.resolution, arch: arch) {
            return AutoActivityDetect(rawValue: value) as? T
        }
        
        return nil
    }
}
