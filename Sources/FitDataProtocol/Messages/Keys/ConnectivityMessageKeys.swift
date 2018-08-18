//
//  ConnectivityMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/18/18.
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

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension ConnectivityMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case bluetoothEnabled               = 0
        case bluetoothLowEnergyEnable       = 1
        case antEnabled                     = 2
        case connectivityName               = 3
        case liveTrackingEnabled            = 4
        case weatherConditionsEnabled       = 5
        case weatherAlertsEnabled           = 6
        case autoActivityUploadEnabled      = 7
        case courseDownloadEnabled          = 8
        case workoutDownloadEnabled         = 9
        case gpsEphemerisDownloadEnabled    = 10
        case incidentDetectionEnabled       = 11
        case groupTrackEnabled              = 12

    }
}
