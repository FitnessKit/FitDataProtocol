//
//  WorkoutCapabilities.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 11/28/19.
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

/// Workout Capabilities Options
public struct WorkoutCapabilities: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    
    /// Interval
    public static let interval = WorkoutCapabilities(rawValue: 0x00000001)
    /// Custom
    public static let custom = WorkoutCapabilities(rawValue: 0x00000002)
    /// Fitness Equipment
    public static let fitnessEquipment = WorkoutCapabilities(rawValue: 0x00000004)
    /// First Beat
    public static let firstBeat = WorkoutCapabilities(rawValue: 0x00000008)
    /// New Leaf
    public static let newLeaf = WorkoutCapabilities(rawValue: 0x00000010)
    /// TCX
    ///
    /// For backwards compatibility.  Watch should add missing id fields then clear flag
    public static let tcx = WorkoutCapabilities(rawValue: 0x00000020)
    /// Speed
    ///
    /// Speed source required for workout step
    public static let speed = WorkoutCapabilities(rawValue: 0x00000080)
    /// Heart Rate
    ///
    /// Heart rate source required for workout step
    public static let heartRate = WorkoutCapabilities(rawValue: 0x00000100)
    /// Distance
    ///
    /// Distance source required for workout step
    public static let distance = WorkoutCapabilities(rawValue: 0x00000200)
    /// Cadence
    ///
    /// Cadence source required for workout step
    public static let cadence = WorkoutCapabilities(rawValue: 0x00000400)
    /// Power
    ///
    /// Power source required for workout step
    public static let power = WorkoutCapabilities(rawValue: 0x00000800)
    /// Grade
    ///
    /// Grade source required for workout step
    public static let grade = WorkoutCapabilities(rawValue: 0x00001000)
    /// Resistance
    ///
    /// Resistance source required for workout step
    public static let resistance = WorkoutCapabilities(rawValue: 0x00002000)
    /// Protected
    public static let protected = WorkoutCapabilities(rawValue: 0x00004000)
}

// MARK: - FitFieldCodeable
extension WorkoutCapabilities: FitFieldCodeable {
    
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
            return WorkoutCapabilities(rawValue: value) as? T
        }
        
        return nil
    }
}
