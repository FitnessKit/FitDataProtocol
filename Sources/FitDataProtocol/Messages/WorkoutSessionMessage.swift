//
//  WorkoutSessionMessage.swift
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
import DataDecoder
import FitnessUnits
import AntMessageProtocol

/// FIT Workout Session Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutSessionMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 158
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    /// Number of Valid Steps
    private(set) public var numberOfValidSteps: ValidatedBinaryInteger<UInt16>?

    /// First Step Index
    private(set) public var firstStepIndex: ValidatedBinaryInteger<UInt16>?

    /// Pool Length
    private(set) public var poolLength: Measurement<UnitLength>?

    /// Pool Length Unit
    private(set) public var poolLengthUnit: MeasurementDisplayType?

    public required init() {}

    public init(messageIndex: MessageIndex?,
                sport: Sport?,
                subSport: SubSport?,
                numberOfValidSteps: ValidatedBinaryInteger<UInt16>?,
                firstStepIndex: ValidatedBinaryInteger<UInt16>?,
                poolLength: Measurement<UnitLength>?,
                poolLengthUnit: MeasurementDisplayType?) {

        self.messageIndex = messageIndex
        self.sport = sport
        self.subSport = subSport
        self.numberOfValidSteps = numberOfValidSteps
        self.firstStepIndex = firstStepIndex
        self.poolLength = poolLength
        self.poolLengthUnit = poolLengthUnit
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WorkoutSessionMessage  {

        var messageIndex: MessageIndex?
        var sport: Sport?
        var subSport: SubSport?
        var numberOfValidSteps: ValidatedBinaryInteger<UInt16>?
        var firstStepIndex: ValidatedBinaryInteger<UInt16>?
        var poolLength: Measurement<UnitLength>?
        var poolLengthUnit: MeasurementDisplayType?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WorkoutSessionMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

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

                case .numberOfValidSteps:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        numberOfValidSteps = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            numberOfValidSteps = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .firstStepIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        firstStepIndex = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            firstStepIndex = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .poolLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        poolLength = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            poolLength = Measurement(value: Double(UInt16(definition.baseType.invalid)), unit: UnitLength.meters)
                        }
                    }

                case .poolLengthUnit:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        poolLengthUnit = MeasurementDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            poolLengthUnit = MeasurementDisplayType.invalid
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

        return WorkoutSessionMessage(messageIndex: messageIndex,
                                     sport: sport,
                                     subSport: subSport,
                                     numberOfValidSteps: numberOfValidSteps,
                                     firstStepIndex: firstStepIndex,
                                     poolLength: poolLength,
                                     poolLengthUnit: poolLengthUnit)
    }
}
