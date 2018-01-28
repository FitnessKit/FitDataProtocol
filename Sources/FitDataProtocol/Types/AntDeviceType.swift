//
//  AntDeviceType.swift
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


/// ANT Device Types
public enum AntDeviceType: UInt8 {
    case unknown                    = 0
    case sync                       = 1
    case bikePower                  = 11
    case multiSportSpeedDistance    = 15
    case controls                   = 16
    case fitnessEquipment           = 17
    case bloodPressure              = 18
    case geoCache                   = 19
    case lightElectricVehicle       = 20
    case activityMonitor            = 21
    case environment                = 25
    case racquet                    = 26
    case muscleOxygen               = 31
    case bikeShifting               = 34
    case bikeLights                 = 35
    case bikeLightsSecondary        = 36
    case bikeRadar                  = 40
    case tracker                    = 41
    case runningDynamics            = 48
    case dropperSeatpost            = 115
    case bikeSuspension             = 116
    case weightScale                = 119
    case heartRate                  = 120
    case bikeSpeedCadence           = 121
    case bikeCadence                = 122
    case bikeSpeed                  = 123
    case strideBasedSpeedDistance   = 124
}
