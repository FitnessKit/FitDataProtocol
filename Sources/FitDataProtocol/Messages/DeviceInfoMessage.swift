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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeviceInfoMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 23
    }

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

    public init(timeStamp: FitTime?,
                serialNumber: ValidatedBinaryInteger<UInt32>?,
                cumulativeOpTime: ValidatedMeasurement<UnitDuration>?,
                productName: String?,
                manufacturer: Manufacturer?,
                product: ValidatedBinaryInteger<UInt16>?,
                softwareVersion: ValidatedBinaryInteger<UInt16>?,
                hardwareVersion: ValidatedBinaryInteger<UInt8>?,
                batteryVoltage: ValidatedMeasurement<UnitElectricPotentialDifference>?,
                batteryStatus: BatteryStatus?,
                deviceNumber: ValidatedBinaryInteger<UInt16>?,
                deviceType: DeviceType?,
                deviceIndex: DeviceIndex?,
                sensorDescription: String?,
                bodylocation: BodyLocation?,
                transmissionType: TransmissionType?,
                antNetwork: NetworkType?,
                source: SourceType?) {

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

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("DeviceInfoMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .deviceIndex:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        deviceIndex = DeviceIndex(index: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            deviceIndex = DeviceIndex(index: UInt8(definition.baseType.invalid))
                        }
                    }

                case .deviceType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        deviceType = DeviceType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            deviceType = DeviceType.unknown
                        }
                    }

                case .manufacturer:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        manufacturer = Manufacturer.company(id: value)
                    }

                case .serialNumber:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        serialNumber = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            serialNumber = ValidatedBinaryInteger(value: UInt32(definition.baseType.invalid), valid: false)
                        }
                    }

                case .product:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        product = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            product = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .softwareVersion:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        softwareVersion = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            softwareVersion = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .hardwareVersion:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        hardwareVersion = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            hardwareVersion = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .cumulativeOpTime:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * s + 0
                        let value = Double(value)
                        cumulativeOpTime = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.seconds)
                    }

                case .batteryVoltage:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 256 * V + 0
                        let value = value.resolution(1 / 256)
                        batteryVoltage = ValidatedMeasurement(value: value, valid: true, unit: UnitElectricPotentialDifference.volts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            batteryVoltage = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitElectricPotentialDifference.volts)
                        }
                    }

                case .batteryStatus:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        batteryStatus = BatteryStatus(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            batteryStatus = BatteryStatus.invalid
                        }
                    }

                case .sensorPosition:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        bodylocation = BodyLocation(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            bodylocation = BodyLocation.invalid
                        }
                    }

                case .description:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        sensorDescription = stringData.smartString
                    }

                case .transmissionType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        transmissionType = TransmissionType(value)
                    }

                case .deviceNumber:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        deviceNumber = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            deviceNumber = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .antNetwork:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        antNetwork = NetworkType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            antNetwork = NetworkType.invalid
                        }
                    }

                case .sourcetype:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        source = SourceType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            source = SourceType.invalid
                        }
                    }

                case .productName:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        productname = stringData.smartString
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

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
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension DeviceInfoMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case deviceIndex        = 0
        case deviceType         = 1
        case manufacturer       = 2
        case serialNumber       = 3
        case product            = 4
        case softwareVersion    = 5
        case hardwareVersion    = 6
        case cumulativeOpTime   = 7
        case batteryVoltage     = 10
        case batteryStatus      = 11
        case sensorPosition     = 18
        case description        = 19
        case transmissionType   = 20
        case deviceNumber       = 21
        case antNetwork         = 22
        case sourcetype         = 25
        case productName        = 27

        case timestamp          = 253
    }
}
