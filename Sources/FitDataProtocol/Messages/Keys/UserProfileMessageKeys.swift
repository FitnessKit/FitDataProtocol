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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension UserProfileMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
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

        /// Timestamp
        case timestamp                      = 253
        /// Message Index
        case messageIndex                   = 254
    }
}

public extension UserProfileMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .friendlyName:
            return .string //16
        case .gender:
            return .enumtype
        case .age:
            return .uint8
        case .height:
            return .uint8
        case .weight:
            return .uint16
        case .language:
            return .enumtype
        case .elevationSetting:
            return .enumtype
        case .weightSetting:
            return .enumtype
        case .restingHeartRate:
            return .uint8
        case .defaultMaxRunningHeartRate:
            return .uint8
        case .defaultMaxBikingHeartRate:
            return .uint8
        case .defaultMaxHeartRate:
            return .uint8
        case .heartRateSetting:
            return .enumtype
        case .speedSetting:
            return .enumtype
        case .distanceSetting:
            return .enumtype
        case .powerSetting:
            return .enumtype
        case .activityClass:
            return .enumtype
        case .positionSetting:
            return .enumtype
        case .temperatureSetting:
            return .enumtype
        case .localID:
            return .uint16
        case .globalID:
            return .byte    //6
        case .heightSetting:
            return .enumtype
        case .runningStepLength:
            return .uint16
        case .walkingStepLength:
            return .uint16
        case .timestamp:
            return .uint32
        case .messageIndex:
            return .uint16
        }
    }

}
