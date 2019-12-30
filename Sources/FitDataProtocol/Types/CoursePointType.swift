//
//  CoursePointType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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

/// Course Point Type
public enum CoursePoint: UInt8 {
    /// Generic
    case generic            = 0
    /// Summit
    case summit             = 1
    /// Valley
    case valley             = 2
    /// Water
    case water              = 3
    /// Food
    case food               = 4
    /// Danger
    case danger             = 5
    /// Left
    case left               = 6
    /// Right
    case right              = 7
    /// Straight
    case straight           = 8
    /// First Aid
    case firstAid           = 9
    /// Fourth Category
    case fourthCategory     = 10
    /// Third Category
    case thirdCategory      = 11
    /// Second Category
    case secondCategory     = 12
    /// First Category
    case firstCategory      = 13
    /// Hors Category (HC)
    case horsCategory       = 14
    /// Sprint
    case sprint             = 15
    //// Left Fork
    case leftFork           = 16
    /// Right Fork
    case rightFork          = 17
    /// Middle Fork
    case middleFork         = 18
    /// Slight Left
    case slightLeft         = 19
    /// Sharp Left
    case sharpLeft          = 20
    /// Slight Right
    case slightRight        = 21
    /// Sharp Right
    case sharpRight         = 22
    /// U Turn
    case uTurn              = 23
    /// Segment Start
    case segmentStart       = 24
    /// Segment End
    case segmentEnd         = 25

    /// Invalid
    case invalid            = 255
}

// MARK: - FitFieldCodeable
extension CoursePoint: FitFieldCodeable {
    
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
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return CoursePoint(rawValue: value) as? T
        }
        
        return nil
    }
}
