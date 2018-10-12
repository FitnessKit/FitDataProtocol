//
//  LapTrigger.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 10/12/18.
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

/// FIT Lap Trigger Type
public enum LapTrigger: UInt8 {
    /// Manual
    case manual             = 0
    /// Time
    case time               = 1
    /// Distance
    case distance           = 2
    /// Position Start
    case positionStart      = 3
    /// Position Lap
    case positionLap        = 4
    /// Position Waypoint
    case positionWaypoint   = 5
    /// Position Marked
    case positionMarked     = 6
    /// Session End
    case sessionEnd         = 7
    /// Fitness Eqiupment
    case fitnessEquipment   = 8

    /// Invalid
    case invalid            = 255
}
