//
//  WorkoutStepMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
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

/// FIT Workout Step Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutStepMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 27 }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Workout Step Name
    private(set) public var name: String?

    /// Duration
    private(set) public var duration: ValidatedBinaryInteger<UInt32>?

    /// Durationm Type
    private(set) public var durationType: WorkoutStepDurationType?

    /// Target
    private(set) public var target: ValidatedBinaryInteger<UInt32>?

    /// Target Value Low
    private(set) public var targetLow: ValidatedBinaryInteger<UInt32>?

    /// Target Value High
    private(set) public var targetHigh: ValidatedBinaryInteger<UInt32>?

    /// Target Type
    private(set) public var targetType: WorkoutStepTargetType?

    /// Exercise Category
    private(set) public var category: ExerciseCategory?

    /// Intensity Level
    private(set) public var intensity: Intensity?

    /// Notes
    private(set) public var notes: String?

    /// Equipment
    private(set) public var equipment: WorkoutEquipment?


    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                name: String? = nil,
                duration: ValidatedBinaryInteger<UInt32>? = nil,
                durationType: WorkoutStepDurationType? = nil,
                target: ValidatedBinaryInteger<UInt32>? = nil,
                targetLow: ValidatedBinaryInteger<UInt32>? = nil,
                targetHigh: ValidatedBinaryInteger<UInt32>? = nil,
                targetType: WorkoutStepTargetType? = nil,
                category: ExerciseCategory? = nil,
                intensity: Intensity? = nil,
                notes: String? = nil,
                equipment: WorkoutEquipment? = nil) {

        self.messageIndex = messageIndex
        self.name = name
        self.duration = duration
        self.durationType = durationType
        self.target = target
        self.targetLow = targetLow
        self.targetHigh = targetHigh
        self.targetType = targetType
        self.category = category
        self.intensity = intensity
        self.notes = notes
        self.equipment = equipment
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitDecodingError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WorkoutStepMessage  {

        var messageIndex: MessageIndex?
        var name: String?
        var duration: ValidatedBinaryInteger<UInt32>?
        var durationType: WorkoutStepDurationType?
        var target: ValidatedBinaryInteger<UInt32>?
        var targetLow: ValidatedBinaryInteger<UInt32>?
        var targetHigh: ValidatedBinaryInteger<UInt32>?
        var targetType: WorkoutStepTargetType?
        var category: ExerciseCategory?
        var intensity: Intensity?
        var notes: String?
        var equipment: WorkoutEquipment?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WorkoutStepMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                case .stepName:
                    name = String.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .durationType:
                    durationType = WorkoutStepDurationType.decode(decoder: &localDecoder,
                                                                  definition: definition,
                                                                  data: fieldData,
                                                                  dataStrategy: dataStrategy)

                case .durationValue:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    duration = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                        definition: definition,
                                                                        dataStrategy: dataStrategy)

                case .targetType:
                    targetType = WorkoutStepTargetType.decode(decoder: &localDecoder,
                                                              definition: definition,
                                                              data: fieldData,
                                                              dataStrategy: dataStrategy)

                case .targetValue:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    target = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                      definition: definition,
                                                                      dataStrategy: dataStrategy)

                case .customTargetValueLow:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    targetLow = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .customTargetValueHigh:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    targetHigh = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                          definition: definition,
                                                                          dataStrategy: dataStrategy)

                case .intensity:
                    intensity = Intensity.decode(decoder: &localDecoder,
                                                 definition: definition,
                                                 data: fieldData,
                                                 dataStrategy: dataStrategy)

                case .notes:
                    notes = String.decode(decoder: &localDecoder,
                                          definition: definition,
                                          data: fieldData,
                                          dataStrategy: dataStrategy)

                case .equipment:
                    equipment = WorkoutEquipment.decode(decoder: &localDecoder,
                                                        definition: definition,
                                                        data: fieldData,
                                                        dataStrategy: dataStrategy)

                case .category:
                    category = ExerciseCategory.decode(decoder: &localDecoder,
                                                       definition: definition,
                                                       data: fieldData,
                                                       dataStrategy: dataStrategy)

                }
            }
        }

        return WorkoutStepMessage(messageIndex: messageIndex,
                                  name: name,
                                  duration: duration,
                                  durationType: durationType,
                                  target: target,
                                  targetLow: targetLow,
                                  targetHigh: targetHigh,
                                  targetType: targetType,
                                  category: category,
                                  intensity: intensity,
                                  notes: notes,
                                  equipment: equipment)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {

        do {
            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
        } catch let error as FitEncodingError {
            return.failure(error)
        } catch {
            return.failure(FitEncodingError.fileType(error.localizedDescription))
        }

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let _ = messageIndex { fileDefs.append(key.fieldDefinition()) }

            case .stepName:
                if let stringData = name?.data(using: .utf8) {
                    //16 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("name size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .durationType:
                if let _ = durationType { fileDefs.append(key.fieldDefinition()) }
            case .durationValue:
                if let _ = duration { fileDefs.append(key.fieldDefinition()) }
            case .targetType:
                if let _ = targetType { fileDefs.append(key.fieldDefinition()) }
            case .targetValue:
                if let _ = target { fileDefs.append(key.fieldDefinition()) }
            case .customTargetValueLow:
                if let _ = targetLow { fileDefs.append(key.fieldDefinition()) }
            case .customTargetValueHigh:
                if let _ = targetHigh { fileDefs.append(key.fieldDefinition()) }
            case .intensity:
                if let _ = intensity { fileDefs.append(key.fieldDefinition()) }
            case .notes:
                if let stringData = notes?.data(using: .utf8) {
                    //50 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("notes size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .equipment:
                if let _ = equipment { fileDefs.append(key.fieldDefinition()) }
            case .category:
                if let _ = category { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: WorkoutStepMessage.globalMessageNumber(),
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

            case .stepName:
                if let stepName = name {
                    if let stringData = stepName.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .durationType:
                if let durationType = durationType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: durationType)) {
                        return.failure(error)
                    }
                }

            case .durationValue:
                if let durationValue = duration {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: durationValue)) {
                        return.failure(error)
                    }
                }

            case .targetType:
                if let targetType = targetType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: targetType)) {
                        return.failure(error)
                    }
                }

            case .targetValue:
                if let targetValue = target {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: targetValue)) {
                        return.failure(error)
                    }
                }

            case .customTargetValueLow:
                if let targetLow = targetLow {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: targetLow)) {
                        return.failure(error)
                    }
                }

            case .customTargetValueHigh:
                if let targetHigh = targetHigh {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: targetHigh)) {
                        return.failure(error)
                    }
                }

            case .intensity:
                if let intensity = intensity {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: intensity)) {
                        return.failure(error)
                    }
                }

            case .notes:
                if let notes = notes {
                    if let stringData = notes.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .equipment:
                if let equipment = equipment {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: equipment)) {
                        return.failure(error)
                    }
                }

            case .category:
                if let category = category {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: category)) {
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

extension WorkoutStepMessage: MessageValidator {

    /// Validate Message
    ///
    /// - Parameters:
    ///   - fileType: FileType the Message is being used in
    ///   - dataValidityStrategy: Data Validity Strategy
    /// - Throws: FitError
    internal func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws {

        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:
            if fileType == FileType.workout {
                try validateWorkout()
            }
        case .garminConnect:
            break // do nothing
        }
    }

    private func validateWorkout() throws {

        let msg = "Workout Files"

        guard self.messageIndex != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutStepMessage to contain messageIndex, can not be nil")
        }

        guard self.durationType != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutStepMessage to contain durationType, can not be nil")
        }

        guard self.targetType != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutStepMessage to contain targetType, can not be nil")
        }

    }
}
