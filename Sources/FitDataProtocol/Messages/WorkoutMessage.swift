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

    public init(workoutName: String? = nil,
                numberOfValidSteps: ValidatedBinaryInteger<UInt16>? = nil,
                poolLength: ValidatedMeasurement<UnitLength>? = nil,
                poolLengthUnit: MeasurementDisplayType? = nil,
                sport: Sport? = nil,
                subSport: SubSport? = nil) {

        self.workoutName = workoutName
        self.numberOfValidSteps = numberOfValidSteps
        self.poolLength = poolLength
        self.poolLengthUnit = poolLengthUnit
        self.sport = sport
        self.subSport = subSport
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WorkoutMessage  {

        var workoutName: String?
        var numberOfValidSteps: ValidatedBinaryInteger<UInt16>?
        var poolLength: ValidatedMeasurement<UnitLength>?
        var poolLengthUnit: MeasurementDisplayType?
        var sport: Sport?
        var subSport: SubSport?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WorkoutMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
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
                        let value = value.resolution(.removing, resolution: key.resolution)
                        poolLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        poolLength = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .poolLengthUnit:
                    poolLengthUnit = MeasurementDisplayType.decode(decoder: &localDecoder, definition: definition, data: fieldData, dataStrategy: dataStrategy)

                }
            }
        }

        return WorkoutMessage(workoutName: workoutName,
                              numberOfValidSteps: numberOfValidSteps,
                              poolLength: poolLength,
                              poolLengthUnit: poolLengthUnit,
                              sport: sport,
                              subSport: subSport)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError>  {

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
            case .sport:
                if let _ = sport { fileDefs.append(key.fieldDefinition()) }
            case .capabilities:
                break
            case .numberOfValidSteps:
                if let _ = numberOfValidSteps { fileDefs.append(key.fieldDefinition()) }
            case .workoutName:
                if let stringData = workoutName?.data(using: .utf8) {
                    //16 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("workoutName size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .subSport:
                if let _ = subSport { fileDefs.append(key.fieldDefinition()) }
            case .poolLength:
                if let _ = poolLength { fileDefs.append(key.fieldDefinition()) }
            case .poolLengthUnit:
                if let _ = poolLengthUnit { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: WorkoutMessage.globalMessageNumber(),
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
    /// - Returns: Data representation
    /// - Throws: FitError
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) throws -> Data {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            throw self.encodeWrongDefinitionMessage()
        }

        var msgData = Data()

        for key in FitCodingKeys.allCases {

            switch key {
            case .sport:
                if let sport = sport {
                    let valueData = try key.encodeKeyed(value: sport).get()
                    msgData.append(valueData)
                }

            case .capabilities:
                break
                
            case .numberOfValidSteps:
                if let numberOfValidSteps = numberOfValidSteps {
                    let valueData = try key.encodeKeyed(value: numberOfValidSteps).get()
                    msgData.append(valueData)
                }

            case .workoutName:
                if let workoutName = workoutName {
                    if let stringData = workoutName.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .subSport:
                if let subSport = subSport {
                    let valueData = try key.encodeKeyed(value: subSport).get()
                    msgData.append(valueData)
                }

            case .poolLength:
                if var poolLength = poolLength {
                    poolLength = poolLength.converted(to: UnitLength.meters)
                    let valueData = try key.encodeKeyed(value: poolLength.value).get()
                    msgData.append(valueData)
                }

            case .poolLengthUnit:
                if let poolLengthUnit = poolLengthUnit {
                    let valueData = try key.encodeKeyed(value: poolLengthUnit).get()
                    msgData.append(valueData)
                }

            }
        }

        if msgData.count > 0 {
            return encodedDataMessage(localMessageType: localMessageType, msgData: msgData)
        } else {
            throw self.encodeNoPropertiesAvailable()
        }
    }
}

extension WorkoutMessage: MessageValidator {

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

        guard self.numberOfValidSteps != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutMessage to contain numberOfValidSteps, can not be nil")
        }

    }
}
