//
//  WorkoutMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
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
import AntMessageProtocol

/// FIT Workout Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 26
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Workout Name
    private(set) public var workoutName: String?

    /// Number of Valid Steps
    private(set) public var numberOfValidSteps: UInt16?

    /// Pool Length
    private(set) public var poolLength: Measurement<UnitLength>?

    /// Pool Lenght Unit
    private(set) public var poolLenghtUnit: MeasurementDisplayType?

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    public required init() {}

    public init(timeStamp: FitTime?, workoutName: String?, numberOfValidSteps: UInt16?, poolLength: Measurement<UnitLength>?, poolLenghtUnit: MeasurementDisplayType?, sport: Sport?, subSport: SubSport?) {

        self.timeStamp = timeStamp
        self.workoutName = workoutName
        self.numberOfValidSteps = numberOfValidSteps
        self.poolLength = poolLength
        self.poolLenghtUnit = poolLenghtUnit
        self.sport = sport
        self.subSport = subSport
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WorkoutMessage  {

        var timestamp: FitTime?
        var workoutName: String?
        var numberOfValidSteps: UInt16?
        var poolLength: Measurement<UnitLength>?
        var poolLenghtUnit: MeasurementDisplayType?
        var sport: Sport?
        var subSport: SubSport?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .sport:
                    let value = localDecoder.decodeUInt8()
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

                case .capabilities:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .numberOfValidSteps:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        numberOfValidSteps = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            numberOfValidSteps = UInt16(definition.baseType.invalid)
                        }
                    }

                case .workoutName:
                    let stringData = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        workoutName = stringData.smartString
                    }

                case .subSport:
                    let value = localDecoder.decodeUInt8()
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

                case .poolLength:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  100 * m + 0
                        let value = Double(value) / 100
                        poolLength = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            poolLength = Measurement(value: Double(UInt16(definition.baseType.invalid)), unit: UnitLength.meters)
                        }
                    }

                case .poolLenghtUnit:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        poolLenghtUnit = MeasurementDisplayType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            poolLenghtUnit = MeasurementDisplayType.invalid
                        }
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

                }
            }
        }

        return WorkoutMessage(timeStamp: timestamp,
                              workoutName: workoutName,
                              numberOfValidSteps: numberOfValidSteps,
                              poolLength: poolLength,
                              poolLenghtUnit: poolLenghtUnit,
                              sport: sport,
                              subSport: subSport)
    }
}


@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension WorkoutMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    public enum MessageKeys: Int, CodingKey {
        case sport                  = 4
        case capabilities           = 5
        case numberOfValidSteps     = 6
        case workoutName            = 8
        case subSport               = 11
        case poolLength             = 14
        case poolLenghtUnit         = 15

        case timestamp              = 253
    }
}
