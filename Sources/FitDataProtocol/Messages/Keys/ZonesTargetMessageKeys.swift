//
//  ZonesTargetMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/25/18.
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
extension ZonesTargetMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Max Heart Rate
        case maxHeartRate               = 1
        /// Threshold Heart Rate
        case thresholdHeartRate         = 2
        /// Functional Threshold Power (FTP)
        case functionalThresholdPower   = 3
        /// HR Calculation Type
        case heartRateCalculation       = 5
        /// Power Calculation Type
        case powerCalculation           = 7
    }
}

extension ZonesTargetMessage.FitCodingKeys: BaseTypeable {
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .maxHeartRate:
            // 1 * bpm + 0
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .thresholdHeartRate:
            // 1 * bpm + 0
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .functionalThresholdPower:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .heartRateCalculation:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .powerCalculation:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension ZonesTargetMessage.FitCodingKeys: KeyedEncoder {}

// Encoding
internal extension ZonesTargetMessage.FitCodingKeys {

    func encodeKeyed(value: HeartRateZoneCalculation) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    func encodeKeyed(value: PowerZoneCalculation) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }
}

extension ZonesTargetMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
