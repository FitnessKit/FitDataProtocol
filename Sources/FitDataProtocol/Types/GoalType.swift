//
//  GoalType.swift
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

/// FIT Goal type
public enum Goal: UInt8 {
    /// Time
    case time           = 0
    /// Distance
    case distance       = 1
    /// Calories
    case calories       = 2
    /// Frequency
    case frequency      = 3
    /// Steps
    case steps          = 4
    /// Ascent
    case ascent         = 5
    /// Active Minutes
    case activeMinutes  = 6

    /// Invalid
    case invalid        = 255
}

// MARK: - FitFieldCodeable
extension Goal: FitFieldCodeable {
    
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
            return Goal(rawValue: value) as? T
        }
        
        return nil
    }
}

/// FIT Goal Recurrence
public enum GoalRecurrence: UInt8 {
    /// Off
    case off            = 0
    /// Daily
    case daily          = 1
    /// Weekly
    case weekly         = 2
    /// Monthly
    case monthly        = 3
    /// Yearly
    case yearly         = 4
    /// Custom
    case custom         = 5

    /// Invalid
    case invalid        = 255
}

// MARK: - FitFieldCodeable
extension GoalRecurrence: FitFieldCodeable {
    
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
            return GoalRecurrence(rawValue: value) as? T
        }
        
        return nil
    }
}

/// FIT Goal Source
public enum GoalSource: UInt8 {
    /// Auto - Device Generated
    case auto           = 0
    /// Community - Social Network Sourced Goal
    case community      = 1
    /// User - Manually Generated
    case user           = 2

    /// Invalid
    case invalid        = 255
}

// MARK: - FitFieldCodeable
extension GoalSource: FitFieldCodeable {
    
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
            return GoalSource(rawValue: value) as? T
        }
        
        return nil
    }
}
