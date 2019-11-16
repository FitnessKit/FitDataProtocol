//
//  BloodPressureMessageKeys.swift
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
extension BloodPressureMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp              = 253

        /// Systolic Pressure
        case systolicPressure       = 0
        /// Diastolic Pressure
        case diastolicPressure      = 1
        /// Mean Arterial Pressure
        case meanArterialPressure   = 2
        /// Map Sample Mean
        case mapSampleMean          = 3
        /// Map Morning Values
        case mapMorningValues       = 4
        /// Map Evening Values
        case mapEveningValues       = 5
        /// Heart Rate
        case heartRate              = 6
        /// Heart Rate Type
        case heartRateType          = 7
        /// Status
        case status                 = 8
        /// User Profile Index
        case userProfileIndex       = 9
    }
}

extension BloodPressureMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .timestamp:
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .systolicPressure:
            // 1 * mmHg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .diastolicPressure:
            // 1 * mmHg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .meanArterialPressure:
            // 1 * mmHg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .mapSampleMean:
            // 1 * mmHg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .mapMorningValues:
            // 1 * mmHg + 0
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .mapEveningValues:
            // 1 * mmHg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .heartRate:
            // 1 * bpm + 0
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .heartRateType:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .status:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .userProfileIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension BloodPressureMessage.FitCodingKeys: KeyedEncoder {}

// Encoding
internal extension BloodPressureMessage.FitCodingKeys {

    func encodeKeyed(value: HeartRateType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    func encodeKeyed(value: BloodPressureStatus) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }
}

// Field Definitions
extension BloodPressureMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
