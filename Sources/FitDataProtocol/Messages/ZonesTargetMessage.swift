//
//  ZonesTargetMessage.swift
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

/// FIT Zones Target Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ZonesTargetMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 7 }

    /// Max Heart Rate
    private(set) public var maxHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Threshold Heart Rate
    private(set) public var thresholdHeartRate: ValidatedMeasurement<UnitCadence>?

    /// Heart Rate Zone Calculation Type
    private(set) public var heartRateZoneType: HeartRateZoneCalculation?

    /// Functional Threshold Power (FTP)
    private(set) public var ftp: ValidatedBinaryInteger<UInt16>?

    /// Power Zone Calculation Type
    private(set) public var powerZoneType: PowerZoneCalculation?

    public required init() {}

    public init(maxHeartRate: UInt8? = nil,
                thresholdHeartRate: UInt8? = nil,
                heartRateZoneType: HeartRateZoneCalculation? = nil,
                ftp: ValidatedBinaryInteger<UInt16>? = nil,
                powerZoneType: PowerZoneCalculation? = nil) {

        if let hr = maxHeartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.maxHeartRate.baseType)
            self.maxHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }

        if let hr = thresholdHeartRate {
            let valid = hr.isValidForBaseType(FitCodingKeys.thresholdHeartRate.baseType)
            self.thresholdHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
        }

        self.heartRateZoneType = heartRateZoneType
        self.ftp = ftp
        self.powerZoneType = powerZoneType
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: ZonesTargetMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
        var maxHeartRate: UInt8?
        var thresholdHeartRate: UInt8?
        var heartRateZoneType: HeartRateZoneCalculation?
        var ftp: ValidatedBinaryInteger<UInt16>?
        var powerZoneType: PowerZoneCalculation?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ZonesTargetMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {

                case .maxHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        maxHeartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            maxHeartRate = value.value
                        } else {
                            maxHeartRate = nil
                        }
                    }

                case .thresholdHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * bpm + 0
                        thresholdHeartRate = value
                    } else {
                        if let value = ValidatedBinaryInteger<UInt8>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            thresholdHeartRate = value.value
                        } else {
                            thresholdHeartRate = nil
                        }
                    }

                case .functionalThresholdPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    ftp = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                   definition: definition,
                                                                   dataStrategy: dataStrategy)

                case .heartRateCalculation:
                    heartRateZoneType = HeartRateZoneCalculation.decode(decoder: &localDecoder,
                                                                        definition: definition,
                                                                        data: fieldData,
                                                                        dataStrategy: dataStrategy)

                case .powerCalculation:
                    powerZoneType = PowerZoneCalculation.decode(decoder: &localDecoder,
                                                                definition: definition,
                                                                data: fieldData,
                                                                dataStrategy: dataStrategy)

                }
            }
        }

        let msg = ZonesTargetMessage(maxHeartRate: maxHeartRate,
                                     thresholdHeartRate: thresholdHeartRate,
                                     heartRateZoneType: heartRateZoneType,
                                     ftp: ftp,
                                     powerZoneType: powerZoneType)
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
            case .maxHeartRate:
                if let _ = maxHeartRate { fileDefs.append(key.fieldDefinition()) }
            case .thresholdHeartRate:
                if let _ = thresholdHeartRate { fileDefs.append(key.fieldDefinition()) }
            case .functionalThresholdPower:
                if let _ = ftp { fileDefs.append(key.fieldDefinition()) }
            case .heartRateCalculation:
                if let _ = heartRateZoneType { fileDefs.append(key.fieldDefinition()) }
            case .powerCalculation:
                if let _ = powerZoneType { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ZonesTargetMessage.globalMessageNumber(),
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
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            return.failure(self.encodeWrongDefinitionMessage())
        }

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {
            case .maxHeartRate:
                if let maxHeartRate = maxHeartRate {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: maxHeartRate.value)) {
                        return.failure(error)
                    }
                }

            case .thresholdHeartRate:
                if let thresholdHeartRate = thresholdHeartRate {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: thresholdHeartRate.value)) {
                        return.failure(error)
                    }
                }

            case .functionalThresholdPower:
                if let ftp = ftp {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: ftp)) {
                        return.failure(error)
                    }
                }

            case .heartRateCalculation:
                if let heartRateZoneType = heartRateZoneType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: heartRateZoneType)) {
                        return.failure(error)
                    }
                }

            case .powerCalculation:
                if let powerZoneType = powerZoneType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: powerZoneType)) {
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
