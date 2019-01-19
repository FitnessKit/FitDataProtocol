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
import AntMessageProtocol
import FitnessUnits

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

internal extension ConnectivityMessage.FitCodingKeys {

    /// Key Base Type Resolution
    var resolution: Resolution {
        switch self {
        case .bluetoothEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .bluetoothLowEnergyEnable:
            return Resolution(scale: 1.0, offset: 0.0)
        case .antEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .connectivityName:
            return Resolution(scale: 1.0, offset: 0.0)
        case .liveTrackingEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .weatherConditionsEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .weatherAlertsEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .autoActivityUploadEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .courseDownloadEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .workoutDownloadEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .gpsEphemerisDownloadEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .incidentDetectionEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        case .groupTrackEnabled:
            return Resolution(scale: 1.0, offset: 0.0)
        }
    }
}

// Encoding
extension ConnectivityMessage.FitCodingKeys: EncodeKeyed {

    internal func encodeKeyed(value: Bool) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt8) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt8>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt16) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt16>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: UInt32) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt32>) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }

    internal func encodeKeyed(value: Double) throws -> Data {
        return try self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
}


internal extension ConnectivityMessage.FitCodingKeys {

    /// Create a Field Definition Message From the Key
    ///
    /// - Parameter size: Data Size, if nil will use the keys predefined size
    /// - Returns: FieldDefinition
    internal func fieldDefinition(size: UInt8) -> FieldDefinition {

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: UInt8(self.rawValue),
                                              size: size,
                                              endianAbility: self.baseType.hasEndian,
                                              baseType: self.baseType)

        return fieldDefinition
    }

    /// Create a Field Definition Message From the Key
    ///
    /// - Returns: FieldDefinition
    internal func fieldDefinition() -> FieldDefinition {

        let fieldDefinition = FieldDefinition(fieldDefinitionNumber: UInt8(self.rawValue),
                                              size: self.baseType.dataSize,
                                              endianAbility: self.baseType.hasEndian,
                                              baseType: self.baseType)

        return fieldDefinition
    }
}
