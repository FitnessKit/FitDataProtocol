//
//  Event.swift
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

/// FIT Event
public enum Event: UInt8 {
    /// Timer - Group 0.  Start / stop_all
    case timer                  = 0
    /// Workout - start / stop
    case workout                = 3
    /// Workout Step - Start at beginning of workout.  Stop at end of each step
    case workoutStep            = 4
    /// Power Down - stop_all group 0
    case powerDown              = 5
    /// Power Up - stop_all group 0
    case powerUp                = 6
    /// Off Course - start / stop group 0
    case offCourse              = 7
    /// Session - Stop at end of each session
    case session                = 8
    /// Lap - Stop at end of each lap
    case lap                    = 9
    /// Course Point - marker
    case coursePoint            = 10
    /// Battery - marker
    case battery                = 11
    /// Virtual Partner Pace - Group 1. Start at beginning of activity if VP enabled,
    /// when VP pace is changed during activity or VP enabled mid activity
    case virtualPatnerPace      = 12
    /// HR Hight Alert - Group 0.  Start / stop when in alert condition.
    case hrHighAlert            = 13
    /// HR Low Alert - Group 0.  Start / stop when in alert condition.
    case hrLowAlert             = 14
    /// Speed High Alert - Group 0.  Start / stop when in alert condition.
    case speedHighAlert         = 15
    /// Speed Low Alert - Group 0.  Start / stop when in alert condition.
    case speedLowAlert          = 16
    /// Cadence High Alert - Group 0.  Start / stop when in alert condition.
    case cadenceHighAlert       = 17
    /// Cadence Low Alert - Group 0.  Start / stop when in alert condition.
    case cadenceLowAlert        = 18
    /// Power High Alert - Group 0.  Start / stop when in alert condition.
    case powerHighAlert         = 19
    /// Power Low Alert - Group 0.  Start / stop when in alert condition.
    case powerLowAlert          = 20
    /// Recovery HR - marker
    case recoveryHr             = 21
    /// Battery Low
    case batteryLow             = 22
    /// Time Duration Alert - Group 1.  Start if enabled mid activity (not required at
    /// start of activity). Stop when duration is reached.  stop_disable if disabled
    case timeDurationAlert      = 23
    ///Distance Duration Alert - Group 1.  Start if enabled mid activity (not required
    /// at start of activity). Stop when duration is reached.  stop_disable if disabled
    case distanceDurationAlert  = 24
    /// Calorie Duration Alert - Group 1.  Start if enabled mid activity (not required
    /// at start of activity). Stop when duration is reached.  stop_disable if disabled
    case calorieDurationAlert   = 25
    /// Activity - Group 1..  Stop at end of activity
    case activity               = 26
    /// Fitness Equipment - marker
    case fitnessEquipment       = 27
    /// Length - Stop at end of each length
    case length                 = 28
    /// User Marker - marker
    case userMarker             = 32
    /// Sport Point - marker
    case sportPoint             = 33
    /// Calibration - start/stop/marker
    case calibration            = 36
    /// Front Gear Change - marker
    case frontGearChange        = 42
    /// Rear Gear Change - marker
    case rearGearChange         = 43
    /// Rider Position Change - marker
    case riderPositionChange    = 44
    /// Elevation High Alert - Group 0.  Start / stop when in alert condition
    case elevationHighAlert     = 45
    /// Elevation Low Alert - Group 0.  Start / stop when in alert condition
    case elevationLowAlert      = 46
    /// Communication Timeout - marker
    case communicationTimeout   = 47
    /// Invalid
    case invalid                = 255
}

// MARK: - FitFieldCodeable
extension Event: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
    }
    
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return Event(rawValue: value) as? T
        }
        
        return nil
    }
}
