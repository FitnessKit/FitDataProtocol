//
//  Activity.swift
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

/// FIT Activity
public enum Activity: UInt8 {
    /// Manual
    case manual             = 0
    /// Multisport
    case multisport         = 1
    /// Invalid
    case invalid            = 255
}

// MARK: - FitFieldCodeable
extension Activity: FitFieldCodeable {
    
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
            return Activity(rawValue: value) as? T
        }
        
        return nil
    }
}

//MARK: - FIT Activity Type

/// FIT Activity Type
public enum ActivityType: UInt8 {
    /// Generic Activity
    case generic            = 0
    /// Running
    case running            = 1
    /// Cycling
    case cycling            = 2
    /// Multi-Sport Transition
    case transition         = 3
    /// Fitness Equipment
    case fitnessEquipment   = 4
    /// Swimming
    case swimming           = 5
    /// Walking
    case walking            = 6
    /// Sedentary
    case sedentary          = 8
    /// All
    case all                = 254
    /// Invalid Activity
    case invalid            = 255
}

// MARK: - FitFieldCodeable
extension ActivityType: FitFieldCodeable {
    
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
            return ActivityType(rawValue: value) as? T
        }
        
        return nil
    }
}

extension ActivityType {

    /// String Value
    var stringValue: String {
        switch self {
        case .generic:
            return "Generic"
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .transition:
            return "Transition"
        case .fitnessEquipment:
            return "Fitness Equipment"
        case .swimming:
            return "Swimming"
        case .walking:
            return "Walking"
        case .sedentary:
            return "Sedentary"
        case .all:
            return "All"
        default:
            return "Invalid"
        }
    }
}

//MARK: - FIT Activity Sub Type

/// FIT Activity Sub Type
public enum ActivitySubType: UInt8 {
    /// Generic
    case generic        = 0
    /// Treadmill
    case treadmill      = 1     //Run
    /// Street (Run)
    case street         = 2     //Run
    /// Trail (Run)
    case trail          = 3     //Run
    /// Track (Run)
    case track          = 4     //Run
    /// Spin (Cycling)
    case spin           = 5     //Cycling
    /// Indoor Cycling (Cycling)
    case indoorCycling  = 6     //Cycling
    /// Road (Cycling)
    case road           = 7     //Cycling
    /// Mountain (Cycling)
    case mountain       = 8     //Cycling
    /// Downhill (Cycling)
    case downhill       = 9     //Cycling
    /// Recumbent (Cycling)
    case recumbent      = 10    //Cycling
    /// Cyclocross (Cycling)
    case cycloCross     = 11    //Cycling
    /// Hand Cycling (Cycling)
    case handCycling    = 12    //Cycling
    /// Track Cycling (Cycling)
    case trackCycling   = 13    //Cycling
    /// Indoor Rowing (Fitness Equipment)
    case indoorRowing   = 14    //Fitness Equipment
    /// Elliptical (Fitness Equipment)
    case elliptical     = 15    //Fitness Equipment
    /// Stair Climbing (Fitness Equipment)
    case stairClimbing  = 16    //Fitness Equipment
    /// Lap Swimming (Swimming)
    case lapSwimming    = 17    //Swimming
    /// Open Water (SWimming)
    case openWater      = 18    //Swimming

    /// All
    case all            = 254
    /// Invalid
    case Invalid        = 255
}

extension ActivitySubType {

    /// String Value
    var stringValue: String {
        switch self {
        case .generic:
            return "Generic"
        case .treadmill:
            return "Treadmill"
        case .street:
            return "Street"
        case .trail:
            return "Trail"
        case .track:
            return "Track"
        case .spin:
            return "Spin"
        case .indoorCycling:
            return "Indoor Cycling"
        case .road:
            return "Road"
        case .mountain:
            return "Mountain"
        case .downhill:
            return "downhill"
        case .recumbent:
            return "Recumbent"
        case .cycloCross:
            return "Cyclocross"
        case .handCycling:
            return "Hand Cycling"
        case .trackCycling:
            return "Track Cycling"
        case .indoorRowing:
            return "Indoor Rowing"
        case .elliptical:
            return "Elliptical"
        case .stairClimbing:
            return "Stair Climbing"
        case .lapSwimming:
            return "Lap Swimming"
        case .openWater:
            return "Open Water"
        case .all:
            return "All"
        default:
            return "Invalid"
        }
    }
}

//MARK: - FIT Activity Level

/// FIT Activity Level
public enum ActivityLevel: UInt8 {
    /// Low Activity Level
    case low        = 0
    /// Medium Activity Level
    case medium     = 1
    /// High Activity Level
    case high       = 2

    /// Invalid
    case invalid    = 255
}

extension ActivityLevel {

    /// String Value
    var stringValue: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        default:
            return "Invalid"
        }
    }
}
