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
    public override class func globalMessageNumber() -> UInt16 { return 51 }

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

    public init(timeStamp: FitTime? = nil,
                systolicPressure: ValidatedMeasurement<UnitPressure>? = nil,
                diastolicPressure: ValidatedMeasurement<UnitPressure>? = nil,
                meanArterialPressure: ValidatedMeasurement<UnitPressure>? = nil,
                mapSampleMean: ValidatedMeasurement<UnitPressure>? = nil,
                mapMorningValues: ValidatedMeasurement<UnitPressure>? = nil,
                mapEveningValues: ValidatedMeasurement<UnitPressure>? = nil,
                heartRate: UInt8? = nil,
                heartRateType: HeartRateType? = nil,
                status: BloodPressureStatus? = nil,
                userProfileIndex: MessageIndex? = nil) {

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

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
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

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("BloodPressureMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .timestamp:
                    timeStamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                case .systolicPressure:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        systolicPressure = ValidatedMeasurement(value: value, valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        systolicPressure = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .diastolicPressure:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        diastolicPressure = ValidatedMeasurement(value: value, valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        diastolicPressure = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .meanArterialPressure:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        meanArterialPressure = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        meanArterialPressure = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .mapSampleMean:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        mapSampleMean = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        mapSampleMean = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .mapMorningValues:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        mapMorningValues = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {
                        mapMorningValues = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPressure.millimetersOfMercury)
                    }

                case .mapEveningValues:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * mmHg + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
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
                    heartRateType = HeartRateType.decode(decoder: &localDecoder,
                                                         definition: definition,
                                                         data: fieldData,
                                                         dataStrategy: dataStrategy)

                case .status:
                    status = BloodPressureStatus.decode(decoder: &localDecoder,
                                                        definition: definition,
                                                        data: fieldData,
                                                        dataStrategy: dataStrategy)

                case .userProfileIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        userProfileIndex = MessageIndex(value: value)
                    }

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
            case .timestamp:
                if let _ = timeStamp { fileDefs.append(key.fieldDefinition()) }

            case .systolicPressure:
                if let _ = systolicPressure { fileDefs.append(key.fieldDefinition()) }
            case .diastolicPressure:
                if let _ = diastolicPressure { fileDefs.append(key.fieldDefinition()) }
            case .meanArterialPressure:
                if let _ = meanArterialPressure { fileDefs.append(key.fieldDefinition()) }
            case .mapSampleMean:
                if let _ = mapSampleMean { fileDefs.append(key.fieldDefinition()) }
            case .mapMorningValues:
                if let _ = mapMorningValues { fileDefs.append(key.fieldDefinition()) }
            case .mapEveningValues:
                if let _ = mapEveningValues { fileDefs.append(key.fieldDefinition()) }
            case .heartRate:
                if let _ = heartRate { fileDefs.append(key.fieldDefinition()) }
            case .heartRateType:
                if let _ = heartRateType { fileDefs.append(key.fieldDefinition()) }
            case .status:
                if let _ = status { fileDefs.append(key.fieldDefinition()) }
            case .userProfileIndex:
                if let _ = userProfileIndex { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: BloodPressureMessage.globalMessageNumber(),
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
            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())
                }

            case .systolicPressure:
                if var systolicPressure = systolicPressure {
                    systolicPressure = systolicPressure.converted(to: UnitPressure.millimetersOfMercury)
                    let valueData = try key.encodeKeyed(value: systolicPressure.value)
                    msgData.append(valueData)
                }

            case .diastolicPressure:
                if var diastolicPressure = diastolicPressure {
                    diastolicPressure = diastolicPressure.converted(to: UnitPressure.millimetersOfMercury)
                    let valueData = try key.encodeKeyed(value: diastolicPressure.value)
                    msgData.append(valueData)
                }

            case .meanArterialPressure:
                if var meanArterialPressure = meanArterialPressure {
                    meanArterialPressure = meanArterialPressure.converted(to: UnitPressure.millimetersOfMercury)
                    let valueData = try key.encodeKeyed(value: meanArterialPressure.value)
                    msgData.append(valueData)
                }

            case .mapSampleMean:
                if var mapSampleMean = mapSampleMean {
                    mapSampleMean = mapSampleMean.converted(to: UnitPressure.millimetersOfMercury)
                    let valueData = try key.encodeKeyed(value: mapSampleMean.value)
                    msgData.append(valueData)
                }

            case .mapMorningValues:
                if var mapMorningValues = mapMorningValues {
                    mapMorningValues = mapMorningValues.converted(to: UnitPressure.millimetersOfMercury)
                    let valueData = try key.encodeKeyed(value: mapMorningValues.value)
                    msgData.append(valueData)
                }

            case .mapEveningValues:
                if var mapEveningValues = mapEveningValues {
                    mapEveningValues = mapEveningValues.converted(to: UnitPressure.millimetersOfMercury)
                    let valueData = try key.encodeKeyed(value: mapEveningValues.value)
                    msgData.append(valueData)
                }

            case .heartRate:
                if let heartRate = heartRate {
                    let valueData = try key.encodeKeyed(value: heartRate.value)
                    msgData.append(valueData)
                }

            case .heartRateType:
                if let heartRateType = heartRateType {
                    let valueData = try key.encodeKeyed(value: heartRateType)
                    msgData.append(valueData)
                }

            case .status:
                if let status = status {
                    let valueData = try key.encodeKeyed(value: status)
                    msgData.append(valueData)
                }

            case .userProfileIndex:
                if let userProfileIndex = userProfileIndex {
                    msgData.append(userProfileIndex.encode())
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
