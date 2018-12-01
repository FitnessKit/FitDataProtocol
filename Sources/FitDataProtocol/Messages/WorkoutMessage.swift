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
import FitnessUnits
import AntMessageProtocol

/// FIT Workout Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 26 }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Workout Name
    private(set) public var workoutName: String?

    /// Number of Valid Steps
    private(set) public var numberOfValidSteps: ValidatedBinaryInteger<UInt16>?

    /// Pool Length
    private(set) public var poolLength: ValidatedMeasurement<UnitLength>?

    /// Pool Length Unit
    private(set) public var poolLengthUnit: MeasurementDisplayType?

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    public required init() {}

    public init(timeStamp: FitTime? = nil,
                messageIndex: MessageIndex? = nil,
                workoutName: String? = nil,
                numberOfValidSteps: ValidatedBinaryInteger<UInt16>? = nil,
                poolLength: ValidatedMeasurement<UnitLength>? = nil,
                poolLengthUnit: MeasurementDisplayType? = nil,
                sport: Sport? = nil,
                subSport: SubSport? = nil) {

        self.timeStamp = timeStamp
        self.messageIndex = messageIndex
        self.workoutName = workoutName
        self.numberOfValidSteps = numberOfValidSteps
        self.poolLength = poolLength
        self.poolLengthUnit = poolLengthUnit
        self.sport = sport
        self.subSport = subSport
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WorkoutMessage  {

        var timestamp: FitTime?
        var messageIndex: MessageIndex?
        var workoutName: String?
        var numberOfValidSteps: ValidatedBinaryInteger<UInt16>?
        var poolLength: ValidatedMeasurement<UnitLength>?
        var poolLengthUnit: MeasurementDisplayType?
        var sport: Sport?
        var subSport: SubSport?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WorkoutMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .sport:
                    sport = Sport.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .capabilities:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .numberOfValidSteps:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    numberOfValidSteps = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                                  definition: definition,
                                                                                  dataStrategy: dataStrategy)

                case .workoutName:
                    workoutName = String.decode(decoder: &localDecoder,
                                                definition: definition,
                                                data: fieldData,
                                                dataStrategy: dataStrategy)

                case .subSport:
                    subSport = SubSport.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

                case .poolLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        //  100 * m + 0
                        let value = value.resolution(1 / 100)
                        poolLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        poolLength = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .poolLengthUnit:
                    poolLengthUnit = MeasurementDisplayType.decode(decoder: &localDecoder, definition: definition, data: fieldData, dataStrategy: dataStrategy)

                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        return WorkoutMessage(timeStamp: timestamp,
                              messageIndex: messageIndex,
                              workoutName: workoutName,
                              numberOfValidSteps: numberOfValidSteps,
                              poolLength: poolLength,
                              poolLengthUnit: poolLengthUnit,
                              sport: sport,
                              subSport: subSport)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .sport:
                if let sport = sport {
                    msgData.append(sport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .capabilities:
                break
                
            case .numberOfValidSteps:
                if let numberOfValidSteps = numberOfValidSteps {
                    msgData.append(Data(from: numberOfValidSteps.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .workoutName:
                if let workoutName = workoutName {
                    if let stringData = workoutName.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .subSport:
                if let subSport = subSport {
                    msgData.append(subSport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .poolLength:
                if var poolLength = poolLength {
                    // 100 * m + 0
                    poolLength = poolLength.converted(to: UnitLength.meters)
                    let value = poolLength.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .poolLengthUnit:
                if let poolLengthUnit = poolLengthUnit {
                    msgData.append(poolLengthUnit.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())

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
                                               globalMessageNumber: WorkoutMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "WorkoutMessage contains no Properties Available to Encode"))
        }
    }
}
