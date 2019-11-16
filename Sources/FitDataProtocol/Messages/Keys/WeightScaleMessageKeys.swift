//
//  WeightScaleMessageKeys.swift
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
extension WeightScaleMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Timestamp
        case timestamp              = 253

        /// Weight
        case weight                 = 0
        /// Percent Fat
        case percentFat             = 1
        /// Percent Hyration
        case percentHydration       = 2
        /// Visceral Fat Mass
        case visceralFatMass        = 3
        /// Bone Mass
        case boneMass               = 4
        /// Muscle Mass
        case muscleMass             = 5
        /// Basal METs
        case basalMet               = 7
        /// Physique Rating
        case physiqueRating         = 8
        /// Active METs
        case activeMet              = 9
        /// Metabolic Age
        case metabolicAge           = 10
        /// Visceral Fat Rating
        case visceralFatRating      = 11
        /// User Profile Index
        case userProfileIndex       = 12
    }
}

extension WeightScaleMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .timestamp:
            // 1 * s + 0
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .weight:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .percentFat:
            // 100 * % + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .percentHydration:
            // 100 * % + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .visceralFatMass:
            // 100 * kg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .boneMass:
            // 100 * kg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .muscleMass:
            // 100 * kg + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .basalMet:
            // 4 * kcal/day + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 4.0, offset: 0.0))
        case .physiqueRating:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .activeMet:
            // 4 * kcal/day + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 4.0, offset: 0.0))
        case .metabolicAge:
            /// 1 * years
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .visceralFatRating:
            return BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .userProfileIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension WeightScaleMessage.FitCodingKeys: KeyedEncoder {}

extension WeightScaleMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
