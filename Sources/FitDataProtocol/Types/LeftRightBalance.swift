//
//  LeftRightBalance.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/7/19.
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

/// Left Right Balance
public struct LeftRightBalance {
    private let kMask: UInt8 = 0x7F
    private let rightBit: UInt8 = 0x80

    /// Percent of Contribution
    public let percentContribution: UInt8
    
    /// Corresponds to Right
    public let right: Bool
    
    internal init(value: UInt8) {
        self.right = (value & rightBit == rightBit)
        self.percentContribution = (value & kMask)
    }

    public init(percentContribution: UInt8, right: Bool) {
        self.percentContribution = percentContribution
        self.right = right
    }
}

// MARK: - FitFieldCodeable
extension LeftRightBalance: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        var encode = Data()

        var value: UInt8 = percentContribution
        value |= self.right.uint8Value << 7

        encode.append(Data(from: value.littleEndian))

        return encode
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
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return LeftRightBalance(value: value) as? T
        }
        
        return nil
    }
}

/// Left Right Balance scaled by 100
public struct LeftRightBalance100 {
    private let kMask: UInt16 = 0x3FFF
    private let rightBit: UInt16 = 0x8000

    /// Percent of Contribution
    ///
    ///  % contribution scaled by 100
    public let percentContribution: UInt16
    
    /// Corresponds to Right
    public let right: Bool
    
    internal init(value: UInt16) {
        self.right = (value & rightBit == rightBit)
        self.percentContribution = (value & kMask)
    }

    public init(percentContribution: UInt16, right: Bool) {
        self.percentContribution = percentContribution
        self.right = right
    }
}

// MARK: - FitFieldCodeable
extension LeftRightBalance100: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        var encode = Data()

        let mask: UInt16 = right == true ? rightBit : 0
        let value = percentContribution | mask

        encode.append(Data(from: value.littleEndian))

        return encode
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
        if let value = base.type.decode(type: UInt16.self, data: data, resolution: base.resolution, arch: arch) {
            return LeftRightBalance100(value: value) as? T
        }
        
        return nil
    }
}

