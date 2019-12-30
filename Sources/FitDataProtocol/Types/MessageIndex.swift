//
//  MessageIndex.swift
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

/// Message Index
public struct MessageIndex {
    private let kSelected: UInt16 = 0x8000
    private let kReserved: UInt16 = 0x7000
    private let kMask: UInt16 = 0x0FFF

    /// Index is Selected
    private(set) public var isSelected: Bool

    /// Index
    private(set) public var index: UInt16

    public init(isSelected: Bool = false, value: UInt16) {
        self.isSelected = isSelected
        self.index = (value & kMask)
    }

    internal init(value: UInt16) {
        self.isSelected = (value & kSelected) == kSelected
        self.index = (value & kMask)
    }
}

extension MessageIndex: Equatable {}

// MARK: - FitFieldCodeable
extension MessageIndex: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        var encode = Data()

        let selected: UInt16 = isSelected == true ? kSelected : 0
        let value = index | selected

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
            return MessageIndex(value: value) as? T
        }
        
        return nil
    }
}
