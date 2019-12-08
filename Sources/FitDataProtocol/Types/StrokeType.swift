//
//  StrokeType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/18.
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

/// FIT Stroke Type
public enum Stroke: UInt8 {
    /// No Event
    case noEvent        = 0
    /// Other
    ///
    /// stroke was detected but cannot be identified
    case other          = 1
    /// Serve
    case serve          = 2
    /// Forehand
    case forehand       = 3
    /// Backhand
    case backhand       = 4
    /// Smash
    case smash          = 5

    /// Invalid
    case invalid        = 255
}

// MARK: - FitFieldCodeable
extension Stroke: FitFieldCodeable {
    
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
    }
    
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return Stroke(rawValue: value) as? T
        }
        
        return nil
    }
}
