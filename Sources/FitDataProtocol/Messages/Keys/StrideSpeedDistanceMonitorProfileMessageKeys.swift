//
//  StrideSpeedDistanceMonitorProfileMessageKeys.swift
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
extension StrideSpeedDistanceMonitorProfileMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Message Index
        case messageIndex           = 254

        /// Enabled
        case enabled                = 0
        /// ANT ID
        case antID                  = 1
        /// Calibration Factor
        case calibrationFactor      = 2
        /// Odometer
        case odometer               = 3
        /// Speed Source
        case speedSource            = 4
        /// ANT Transmission Type
        case transType              = 5
        /// Odometer Rollover
        case odometerRollover       = 7
    }
}

extension StrideSpeedDistanceMonitorProfileMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .messageIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .enabled:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .antID:
            return BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .calibrationFactor:
            // 10 * % + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .odometer:
            // 100 * m + 0
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .speedSource:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .transType:
            return BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .odometerRollover:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension StrideSpeedDistanceMonitorProfileMessage.FitCodingKeys: KeyedEncoder {}

// AntDevice Encoding
extension StrideSpeedDistanceMonitorProfileMessage.FitCodingKeys: KeyedEncoderAntDevice {}

extension StrideSpeedDistanceMonitorProfileMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
