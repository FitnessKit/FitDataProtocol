//
//  StrideSpeedDistanceMonitorProfileMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/18.
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

/// FIT Stride Based Speed and Distance Monitor (SDM) Profile Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class StrideSpeedDistanceMonitorProfileMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 5 }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Enabled
    private(set) public var enabled: Bool?

    /// ANT ID
    private(set) public var antID: ValidatedBinaryInteger<UInt16>?

    /// Calibration Factor
    private(set) public var calibrationFactor: ValidatedMeasurement<UnitPercent>?

    /// Odometer
    private(set) public var odometer: ValidatedMeasurement<UnitLength>?

    /// Footpod should be used as speed source vs GPS
    private(set) public var speedSourceFootpod: Bool?

    /// Transmission Type
    private(set) public var transmissionType: TransmissionType?

    /// Odometer Rollover Counter
    ///
    /// Rollover counter that can be used to extend the odometer
    private(set) public var odometerRolloverCounter: UInt8?

    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                enabled: Bool? = nil,
                antID: ValidatedBinaryInteger<UInt16>? = nil,
                calibrationFactor: ValidatedMeasurement<UnitPercent>? = nil,
                odometer: ValidatedMeasurement<UnitLength>? = nil,
                speedSourceFootpod: Bool? = nil,
                transmissionType: TransmissionType? = nil,
                odometerRolloverCounter: UInt8? = nil) {
        
        self.messageIndex = messageIndex
        self.enabled = enabled
        self.antID = antID
        self.calibrationFactor = calibrationFactor
        self.odometer = odometer
        self.speedSourceFootpod = speedSourceFootpod
        self.transmissionType = transmissionType
        self.odometerRolloverCounter = odometerRolloverCounter
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: StrideSpeedDistanceMonitorProfileMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
        var messageIndex: MessageIndex?
        var enabled: Bool?
        var antID: ValidatedBinaryInteger<UInt16>?
        var calibrationFactor: ValidatedMeasurement<UnitPercent>?
        var odometer: ValidatedMeasurement<UnitLength>?
        var speedSourceFootpod: Bool?
        var transmissionType: TransmissionType?
        var odometerRolloverCounter: UInt8?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("StrideSpeedDistanceMonitorProfileMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                case .enabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        enabled = value.boolValue
                    }

                case .antID:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    antID = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                     definition: definition,
                                                                     dataStrategy: dataStrategy)

                case .calibrationFactor:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 10 * % + 0
                        let value = value.resolution(.removing, resolution: key.baseData.resolution)
                        calibrationFactor = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        calibrationFactor = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .odometer:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * m + 0
                        let value = value.resolution(.removing, resolution: key.baseData.resolution)
                        odometer = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {
                        odometer = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitLength.meters)
                    }

                case .speedSource:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        speedSourceFootpod = value.boolValue
                    }

                case .transType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        transmissionType = TransmissionType(value)
                    }

                case .odometerRollover:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        odometerRolloverCounter = value
                    }

                }
            }
        }

        let msg = StrideSpeedDistanceMonitorProfileMessage(messageIndex: messageIndex,
                                                           enabled: enabled,
                                                           antID: antID,
                                                           calibrationFactor: calibrationFactor,
                                                           odometer: odometer,
                                                           speedSourceFootpod: speedSourceFootpod,
                                                           transmissionType: transmissionType,
                                                           odometerRolloverCounter: odometerRolloverCounter)
        
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

            case .enabled:
                if let _ = enabled { fileDefs.append(key.fieldDefinition()) }
            case .antID:
                if let _ = antID { fileDefs.append(key.fieldDefinition()) }
            case .calibrationFactor:
                if let _ = calibrationFactor { fileDefs.append(key.fieldDefinition()) }
            case .odometer:
                if let _ = odometer { fileDefs.append(key.fieldDefinition()) }
            case .speedSource:
                if let _ = speedSourceFootpod { fileDefs.append(key.fieldDefinition()) }
            case .transType:
                if let _ = transmissionType { fileDefs.append(key.fieldDefinition()) }
            case .odometerRollover:
                if let _ = odometerRolloverCounter { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: StrideSpeedDistanceMonitorProfileMessage.globalMessageNumber(),
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
            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())
                }

            case .enabled:
                if let enabled = enabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: enabled)) {
                        return.failure(error)
                    }
                }

            case .antID:
                if let antID = antID {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: antID)) {
                        return.failure(error)
                    }
                }

            case .calibrationFactor:
                if let calibrationFactor = calibrationFactor {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: calibrationFactor.value)) {
                        return.failure(error)
                    }
                }

            case .odometer:
                if var odometer = odometer {
                    odometer = odometer.converted(to: UnitLength.meters)
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: odometer.value)) {
                        return.failure(error)
                    }
                }

            case .speedSource:
                if let speedSource = speedSourceFootpod {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: speedSource)) {
                        return.failure(error)
                    }
                }

            case .transType:
                if let transmissionType = transmissionType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: transmissionType)) {
                        return.failure(error)
                    }
                }

            case .odometerRollover:
                if let odometerRolloverCounter = odometerRolloverCounter {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: odometerRolloverCounter)) {
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
