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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension ConnectivityMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Bluetooth Enabled
        case bluetoothEnabled               = 0
        /// Bluetooth Low Energy Enabled
        case bluetoothLowEnergyEnable       = 1
        /// ANT Enabled
        case antEnabled                     = 2
        /// Connectivity Name
        case connectivityName               = 3
        /// Live Tracking Enabled
        case liveTrackingEnabled            = 4
        /// Weather Conditions Enabled
        case weatherConditionsEnabled       = 5
        /// Weather Alerts Enabled
        case weatherAlertsEnabled           = 6
        /// Auti Activity Upload Enabled
        case autoActivityUploadEnabled      = 7
        /// Course Download Enabled
        case courseDownloadEnabled          = 8
        /// Workout Download Enabled
        case workoutDownloadEnabled         = 9
        /// GPS Ephemeris Download Enabled
        case gpsEphemerisDownloadEnabled    = 10
        /// Incident Detection Enabled
        case incidentDetectionEnabled       = 11
        /// Group Track Enabled
        case groupTrackEnabled              = 12

    }
}

public extension ConnectivityMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .bluetoothEnabled:
            return .enumtype
        case .bluetoothLowEnergyEnable:
            return .enumtype
        case .antEnabled:
            return .enumtype
        case .connectivityName:
            return .string
        case .liveTrackingEnabled:
            return .enumtype
        case .weatherConditionsEnabled:
            return .enumtype
        case .weatherAlertsEnabled:
            return .enumtype
        case .autoActivityUploadEnabled:
            return .enumtype
        case .courseDownloadEnabled:
            return .enumtype
        case .workoutDownloadEnabled:
            return .enumtype
        case .gpsEphemerisDownloadEnabled:
            return .enumtype
        case .incidentDetectionEnabled:
            return .enumtype
        case .groupTrackEnabled:
            return .enumtype
        }
    }

}

//FIT_STRING name[FIT_CONNECTIVITY_MESG_NAME_COUNT]; //
//FIT_BOOL bluetooth_enabled; // Use Bluetooth for connectivity features
//FIT_BOOL bluetooth_le_enabled; // Use Bluetooth Low Energy for connectivity features
//FIT_BOOL ant_enabled; // Use ANT for connectivity features
//FIT_BOOL live_tracking_enabled; //
//FIT_BOOL weather_conditions_enabled; //
//FIT_BOOL weather_alerts_enabled; //
//FIT_BOOL auto_activity_upload_enabled; //
//FIT_BOOL course_download_enabled; //
//FIT_BOOL workout_download_enabled; //
//FIT_BOOL gps_ephemeris_download_enabled; //
//FIT_BOOL incident_detection_enabled; //
//FIT_BOOL grouptrack_enabled; //
