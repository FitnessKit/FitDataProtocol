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

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension WeightScaleMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
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

        /// Timestamp
        case timestamp              = 253

    }
}

public extension WeightScaleMessage.FitCodingKeys {

    /// Key Base Type
    public var baseType: BaseType {
        switch self {
        case .weight:
            return .uint16
        case .percentFat:
            return .uint16
        case .percentHydration:
            return .uint16
        case .visceralFatMass:
            return .uint16
        case .boneMass:
            return .uint16
        case .muscleMass:
            return .uint16
        case .basalMet:
            return .uint16
        case .physiqueRating:
            return .uint8
        case .activeMet:
            return .uint16
        case .metabolicAge:
            return .uint8
        case .visceralFatRating:
            return .uint8
        case .userProfileIndex:
            return .uint16
        case .timestamp:
            return .uint32
        }
    }

}
