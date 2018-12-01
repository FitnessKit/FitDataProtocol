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

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> ZonesTargetMessage  {

        var maxHeartRate: UInt8?
        var thresholdHeartRate: UInt8?
        var heartRateZoneType: HeartRateZoneCalculation?
        var ftp: ValidatedBinaryInteger<UInt16>?
        var powerZoneType: PowerZoneCalculation?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ZonesTargetMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

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

        return ZonesTargetMessage(maxHeartRate: maxHeartRate,
                                  thresholdHeartRate: thresholdHeartRate,
                                  heartRateZoneType: heartRateZoneType,
                                  ftp: ftp,
                                  powerZoneType: powerZoneType)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .maxHeartRate:
                if let maxHeartRate = maxHeartRate {
                    // 1 * bpm + 0
                    let value = maxHeartRate.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .thresholdHeartRate:
                if let thresholdHeartRate = thresholdHeartRate {
                    // 1 * bpm + 0
                    let value = thresholdHeartRate.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .functionalThresholdPower:
                if let ftp = ftp {
                    msgData.append(Data(from: ftp.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .heartRateCalculation:
                if let heartRateZoneType = heartRateZoneType {
                    msgData.append(heartRateZoneType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .powerCalculation:
                if let powerZoneType = powerZoneType {
                    msgData.append(powerZoneType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ZonesTargetMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "ZonesTargetMessage contains no Properties Available to Encode"))
        }
    }

}
