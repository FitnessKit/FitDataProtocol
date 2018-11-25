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
@available(swift 4.2)
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
            let valid = goalValue.isValidForBaseType(FitCodingKeys.goalValue.baseType)
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
                    sport = Sport.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .subSport:
                    subSport = SubSport.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

                case .startDate:
                    startDate = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData,
                                               isLocal: true)


                case .endDate:
                    endDate = FitTime.decode(decoder: &localDecoder,
                                             endian: arch,
                                             definition: definition,
                                             data: fieldData,
                                             isLocal: true)

                case .goalType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
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
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        goalValue = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt32>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            goalValue = value.value
                        } else {
                            goalValue = nil
                        }
                    }

                case .repeatGoal:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        repeatGoal = value.boolValue
                    }

                case .targetValue:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        targetValue = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        targetValue = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .recurrence:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
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
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        recurrenceValue = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        recurrenceValue = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }


                case .enabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        enabled = value.boolValue
                    }

                case .goalSource:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
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
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

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

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode() throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .sport:
                if let sport = sport {
                    msgData.append(sport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .subSport:
                if let subSport = subSport {
                    msgData.append(subSport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .startDate:
                if let startDate = startDate {
                    msgData.append(startDate.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .endDate:
                if let endDate = endDate {
                    msgData.append(endDate.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .goalType:
                if let goalType = goalType {
                    msgData.append(goalType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .goalValue:
                if let goalValue = goalValue {
                    msgData.append(Data(from: goalValue.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .repeatGoal:
                if let enabled = enabled {
                    msgData.append(enabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .targetValue:
                if let recurrenceValue = recurrenceValue {
                    msgData.append(Data(from: recurrenceValue.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .recurrence:
                if let recurrence = recurrence {
                    msgData.append(recurrence.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .recurrenceValue:
                if let recurrenceValue = recurrenceValue {
                    msgData.append(Data(from: recurrenceValue.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .enabled:
                if let enabled = enabled {
                    msgData.append(enabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .goalSource:
                if let goalSource = source {
                    msgData.append(goalSource.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: GoalMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            var encodedMsg = Data()

            let defHeader = RecordHeader(localMessageType: 0, isDataMessage: false)
            encodedMsg.append(defHeader.normalHeader)
            encodedMsg.append(defMessage.encode())

            let recHeader = RecordHeader(localMessageType: 0, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "GoalMessage contains no Properties Available to Encode"))
        }
    }

}
