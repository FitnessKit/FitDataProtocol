//
//  GoalMessageKeys.swift
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
extension GoalMessage: FitMessageKeys {
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
        /// Start Date
        case startDate              = 2
        /// End Date
        case endDate                = 3
        /// Goal Type
        case goalType               = 4
        /// Goal Value
        case goalValue              = 5
        /// Repeat Goal
        case repeatGoal             = 6
        /// Target Value
        case targetValue            = 7
        /// Recurrence
        case recurrence             = 8
        /// Recurrence Value
        case recurrenceValue        = 9
        /// Enabled
        case enabled                = 10
        /// Goal Source
        case goalSource             = 11
    }
}

extension GoalMessage.FitCodingKeys: BaseTypeable {
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .messageIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .sport:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .subSport:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .startDate:
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .endDate:
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .goalType:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .goalValue:
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .repeatGoal:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .targetValue:
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .recurrence:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .recurrenceValue:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .enabled:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .goalSource:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension GoalMessage.FitCodingKeys: KeyedEncoder {}

// Encoding
internal extension GoalMessage.FitCodingKeys {

    func encodeKeyed(value: Goal) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    func encodeKeyed(value: GoalRecurrence) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }

    func encodeKeyed(value: GoalSource) -> Result<Data, FitEncodingError> {
        return self.baseData.type.encodedResolution(value: value.rawValue, resolution: self.baseData.resolution)
    }
}

extension GoalMessage.FitCodingKeys: KeyedEncoderSport {}

extension GoalMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
