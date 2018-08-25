//
//  GoalMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/18.
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
import DataDecoder
import FitnessUnits
import AntMessageProtocol

/// FIT Stride Based Speed and Distance Monitor (SDM) Profile Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class GoalMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 15
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Start Date
    private(set) public var startDate: FitTime?

    /// End Date
    private(set) public var endDate: FitTime?

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    /// Goal Type
    private(set) public var goalType: Goal?

    /// Goal Value
    private(set) public var goalValue: ValidatedBinaryInteger<UInt32>?

    /// Repeat Goal
    private(set) public var repeatGoal: Bool?

    /// Goal Target Value
    private(set) public var targetValue: ValidatedBinaryInteger<UInt32>?

    /// Goals Recurrence
    private(set) public var recurrence: GoalRecurrence?

    /// Goal Recurrence Value
    private(set) public var recurrenceValue: ValidatedBinaryInteger<UInt16>?

    /// Goal Enabled
    private(set) public var enabled: Bool?

    /// Goal Source
    private(set) public var source: GoalSource?


    public required init() {}

    public init(messageIndex: MessageIndex?,
                startDate: FitTime?,
                endDate: FitTime?,
                sport: Sport?,
                subSport: SubSport?,
                goalType: Goal?,
                goalValue: UInt32?,
                repeatGoal: Bool?,
                targetValue: ValidatedBinaryInteger<UInt32>?,
                recurrence: GoalRecurrence?,
                recurrenceValue: ValidatedBinaryInteger<UInt16>?,
                enabled: Bool?,
                source: GoalSource?) {
        
        self.messageIndex = messageIndex
        self.startDate = startDate
        self.endDate = endDate
        self.sport = sport
        self.subSport = subSport
        self.goalType = goalType

        if let goalValue = goalValue {

            let valid = !(Int64(goalValue) == BaseType.uint32.invalid)
            self.goalValue = ValidatedBinaryInteger(value: goalValue, valid: valid)

        } else {
            self.goalValue = nil
        }


        self.repeatGoal = repeatGoal
        self.targetValue = targetValue
        self.recurrence = recurrence
        self.recurrenceValue = recurrenceValue
        self.enabled = enabled
        self.source = source
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> GoalMessage  {

        var messageIndex: MessageIndex?
        var startDate: FitTime?
        var endDate: FitTime?
        var sport: Sport?
        var subSport: SubSport?
        var goalType: Goal?
        var goalValue: UInt32?
        var repeatGoal: Bool?
        var targetValue: ValidatedBinaryInteger<UInt32>?
        var recurrence: GoalRecurrence?
        var recurrenceValue: ValidatedBinaryInteger<UInt16>?
        var enabled: Bool?
        var source: GoalSource?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("GoalMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .sport:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        sport = Sport(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            sport = Sport.invalid
                        }
                    }

                case .subSport:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        subSport = SubSport(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            subSport = SubSport.invalid
                        }
                    }

                case .startDate:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        startDate = FitTime(time: value, isLocal: true)
                    }

                case .endDate:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        endDate = FitTime(time: value, isLocal: true)
                    }

                case .goalType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        goalType = Goal(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            goalType = Goal.invalid
                        }
                    }

                case .goalValue:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        goalValue = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            goalValue = UInt32(definition.baseType.invalid)
                        }
                    }

                case .repeatGoal:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        repeatGoal = value.boolValue
                    }

                case .targetValue:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        targetValue = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            targetValue = ValidatedBinaryInteger(value: UInt32(definition.baseType.invalid), valid: false)
                        }
                    }

                case .recurrence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        recurrence = GoalRecurrence(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            recurrence = GoalRecurrence.invalid
                        }
                    }

                case .recurrenceValue:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        recurrenceValue = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            recurrenceValue = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }


                case .enabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        enabled = value.boolValue
                    }

                case .goalSource:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        source = GoalSource(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            source = GoalSource.invalid
                        }
                    }


                case .messageIndex:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

                }
            }
        }

        return GoalMessage(messageIndex: messageIndex,
                           startDate: startDate,
                           endDate: endDate,
                           sport: sport,
                           subSport: subSport,
                           goalType: goalType,
                           goalValue: goalValue,
                           repeatGoal: repeatGoal,
                           targetValue: targetValue,
                           recurrence: recurrence,
                           recurrenceValue: recurrenceValue,
                           enabled: enabled,
                           source: source)
    }
}
