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

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WorkoutStepMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

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

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

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

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .stepName:
                if let stepName = name {
                    if let stringData = stepName.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .durationType:
                if let durationType = durationType {
                    msgData.append(durationType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .durationValue:
                if let durationValue = duration {
                    msgData.append(Data(from: durationValue.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .targetType:
                if let targetType = targetType {
                    msgData.append(targetType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .targetValue:
                if let targetValue = target {
                    msgData.append(Data(from: targetValue.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .customTargetValueLow:
                if let targetLow = targetLow {
                    msgData.append(Data(from: targetLow.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .customTargetValueHigh:
                if let targetHigh = targetHigh {
                    msgData.append(Data(from: targetHigh.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .intensity:
                if let intensity = intensity {
                    msgData.append(intensity.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .notes:
                if let notes = notes {
                    if let stringData = notes.data(using: .utf8) {
                        msgData.append(stringData)

                        //50 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .equipment:
                if let equipment = equipment {
                    msgData.append(equipment.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .category:
                if let category = category {
                    msgData.append(Data(from: category.rawValue.littleEndian))

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
                                               globalMessageNumber: WorkoutStepMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "WorkoutStepMessage contains no Properties Available to Encode"))
        }

    }

}
