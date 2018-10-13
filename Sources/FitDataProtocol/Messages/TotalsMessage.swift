//
//  TotalsMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/29/18.
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

/// FIT Totals Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class TotalsMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 33
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Timer Time
    ///
    /// Excludes pauses
    private(set) public var timerTime: Measurement<UnitDuration>?

    /// Distance
    private(set) public var distance: ValidatedMeasurement<UnitLength>?

    /// Calories
    private(set) public var calories: ValidatedMeasurement<UnitEnergy>?

    /// Sport
    private(set) public var sport: Sport?

    /// Elapsed Time
    ///
    /// Includes pauses
    private(set) public var elapsedTime: Measurement<UnitDuration>?

    /// Sessions
    private(set) public var sessions: ValidatedBinaryInteger<UInt16>?

    /// Active Time
    private(set) public var activeTime: Measurement<UnitDuration>?


    public required init() {}

    public init(timeStamp: FitTime?,
                messageIndex: MessageIndex?,
                timerTime: Measurement<UnitDuration>?,
                distance: ValidatedMeasurement<UnitLength>?,
                calories: ValidatedMeasurement<UnitEnergy>?,
                sport: Sport?,
                elapsedTime: Measurement<UnitDuration>?,
                sessions: ValidatedBinaryInteger<UInt16>?,
                activeTime: Measurement<UnitDuration>?) {
        
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex
        self.timerTime = timerTime
        self.distance = distance
        self.calories = calories
        self.sport = sport
        self.elapsedTime = elapsedTime
        self.sessions = sessions
        self.activeTime = activeTime

    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> TotalsMessage  {

        var timeStamp: FitTime?
        var messageIndex: MessageIndex?
        var timerTime: Measurement<UnitDuration>?
        var distance: ValidatedMeasurement<UnitLength>?
        var calories: ValidatedMeasurement<UnitEnergy>?
        var sport: Sport?
        var elapsedTime: Measurement<UnitDuration>?
        var sessions: ValidatedBinaryInteger<UInt16>?
        var activeTime: Measurement<UnitDuration>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("TotalsMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .timerTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * s + 0
                        let value = value.resolution(1)
                        timerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .distance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * m + 0
                        let value = value.resolution(1)
                        distance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            distance = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .calories:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * kcal + 0
                        calories = ValidatedMeasurement(value: Double(value), valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            calories = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

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

                case .elapsedTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * s + 0
                        let value = value.resolution(1)
                        elapsedTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .sessions:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        sessions = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            sessions = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .activeTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * s + 0
                        let value = value.resolution(1)
                        activeTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .timestamp:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        timeStamp = FitTime(time: value)
                    }
                    
                case .messageIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

                }

            }
        }

        return TotalsMessage(timeStamp: timeStamp,
                             messageIndex: messageIndex,
                             timerTime: timerTime,
                             distance: distance,
                             calories: calories,
                             sport: sport,
                             elapsedTime: elapsedTime,
                             sessions: sessions,
                             activeTime: activeTime)
    }
}
