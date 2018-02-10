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
    /// Invalid Activity
    case invalid            = 255
}

extension ActivityType {

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
        default:
            return "Invalid"
        }
    }
}

//MARK: - FIT Activity Sub Type

/// FIT Activity Sub Type
public enum ActivitySubType: UInt8 {
    case generic        = 0
    case treadmill      = 1     //Run
    case street         = 2     //Run
    case trail          = 3     //Run
    case track          = 4     //Run
    case spin           = 5     //Cycling
    case indoorCycling  = 6     //Cycling
    case road           = 7     //Cycling
    case mountain       = 8     //Cycling
    case downhill       = 9     //Cycling
    case recumbent      = 10    //Cycling
    case cycloCross     = 11    //Cycling
    case handCycling    = 12    //Cycling
    case trackCycling   = 13    //Cycling
    case indoorRowing   = 14    //Fitness Equipment
    case elliptical     = 15    //Fitness Equipment
    case stairClimbing  = 16    //Fitness Equipment
    case lapSwimming    = 17    //Swimming
    case openWater      = 18    //Swimming

    case all            = 254
    case Invalid        = 255
}

extension ActivitySubType {

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
    case low        = 0
    case medium     = 1
    case high       = 2

    case invalid    = 255
}

extension ActivityLevel {

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
