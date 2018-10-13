//
//  MetZoneMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/25/18.
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

/// FIT MET Zone Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class MetZoneMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 10
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Heart Rate High Level
    private(set) public var heartRate: ValidatedMeasurement<UnitCadence>?

    /// Calories per Minute
    private(set) public var calories: ValidatedMeasurement<UnitEnergy>?

    /// Fat Calories per Minute
    private(set) public var fatCalories: ValidatedMeasurement<UnitEnergy>?

    public required init() {}

    public init(messageIndex: MessageIndex?,
                heartRate: UInt8?,
                calories: ValidatedMeasurement<UnitEnergy>?,
                fatCalories: ValidatedMeasurement<UnitEnergy>?) {

        self.messageIndex = messageIndex

        if let hr = heartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.heartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.heartRate = nil
        }

        self.calories = calories
        self.fatCalories = fatCalories
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> MetZoneMessage  {

        var messageIndex: MessageIndex?
        var heartRate: UInt8?
        var calories: ValidatedMeasurement<UnitEnergy>?
        var fatCalories: ValidatedMeasurement<UnitEnergy>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("HeartRateZoneMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .highBpm:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        heartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .calories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 10 * kcal / min + 0
                        let value = value.resolution(1 / 10)
                        calories = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            calories = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .fatCalories:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 10 * kcal / min + 0
                        let value = value.resolution(1 / 10)
                        fatCalories = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            fatCalories = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .messageIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

                }
            }
        }

        return MetZoneMessage(messageIndex: messageIndex,
                              heartRate: heartRate,
                              calories: calories,
                              fatCalories: fatCalories)
    }
}
