//
//  DeviceInfoMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/4/18.
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

/// FIT Device Information Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeviceInfoMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 23 }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Serial Number
    private(set) public var serialNumber: ValidatedBinaryInteger<UInt32>?

    /// Cumulative Operating Time
    ///
    /// Reset by new battery or charge
    private(set) public var cumulativeOpTime: ValidatedMeasurement<UnitDuration>?

    /// Product Name
    private(set) public var productName: String?

    /// Manufacturer
    private(set) public var manufacturer: Manufacturer?

    /// Product
    private(set) public var product: ValidatedBinaryInteger<UInt16>?

    /// Software Version
    private(set) public var softwareVersion: ValidatedBinaryInteger<UInt16>?

    /// Hardware Version
    private(set) public var hardwareVersion: ValidatedBinaryInteger<UInt8>?

    /// Battery Voltage
    private(set) public var batteryVoltage: ValidatedMeasurement<UnitElectricPotentialDifference>?

    /// Battery Status
    private(set) public var batteryStatus: BatteryStatus?

    /// Device Number
    private(set) public var deviceNumber: ValidatedBinaryInteger<UInt16>?

    /// Device Type
    private(set) public var deviceType: DeviceType?

    /// Device Index
    private(set) public var deviceIndex: DeviceIndex?

    /// Sensor Description
    private(set) public var sensorDescription: String?

    /// Sensor Body Location
    private(set) public var bodylocation: BodyLocation?

    /// Transmission Type
    private(set) public var transmissionType: TransmissionType?

    /// ANT Network Type
    private(set) public var antNetwork: NetworkType?

    /// Source
    private(set) public var source: SourceType?


    public required init() {}

    public init(timeStamp: FitTime? = nil,
                serialNumber: ValidatedBinaryInteger<UInt32>? = nil,
                cumulativeOpTime: ValidatedMeasurement<UnitDuration>? = nil,
                productName: String? = nil,
                manufacturer: Manufacturer? = nil,
                product: ValidatedBinaryInteger<UInt16>? = nil,
                softwareVersion: ValidatedBinaryInteger<UInt16>? = nil,
                hardwareVersion: ValidatedBinaryInteger<UInt8>? = nil,
                batteryVoltage: ValidatedMeasurement<UnitElectricPotentialDifference>? = nil,
                batteryStatus: BatteryStatus? = nil,
                deviceNumber: ValidatedBinaryInteger<UInt16>? = nil,
                deviceType: DeviceType? = nil,
                deviceIndex: DeviceIndex? = nil,
                sensorDescription: String? = nil,
                bodylocation: BodyLocation? = nil,
                transmissionType: TransmissionType? = nil,
                antNetwork: NetworkType? = nil,
                source: SourceType? = nil) {

        self.timeStamp = timeStamp
        self.serialNumber = serialNumber
        self.cumulativeOpTime = cumulativeOpTime
        self.productName = productName
        self.manufacturer = manufacturer
        self.product = product
        self.softwareVersion = softwareVersion
        self.hardwareVersion = hardwareVersion
        self.batteryVoltage = batteryVoltage
        self.batteryStatus = batteryStatus
        self.deviceNumber = deviceNumber
        self.deviceType = deviceType
        self.deviceIndex = deviceIndex
        self.sensorDescription = sensorDescription
        self.bodylocation = bodylocation
        self.transmissionType = transmissionType
        self.antNetwork = antNetwork
        self.source = source
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> DeviceInfoMessage  {

        var timestamp: FitTime?
        var serialNumber: ValidatedBinaryInteger<UInt32>?
        var cumulativeOpTime: ValidatedMeasurement<UnitDuration>?
        var productname: String?
        var manufacturer: Manufacturer?
        var product: ValidatedBinaryInteger<UInt16>?
        var softwareVersion: ValidatedBinaryInteger<UInt16>?
        var hardwareVersion: ValidatedBinaryInteger<UInt8>?
        var batteryVoltage: ValidatedMeasurement<UnitElectricPotentialDifference>?
        var batteryStatus: BatteryStatus?
        var deviceNumber: ValidatedBinaryInteger<UInt16>?
        var deviceType: DeviceType?
        var deviceIndex: DeviceIndex?
        var sensorDescription: String?
        var bodylocation: BodyLocation?
        var transmissionType: TransmissionType?
        var antNetwork: NetworkType?
        var source: SourceType?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("DeviceInfoMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                case .deviceIndex:
                    deviceIndex = DeviceIndex.decode(decoder: &localDecoder,
                                                     definition: definition,
                                                     data: fieldData,
                                                     dataStrategy: dataStrategy)

                case .deviceType:
                    deviceType = DeviceType.decode(decoder: &localDecoder,
                                                   definition: definition,
                                                   data: fieldData,
                                                   dataStrategy: dataStrategy)

                case .manufacturer:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        manufacturer = Manufacturer.company(id: value)
                    }

                case .serialNumber:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    serialNumber = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                            definition: definition,
                                                                            dataStrategy: dataStrategy)

                case .product:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    product = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                       definition: definition,
                                                                       dataStrategy: dataStrategy)

                case .softwareVersion:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    softwareVersion = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                               definition: definition,
                                                                               dataStrategy: dataStrategy)

                case .hardwareVersion:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    hardwareVersion = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                              definition: definition,
                                                                              dataStrategy: dataStrategy)

                case .cumulativeOpTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1 * s + 0
                        let value = Double(value)
                        cumulativeOpTime = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.seconds)
                    }

                case .batteryVoltage:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 256 * V + 0
                        let value = value.resolution(.removing, resolution: key.resolution)
                        batteryVoltage = ValidatedMeasurement(value: value, valid: true, unit: UnitElectricPotentialDifference.volts)
                    } else {
                        batteryVoltage = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitElectricPotentialDifference.volts)
                    }

                case .batteryStatus:
                    batteryStatus = BatteryStatus.decode(decoder: &localDecoder,
                                                         definition: definition,
                                                         data: fieldData,
                                                         dataStrategy: dataStrategy)

                case .sensorPosition:
                    bodylocation = BodyLocation.decode(decoder: &localDecoder,
                                                       definition: definition,
                                                       data: fieldData,
                                                       dataStrategy: dataStrategy)

                case .description:
                    sensorDescription = String.decode(decoder: &localDecoder,
                                                      definition: definition,
                                                      data: fieldData,
                                                      dataStrategy: dataStrategy)

                case .transmissionType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        transmissionType = TransmissionType(value)
                    }

                case .deviceNumber:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    deviceNumber = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                            definition: definition,
                                                                            dataStrategy: dataStrategy)

                case .antNetwork:
                    antNetwork = NetworkType.decode(decoder: &localDecoder,
                                                    definition: definition,
                                                    data: fieldData,
                                                    dataStrategy: dataStrategy)

                case .sourcetype:
                    source = SourceType.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

                case .productName:
                    productname = String.decode(decoder: &localDecoder,
                                                definition: definition,
                                                data: fieldData,
                                                dataStrategy: dataStrategy)

                }
            }
        }

        return DeviceInfoMessage(timeStamp: timestamp,
                                 serialNumber: serialNumber,
                                 cumulativeOpTime: cumulativeOpTime,
                                 productName: productname,
                                 manufacturer: manufacturer,
                                 product: product,
                                 softwareVersion: softwareVersion,
                                 hardwareVersion: hardwareVersion,
                                 batteryVoltage: batteryVoltage,
                                 batteryStatus: batteryStatus,
                                 deviceNumber: deviceNumber,
                                 deviceType: deviceType,
                                 deviceIndex: deviceIndex,
                                 sensorDescription: sensorDescription,
                                 bodylocation: bodylocation,
                                 transmissionType: transmissionType,
                                 antNetwork: antNetwork,
                                 source: source)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage
    /// - Throws: FitError
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> DefinitionMessage {

        try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .timestamp:
                if let _ = timeStamp { fileDefs.append(key.fieldDefinition()) }

            case .deviceIndex:
                if let _ = deviceIndex { fileDefs.append(key.fieldDefinition()) }
            case .deviceType:
                if let _ = deviceType { fileDefs.append(key.fieldDefinition()) }
            case .manufacturer:
                if let _ = manufacturer { fileDefs.append(key.fieldDefinition()) }
            case .serialNumber:
                if let _ = serialNumber { fileDefs.append(key.fieldDefinition()) }
            case .product:
                if let _ = product { fileDefs.append(key.fieldDefinition()) }
            case .softwareVersion:
                if let _ = softwareVersion { fileDefs.append(key.fieldDefinition()) }
            case .hardwareVersion:
                if let _ = hardwareVersion { fileDefs.append(key.fieldDefinition()) }
            case .cumulativeOpTime:
                if let _ = cumulativeOpTime { fileDefs.append(key.fieldDefinition()) }
            case .batteryVoltage:
                if var _ = batteryVoltage { fileDefs.append(key.fieldDefinition()) }
            case .batteryStatus:
                if let _ = batteryStatus { fileDefs.append(key.fieldDefinition()) }
            case .sensorPosition:
                if let _ = bodylocation { fileDefs.append(key.fieldDefinition()) }
            case .description:
                if let stringData = sensorDescription?.data(using: .utf8) {
                    //1 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        throw FitError(.encodeError(msg: "sensorDescription size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .transmissionType:
                if let _ = transmissionType { fileDefs.append(key.fieldDefinition()) }
            case .deviceNumber:
                if let _ = deviceNumber { fileDefs.append(key.fieldDefinition()) }
            case .antNetwork:
                if let _ = antNetwork { fileDefs.append(key.fieldDefinition()) }
            case .sourcetype:
                if let _ = source { fileDefs.append(key.fieldDefinition()) }
            case .productName:
                if let stringData = productName?.data(using: .utf8) {
                    //20 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        throw FitError(.encodeError(msg: "productName size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: DeviceInfoMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return defMessage
        } else {
            throw self.encodeNoPropertiesAvailable()
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

            case .deviceIndex:
                if let deviceIndex = deviceIndex {
                    let valueData = try key.encodeKeyed(value: deviceIndex.index)
                    msgData.append(valueData)
                }

            case .deviceType:
                if let deviceType = deviceType {
                    let valueData = try key.encodeKeyed(value: deviceType)
                    msgData.append(valueData)
                }

            case .manufacturer:
                if let manufacturer = manufacturer {
                    let valueData = try key.encodeKeyed(value: manufacturer.manufacturerID)
                    msgData.append(valueData)
                }

            case .serialNumber:
                if let serialNumber = serialNumber {
                    let valueData = try key.encodeKeyed(value: serialNumber)
                    msgData.append(valueData)
                }

            case .product:
                if let product = product {
                    let valueData = try key.encodeKeyed(value: product)
                    msgData.append(valueData)
                }

            case .softwareVersion:
                if let softwareVersion = softwareVersion {
                    let valueData = try key.encodeKeyed(value: softwareVersion)
                    msgData.append(valueData)
                }

            case .hardwareVersion:
                if let hardwareVersion = hardwareVersion {
                    let valueData = try key.encodeKeyed(value: hardwareVersion.value)
                    msgData.append(valueData)
                }

            case .cumulativeOpTime:
                if var cumulativeOpTime = cumulativeOpTime {
                    cumulativeOpTime = cumulativeOpTime.converted(to: UnitDuration.seconds)
                    let valueData = try key.encodeKeyed(value: cumulativeOpTime.value)
                    msgData.append(valueData)
                }

            case .batteryVoltage:
                if var batteryVoltage = batteryVoltage {
                    batteryVoltage = batteryVoltage.converted(to: UnitElectricPotentialDifference.volts)
                    let valueData = try key.encodeKeyed(value: batteryVoltage.value)
                    msgData.append(valueData)
                }

            case .batteryStatus:
                if let batteryStatus = batteryStatus {
                    let valueData = try key.encodeKeyed(value: batteryStatus)
                    msgData.append(valueData)
                }

            case .sensorPosition:
                if let sensorPosition = bodylocation {
                    let valueData = try key.encodeKeyed(value: sensorPosition)
                    msgData.append(valueData)
                }

            case .description:
                if let description = sensorDescription {
                    if let stringData = description.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .transmissionType:
                if let transmissionType = transmissionType {
                    let valueData = try key.encodeKeyed(value: transmissionType)
                    msgData.append(valueData)
                }

            case .deviceNumber:
                if let product = deviceNumber {
                    let valueData = try key.encodeKeyed(value: product)
                    msgData.append(valueData)
                }

            case .antNetwork:
                if let antNetwork = antNetwork {
                    let valueData = try key.encodeKeyed(value: antNetwork)
                    msgData.append(valueData)
                }

            case .sourcetype:
                if let sourcetype = source {
                    let valueData = try key.encodeKeyed(value: sourcetype)
                    msgData.append(valueData)
                }

            case .productName:
                if let productName = productName {
                    if let stringData = productName.data(using: .utf8) {
                        msgData.append(stringData)
                    }
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

extension DeviceInfoMessage: MessageValidator {

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
            if fileType == FileType.activity {
                try validateActivity(isGarmin: false)
            }
        case .garminConnect:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: true)
            }
        }
    }

    private func validateActivity(isGarmin: Bool) throws {

        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"

        guard self.timeStamp != nil else {
            throw FitError(.encodeError(msg: "\(msg) require DeviceInfoMessage to contain timeStamp, can not be nil"))
        }

    }
}
