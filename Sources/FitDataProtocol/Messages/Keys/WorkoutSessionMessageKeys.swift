//
//  WorkoutSessionMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 9/8/18.
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
extension WorkoutSessionMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Message Index
        case messageIndex           = 254

        /// Sport
        case sport                  = 0
        /// Sub-Sport
        case subSport               = 1
        /// Number of Valid Steps
        case numberOfValidSteps     = 2
        /// First Step Index
        case firstStepIndex         = 3
        /// Pool Length
        case poolLength             = 4
        /// Pool Length Unit
        case poolLengthUnit         = 5
    }
}

extension WorkoutSessionMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .messageIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .sport:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .subSport:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .numberOfValidSteps:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .firstStepIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .poolLength:
            // 100 * m + 0
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0))
        case .poolLengthUnit:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension WorkoutSessionMessage.FitCodingKeys: KeyedEncoder {}

// Display TypeEncoding
extension WorkoutSessionMessage.FitCodingKeys: KeyedEncoderDisplayType {}

// Sport Encoding
extension WorkoutSessionMessage.FitCodingKeys: KeyedEncoderSport {}

extension WorkoutSessionMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
