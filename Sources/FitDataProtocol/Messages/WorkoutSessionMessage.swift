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
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutSessionMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 158 }

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
    private(set) public var poolLength: ValidatedMeasurement<UnitLength>?

    /// Pool Length Unit
    private(set) public var poolLengthUnit: MeasurementDisplayType?

    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                sport: Sport? = nil,
                subSport: SubSport? = nil,
                numberOfValidSteps: ValidatedBinaryInteger<UInt16>? = nil,
                firstStepIndex: ValidatedBinaryInteger<UInt16>? = nil,
                poolLength: ValidatedMeasurement<UnitLength>? = nil,
                poolLengthUnit: MeasurementDisplayType? = nil) {

        self.messageIndex = messageIndex
        self.sport = sport
        self.subSport = subSport
        self.numberOfValidSteps = numberOfValidSteps
        self.firstStepIndex = firstStepIndex
        self.poolLength = poolLength
        self.poolLengthUnit = poolLengthUnit
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: WorkoutSessionMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
        var messageIndex: MessageIndex?
        var sport: Sport?
        var subSport: SubSport?
        var numberOfValidSteps: ValidatedBinaryInteger<UInt16>?
        var firstStepIndex: ValidatedBinaryInteger<UInt16>?
        var poolLength: ValidatedMeasurement<UnitLength>?
        var poolLengthUnit: MeasurementDisplayType?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WorkoutSessionMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

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

                case .numberOfValidSteps:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    numberOfValidSteps = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                                  definition: definition,
                                                                                  dataStrategy: dataStrategy)

                case .firstStepIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    firstStepIndex = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                              definition: definition,
                                                                              dataStrategy: dataStrategy)

                case .poolLength:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(.removing, resolution: key.baseData.resolution)
                        poolLength = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        poolLength = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .poolLengthUnit:
                    poolLengthUnit = MeasurementDisplayType.decode(decoder: &localDecoder,
                                                                   definition: definition,
                                                                   data: fieldData,
                                                                   dataStrategy: dataStrategy)

                }
            }
        }

        let msg = WorkoutSessionMessage(messageIndex: messageIndex,
                                        sport: sport,
                                        subSport: subSport,
                                        numberOfValidSteps: numberOfValidSteps,
                                        firstStepIndex: firstStepIndex,
                                        poolLength: poolLength,
                                        poolLengthUnit: poolLengthUnit)
        
        let devData = self.decodeDeveloperData(data: fieldData, definition: definition)
        msg.developerData = devData.isEmpty ? nil : devData

        return.success(msg as! F)
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
            case .numberOfValidSteps:
                if let _ = numberOfValidSteps { fileDefs.append(key.fieldDefinition()) }
            case .firstStepIndex:
                if let _ = firstStepIndex { fileDefs.append(key.fieldDefinition()) }
            case .poolLength:
                if let _ = poolLength { fileDefs.append(key.fieldDefinition()) }
            case .poolLengthUnit:
                if let _ = poolLengthUnit { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: WorkoutSessionMessage.globalMessageNumber(),
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
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError>  {

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

            case .numberOfValidSteps:
                if let numberOfValidSteps = numberOfValidSteps {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: numberOfValidSteps)) {
                        return.failure(error)
                    }
                }

            case .firstStepIndex:
                if let firstStepIndex = firstStepIndex {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: firstStepIndex)) {
                        return.failure(error)
                    }
                }

            case .poolLength:
                if var poolLength = poolLength {
                    poolLength = poolLength.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: poolLength.value)) {
                        return.failure(error)
                    }
                }

            case .poolLengthUnit:
                if let poolLengthUnit = poolLengthUnit {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: poolLengthUnit)) {
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
