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
    public override class func globalMessageNumber() -> UInt16 { return 15 }

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

    public init(messageIndex: MessageIndex? = nil,
                startDate: FitTime? = nil,
                endDate: FitTime? = nil,
                sport: Sport? = nil,
                subSport: SubSport? = nil,
                goalType: Goal? = nil,
                goalValue: UInt32? = nil,
                repeatGoal: Bool? = nil,
                targetValue: ValidatedBinaryInteger<UInt32>? = nil,
                recurrence: GoalRecurrence? = nil,
                recurrenceValue: ValidatedBinaryInteger<UInt16>? = nil,
                enabled: Bool? = nil,
                source: GoalSource? = nil) {
        
        self.messageIndex = messageIndex
        self.startDate = startDate
        self.endDate = endDate
        self.sport = sport
        self.subSport = subSport
        self.goalType = goalType

        if let goalValue = goalValue {
            let valid = goalValue.isValidForBaseType(FitCodingKeys.goalValue.baseType)
            self.goalValue = ValidatedBinaryInteger(value: goalValue, valid: valid)
        }

        self.repeatGoal = repeatGoal
        self.targetValue = targetValue
        self.recurrence = recurrence
        self.recurrenceValue = recurrenceValue
        self.enabled = enabled
        self.source = source
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
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

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("GoalMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

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
                    goalType = Goal.decode(decoder: &localDecoder,
                                           definition: definition,
                                           data: fieldData,
                                           dataStrategy: dataStrategy)

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
                    targetValue = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                           definition: definition,
                                                                           dataStrategy: dataStrategy)

                case .recurrence:
                    recurrence = GoalRecurrence.decode(decoder: &localDecoder,
                                                       definition: definition,
                                                       data: fieldData,
                                                       dataStrategy: dataStrategy)

                case .recurrenceValue:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    recurrenceValue = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                               definition: definition,
                                                                               dataStrategy: dataStrategy)

                case .enabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        enabled = value.boolValue
                    }

                case .goalSource:
                    source = GoalSource.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

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

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {

//        do {
//            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
//        } catch let error as FitEncodingError {
//            return.failure(error)
//        } catch {
//            return.failure(FitEncodingError.fileType(error.localizedDescription))
//        }

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let _ = messageIndex { fileDefs.append(key.fieldDefinition()) }

            case .sport:
                if let _ = sport { fileDefs.append(key.fieldDefinition()) }
            case .subSport:
                if let _ = subSport { fileDefs.append(key.fieldDefinition()) }
            case .startDate:
                if let _ = startDate { fileDefs.append(key.fieldDefinition()) }
            case .endDate:
                if let _ = endDate { fileDefs.append(key.fieldDefinition()) }
            case .goalType:
                if let _ = goalType { fileDefs.append(key.fieldDefinition()) }
            case .goalValue:
                if let _ = goalValue { fileDefs.append(key.fieldDefinition()) }
            case .repeatGoal:
                if let _ = repeatGoal { fileDefs.append(key.fieldDefinition()) }
            case .targetValue:
                if let _ = recurrenceValue { fileDefs.append(key.fieldDefinition()) }
            case .recurrence:
                if let _ = recurrence { fileDefs.append(key.fieldDefinition()) }
            case .recurrenceValue:
                if let _ = recurrenceValue { fileDefs.append(key.fieldDefinition()) }
            case .enabled:
                if let _ = enabled { fileDefs.append(key.fieldDefinition()) }
            case .goalSource:
                if let _ = source { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: GoalMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return.success(defMessage)
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data Result
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            return.failure(self.encodeWrongDefinitionMessage())
        }

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())
                }

            case .sport:
                if let sport = sport {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: sport)) {
                        return.failure(error)
                    }
                }

            case .subSport:
                if let subSport = subSport {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: subSport)) {
                        return.failure(error)
                    }
                }

            case .startDate:
                if let startDate = startDate {
                    msgData.append(startDate.encode())
                }

            case .endDate:
                if let endDate = endDate {
                    msgData.append(endDate.encode())
                }

            case .goalType:
                if let goalType = goalType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: goalType)) {
                        return.failure(error)
                    }
                }

            case .goalValue:
                if let goalValue = goalValue {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: goalValue)) {
                        return.failure(error)
                    }
                }

            case .repeatGoal:
                if let repeatGoal = repeatGoal {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: repeatGoal)) {
                        return.failure(error)
                    }
                }

            case .targetValue:
                if let targetValue = targetValue {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: targetValue)) {
                        return.failure(error)
                    }
                }

            case .recurrence:
                if let recurrence = recurrence {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: recurrence)) {
                        return.failure(error)
                    }
                }

            case .recurrenceValue:
                if let recurrenceValue = recurrenceValue {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: recurrenceValue)) {
                        return.failure(error)
                    }
                }

            case .enabled:
                if let enabled = enabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: enabled)) {
                        return.failure(error)
                    }
                }

            case .goalSource:
                if let goalSource = source {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: goalSource)) {
                        return.failure(error)
                    }
                }

            }
        }

        if msgData.message.count > 0 {
            return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData.message))
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }
}
