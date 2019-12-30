//
//  ConnectivityCapabilities.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/29/19.
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

/// Connectivity Capabilities
public struct ConnectivityCapabilities: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    
    /// Bluetooth
    public static let bluetooth = ConnectivityCapabilities(rawValue: 0x00000001)
    /// BLE
    public static let ble = ConnectivityCapabilities(rawValue: 0x00000002)
    /// ANT
    public static let ant = ConnectivityCapabilities(rawValue: 0x00000004)
    /// Activity Upload
    public static let activityUpload = ConnectivityCapabilities(rawValue: 0x00000008)
    /// Course Download
    public static let courseDownload = ConnectivityCapabilities(rawValue: 0x00000010)
    /// Workout Download
    public static let workoutDownload = ConnectivityCapabilities(rawValue: 0x00000020)
    /// Live Track
    public static let liveTrack = ConnectivityCapabilities(rawValue: 0x00000040)
    /// Weather Conditions
    public static let weatherConditions = ConnectivityCapabilities(rawValue: 0x00000080)
    /// Weather Alerts
    public static let weatherAlerta = ConnectivityCapabilities(rawValue: 0x00000100)
    /// GPS Ephemeris Download
    public static let gpsEphemerisDownload = ConnectivityCapabilities(rawValue: 0x00000200)
    /// Explicit Archive
    public static let explicitArchive = ConnectivityCapabilities(rawValue: 0x00000400)
    /// Setup Incomplete
    public static let setupIncomplete = ConnectivityCapabilities(rawValue: 0x00000800)
    /// Continue Sync After Software Update
    public static let continueSyncAfterSoftwareUpdate = ConnectivityCapabilities(rawValue: 0x00001000)
    /// Connect IQ App Download
    public static let connectIQAppDownload = ConnectivityCapabilities(rawValue: 0x00002000)
    /// Golf Course Download
    public static let golfCourseDownload = ConnectivityCapabilities(rawValue: 0x00004000)
    /// Device Initiates Sync
    ///
    /// Indicates device is in control of initiating all syncs
    public static let deviceInitiatesSync = ConnectivityCapabilities(rawValue: 0x00008000)
    /// Connect IQ Watch App Download
    public static let connectIQWatchAppDownload = ConnectivityCapabilities(rawValue: 0x00010000)
    /// Connect IQ Widget Download
    public static let connectIQWidgetDownload = ConnectivityCapabilities(rawValue: 0x00020000)
    /// Connect IQ Watchface Download
    public static let connectIQWatchfaceDownload = ConnectivityCapabilities(rawValue: 0x00040000)
    /// Connect IQ Data Field Download
    public static let connectIQDataFieldDownload = ConnectivityCapabilities(rawValue: 0x00080000)
    /// Connect IQ App Management
    ///
    /// Device supports delete and reorder of apps via GCM
    public static let connectIQAppManagement = ConnectivityCapabilities(rawValue: 0x00100000)
    /// Swing Sensor
    public static let swingSensor = ConnectivityCapabilities(rawValue: 0x00200000)
    /// Swing Sensor Remote
    public static let swingSensorRemote = ConnectivityCapabilities(rawValue: 0x00400000)
    /// Incident Detection
    public static let incidentDetection = ConnectivityCapabilities(rawValue: 0x00800000)
    /// Audio Prompts
    public static let audioPrompts = ConnectivityCapabilities(rawValue: 0x01000000)
    /// WIFI Verification
    ///
    /// Device supports reporting wifi verification via GCM
    public static let wifiVerification = ConnectivityCapabilities(rawValue: 0x02000000)
    /// True Up
    public static let trueUp = ConnectivityCapabilities(rawValue: 0x04000000)
    /// Find My Watch
    public static let findMyWatch = ConnectivityCapabilities(rawValue: 0x08000000)
    /// Remote Manual Sync
    public static let remoteManualSync = ConnectivityCapabilities(rawValue: 0x10000000)
    /// Live Track Auto Start
    public static let liveTrackAutoStart = ConnectivityCapabilities(rawValue: 0x20000000)
    /// Live Track Messaging
    public static let liveTrackMessaging = ConnectivityCapabilities(rawValue: 0x20000000)
    /// Instant Input
    public static let instantInput = ConnectivityCapabilities(rawValue: 0x80000000)
}

extension ConnectivityCapabilities: FitFieldCodeable {
    
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
            return ConnectivityCapabilities(rawValue: value) as? T
        }
        
        return nil
    }
}
