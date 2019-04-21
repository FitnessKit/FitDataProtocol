//
//  UserProfileMessageKeys.swift
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
extension UserProfileMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Message Index
        case messageIndex                   = 254
        /// Timestamp
        case timestamp                      = 253

        /// Friendly Name
        case friendlyName                   = 0
        /// Gender
        case gender                         = 1
        /// Age
        case age                            = 2
        /// Height
        case height                         = 3
        /// Weight
        case weight                         = 4
        /// Language
        case language                       = 5
        /// Elevation Setting
        case elevationSetting               = 6
        /// Weight Setting
        case weightSetting                  = 7
        /// Resting Heart Rate
        case restingHeartRate               = 8
        /// Default Max Running Heart Rate
        case defaultMaxRunningHeartRate     = 9
        /// Default Max Biking Heart Rate
        case defaultMaxBikingHeartRate      = 10
        /// Default Max Heart Rate
        case defaultMaxHeartRate            = 11
        /// Heart Rate Setting
        case heartRateSetting               = 12
        /// Speed Setting
        case speedSetting                   = 13
        /// Distance Setting
        case distanceSetting                = 14
        /// Power Setting
        case powerSetting                   = 16
        /// Activity Class
        case activityClass                  = 17
        /// Position Setting
        case positionSetting                = 18
        /// Temperature Setting
        case temperatureSetting             = 21
        /// Local ID
        case localID                        = 22
        /// Global ID
        case globalID                       = 23
        /// Height Setting
        case heightSetting                  = 30
        /// Running Step Length
        case runningStepLength              = 31
        /// Walking Step Length
        case walkingStepLength              = 32
    }
}

extension UserProfileMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    /// Key Base Resolution
    var resolution: Resolution { return self.baseData.resolution }
    
    /// Key Base Data
    var baseData: BaseData {
        switch self {
        case .messageIndex:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .timestamp:
            // 1 * s + 0
            return BaseData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .friendlyName:
            // 16
            return BaseData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .gender:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .age:
            /// 1 * years
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .height:
            // 100 * m + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .weight:
            // 10 * kg + 0
            return BaseData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0))
        case .language:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .elevationSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .weightSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .restingHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .defaultMaxRunningHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .defaultMaxBikingHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .defaultMaxHeartRate:
            // 1 * bpm + 0
            return BaseData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .heartRateSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .speedSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .distanceSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .powerSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .activityClass:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .positionSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .temperatureSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .localID:
            return BaseData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .globalID:
            // 16
            return BaseData(type: .byte, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .heightSetting:
            return BaseData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .runningStepLength:
            // 1000 * m + 0, User defined running step length set to 0 for auto length
            return BaseData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        case .walkingStepLength:
            // 1000 * m + 0, User defined running step length set to 0 for auto length
            return BaseData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0))
        }
    }
}

extension UserProfileMessage.FitCodingKeys: KeyedEncoder {}

// Display Types Encoding
extension UserProfileMessage.FitCodingKeys: KeyedEncoderDisplayType {}

// Encoding
internal extension UserProfileMessage.FitCodingKeys {

    func encodeKeyed(value: Gender) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }

    func encodeKeyed(value: Language) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}

extension UserProfileMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
