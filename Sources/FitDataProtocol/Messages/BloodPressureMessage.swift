//
//  BloodPressureMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/22/18.
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

/// FIT Blood Pressure Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class BloodPressureMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 51
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Systolic Pressure
    private(set) public var systolicPressure: ValidatedMeasurement<UnitPressure>?

    /// Diastolic Pressure
    private(set) public var diastolicPressure: ValidatedMeasurement<UnitPressure>?

    /// Mean Arterial Pressure
    private(set) public var meanArterialPressure: ValidatedMeasurement<UnitPressure>?

    /// MAP 3 Sample Mean
    private(set) public var mapSampleMean: ValidatedMeasurement<UnitPressure>?

    /// MAP Morning Values
    private(set) public var mapMorningValues: ValidatedMeasurement<UnitPressure>?

    /// MAP Evening Values
    private(set) public var mapEveningValues: ValidatedMeasurement<UnitPressure>?

    /// Heart Rate
    private(set) public var heartRate: ValidatedMeasurement<UnitCadence>?

    /// Heart Rate Type
    private(set) public var heartRateType: HeartRateType?

    /// Blood Pressure Status
    private(set) public var status: BloodPressureStatus?

    /// User Profile Index
    ///
    /// Associates this blood pressure message to a user.  This corresponds to the index of the user profile message in the blood pressure file.
    private(set) public var userProfileIndex: MessageIndex?


    public required init() {}

    public init(timeStamp: FitTime?,
                systolicPressure: ValidatedMeasurement<UnitPressure>?,
                diastolicPressure: ValidatedMeasurement<UnitPressure>?,
                meanArterialPressure: ValidatedMeasurement<UnitPressure>?,
                mapSampleMean: ValidatedMeasurement<UnitPressure>?,
                mapMorningValues: ValidatedMeasurement<UnitPressure>?,
                mapEveningValues: ValidatedMeasurement<UnitPressure>?,
                heartRate: UInt8?,
                heartRateType: HeartRateType?,
                status: BloodPressureStatus?,
                userProfileIndex: MessageIndex? ) {

        self.timeStamp = timeStamp
        self.systolicPressure = systolicPressure
        self.diastolicPressure = diastolicPressure
        self.meanArterialPressure = meanArterialPressure
        self.mapSampleMean = mapSampleMean
        self.mapMorningValues = mapMorningValues
        self.mapEveningValues = mapEveningValues

        if let hr = heartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.heartRate.baseType)
            self.heartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }

        self.heartRateType = heartRateType
        self.status = status
        self.userProfileIndex = userProfileIndex
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> BloodPressureMessage  {

        var timeStamp: FitTime?
        var systolicPressure: ValidatedMeasurement<UnitPressure>?
        var diastolicPressure: ValidatedMeasurement<UnitPressure>?
        var meanArterialPressure: ValidatedMeasurement<UnitPressure>?
        var mapSampleMean: ValidatedMeasurement<UnitPressure>?
        var mapMorningValues: ValidatedMeasurement<UnitPressure>?
        var mapEveningValues: ValidatedMeasurement<UnitPressure>?
        var heartRate: UInt8?
        var heartRateType: HeartRateType?
        var status: BloodPressureStatus?
        var userProfileIndex: MessageIndex?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("BloodPressureMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .systolicPressure:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(1)
                        systolicPressure = ValidatedMeasurement(value: value, valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        systolicPressure = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .diastolicPressure:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(1)
                        diastolicPressure = ValidatedMeasurement(value: value, valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        diastolicPressure = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .meanArterialPressure:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(1)
                        meanArterialPressure = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        meanArterialPressure = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .mapSampleMean:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(1)
                        mapSampleMean = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        mapSampleMean = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .mapMorningValues:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(1)
                        mapMorningValues = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        mapMorningValues = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .mapEveningValues:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(1)
                        mapEveningValues = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        mapEveningValues = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .heartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        heartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            heartRate = value.value
                        } else {
                            heartRate = nil
                        }
                    }

                case .heartRateType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        heartRateType = HeartRateType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heartRateType = HeartRateType.invalid
                        }
                    }

                case .status:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        status = BloodPressureStatus(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            status = BloodPressureStatus.invalid
                        }
                    }

                case .userProfileIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        userProfileIndex = MessageIndex(value: value)
                    }
                    
                case .timestamp:
                    timeStamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                }
            }
        }

        return BloodPressureMessage(timeStamp: timeStamp,
                                    systolicPressure: systolicPressure,
                                    diastolicPressure: diastolicPressure,
                                    meanArterialPressure: meanArterialPressure,
                                    mapSampleMean: mapSampleMean,
                                    mapMorningValues: mapMorningValues,
                                    mapEveningValues: mapEveningValues,
                                    heartRate: heartRate,
                                    heartRateType: heartRateType,
                                    status: status,
                                    userProfileIndex: userProfileIndex)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .systolicPressure:
                if var systolicPressure = systolicPressure {
                    // 1 * mmHg + 0
                    systolicPressure = systolicPressure.converted(to: UnitPressure.millimetersOfMercury)
                    let value = systolicPressure.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .diastolicPressure:
                if var diastolicPressure = diastolicPressure {
                    // 1 * mmHg + 0
                    diastolicPressure = diastolicPressure.converted(to: UnitPressure.millimetersOfMercury)
                    let value = diastolicPressure.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .meanArterialPressure:
                if var meanArterialPressure = meanArterialPressure {
                    // 1 * mmHg + 0
                    meanArterialPressure = meanArterialPressure.converted(to: UnitPressure.millimetersOfMercury)
                    let value = meanArterialPressure.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .mapSampleMean:
                if var mapSampleMean = mapSampleMean {
                    // 1 * mmHg + 0
                    mapSampleMean = mapSampleMean.converted(to: UnitPressure.millimetersOfMercury)
                    let value = mapSampleMean.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .mapMorningValues:
                if var mapMorningValues = mapMorningValues {
                    // 1 * mmHg + 0
                    mapMorningValues = mapMorningValues.converted(to: UnitPressure.millimetersOfMercury)
                    let value = mapMorningValues.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .mapEveningValues:
                if var mapEveningValues = mapEveningValues {
                    // 1 * mmHg + 0
                    mapEveningValues = mapEveningValues.converted(to: UnitPressure.millimetersOfMercury)
                    let value = mapEveningValues.value.resolutionUInt16(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .heartRate:
                if let heartRate = heartRate {
                    // 1 * bpm + 0
                    let value = heartRate.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .heartRateType:
                if let heartRateType = heartRateType {
                    msgData.append(heartRateType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .status:
                if let status = status {
                    msgData.append(status.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .userProfileIndex:
                if let userProfileIndex = userProfileIndex {
                    msgData.append(userProfileIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())

                    fileDefs.append(key.fieldDefinition())
                }
            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: BloodPressureMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "BloodPressureMessage contains no Properties Available to Encode"))
        }
    }

}
