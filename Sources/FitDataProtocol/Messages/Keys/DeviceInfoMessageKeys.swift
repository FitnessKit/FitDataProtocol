//
//  DeviceInfoMessageKeys.swift
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
extension DeviceInfoMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp          = 253

        /// Device Index
        case deviceIndex        = 0
        /// Device Type
        case deviceType         = 1
        /// Manufacturer
        case manufacturer       = 2
        /// Serial Number
        case serialNumber       = 3
        /// Product
        case product            = 4
        /// Software Version
        case softwareVersion    = 5
        /// Hardware Version
        case hardwareVersion    = 6
        /// Cumulative Operating Time
        case cumulativeOpTime   = 7
        /// Battery Voltage
        case batteryVoltage     = 10
        /// Battery Status
        case batteryStatus      = 11
        /// Sensor Position
        case sensorPosition     = 18
        /// Description
        case description        = 19
        /// Transmission Type
        case transmissionType   = 20
        /// Device Number
        case deviceNumber       = 21
        /// ANT Network
        case antNetwork         = 22
        /// Source Type
        case sourcetype         = 25
        /// Product Name
        case productName        = 27
    }
}

extension DeviceInfoMessage.FitCodingKeys: BaseTypeable {
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .timestamp:
            // 1 * s + 0
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .deviceIndex:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .deviceType:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .manufacturer:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .serialNumber:
            return BaseTypeData(type: .uint32z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .product:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .softwareVersion:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .hardwareVersion:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .cumulativeOpTime:
            // 1 * s + 0
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .batteryVoltage:
            // 256 * V + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 256.0, offset: 0.0))
        case .batteryStatus:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .sensorPosition:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .description:
            return BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .transmissionType:
            return BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .deviceNumber:
            return BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .antNetwork:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .sourcetype:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .productName:
            // 20
            return BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension DeviceInfoMessage.FitCodingKeys: KeyedEncoder {}

// AntDevice Encoding
extension DeviceInfoMessage.FitCodingKeys: KeyedEncoderAntDevice {}


extension DeviceInfoMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
