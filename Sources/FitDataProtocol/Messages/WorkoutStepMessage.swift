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

/// FIT File Creator Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutStepMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 27
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Workout Step Name
    private(set) public var name: String?

    /// Duration
    private(set) public var duration: UInt32?

    /// Durationm Type
    private(set) public var durationType: WorkoutStepDurationType?

    /// Target
    private(set) public var target: UInt32?

    /// Target Value Low
    private(set) public var targetLow: UInt32?

    /// Target Value High
    private(set) public var targetHigh: UInt32?

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

    public init(messageIndex: MessageIndex?, name: String?, duration: UInt32?, durationType: WorkoutStepDurationType?, target: UInt32?, targetLow: UInt32?, targetHigh: UInt32?, targetType: WorkoutStepTargetType?, category: ExerciseCategory?, intensity: Intensity?, notes: String?, equipment: WorkoutEquipment?) {

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
        var duration: UInt32?
        var durationType: WorkoutStepDurationType?
        var target: UInt32?
        var targetLow: UInt32?
        var targetHigh: UInt32?
        var targetType: WorkoutStepTargetType?
        var category: ExerciseCategory?
        var intensity: Intensity?
        var notes: String?
        var equipment: WorkoutEquipment?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("WorkoutStepMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .stepName:
                    let stringData = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        name = stringData.smartString
                    }

                case .durationType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        durationType = WorkoutStepDurationType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            durationType = WorkoutStepDurationType.invalid
                        }
                    }

                case .durationValue:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        duration = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            duration = UInt32(definition.baseType.invalid)
                        }
                    }

                case .targetType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        targetType = WorkoutStepTargetType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            targetType = WorkoutStepTargetType.invalid
                        }
                    }

                case .targetValue:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        target = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            target = UInt32(definition.baseType.invalid)
                        }
                    }

                case .customTargetValueLow:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        targetLow = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            targetLow = UInt32(definition.baseType.invalid)
                        }
                    }

                case .customTargetValueHigh:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        targetHigh = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            targetHigh = UInt32(definition.baseType.invalid)
                        }
                    }

                case .intensity:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        intensity = Intensity(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            intensity = Intensity.invalid
                        }
                    }

                case .notes:
                    let stringData = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        notes = stringData.smartString
                    }

                case .equipment:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        equipment = WorkoutEquipment(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            equipment = WorkoutEquipment.invalid
                        }
                    }

                case .category:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        category = ExerciseCategory(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            category = ExerciseCategory.invalid
                        }
                    }

                case .messageIndex:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

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
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension WorkoutStepMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case stepName               = 0
        case durationType           = 1
        case durationValue          = 2
        case targetType             = 3
        case targetValue            = 4
        case customTargetValueLow   = 5
        case customTargetValueHigh  = 6
        case intensity              = 7
        case notes                  = 8
        case equipment              = 9
        case category               = 10

        case messageIndex           = 254
    }
}
