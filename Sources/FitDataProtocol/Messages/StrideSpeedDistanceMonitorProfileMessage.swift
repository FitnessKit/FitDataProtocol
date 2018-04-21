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

/// FIT Stride Based Speed and Distance Monitor (SDM) Profile Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class StrideSpeedDistanceMonitorProfileMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 5
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Enabled
    private(set) public var enabled: Bool?

    /// ANT ID
    private(set) public var antID: UInt8?

    /// Calibration Factor
    private(set) public var calibrationFactor: Measurement<UnitPercent>?

    /// Odometer
    private(set) public var odometer: Measurement<UnitLength>?

    /// Footpod should be used as speed source vs GPS
    private(set) public var speedSourceFootpod: Bool?

    /// Transmission Type
    private(set) public var transmissionType: UInt8?

    /// Odometer Rollover Counter
    ///
    /// Rollover counter that can be used to extend the odometer
    private(set) public var odometerRolloverCounter: UInt8?

    public required init() {}

    public init(messageIndex: MessageIndex?, enabled: Bool?, antID: UInt8?, calibrationFactor: Measurement<UnitPercent>?, odometer: Measurement<UnitLength>?, speedSourceFootpod: Bool?, transmissionType: UInt8?, odometerRolloverCounter: UInt8?) {
        self.messageIndex = messageIndex
        self.enabled = enabled
        self.antID = antID
        self.calibrationFactor = calibrationFactor
        self.odometer = odometer
        self.speedSourceFootpod = speedSourceFootpod
        self.transmissionType = transmissionType
        self.odometerRolloverCounter = odometerRolloverCounter
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> StrideSpeedDistanceMonitorProfileMessage  {

        var messageIndex: MessageIndex?
        var enabled: Bool?
        var antID: UInt8?
        var calibrationFactor: Measurement<UnitPercent>?
        var odometer: Measurement<UnitLength>?
        var speedSourceFootpod: Bool?
        var transmissionType: UInt8?
        var odometerRolloverCounter: UInt8?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("HrvMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .enabled:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        enabled = value.boolValue
                    }


                case .antID:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        antID = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            antID = UInt8(definition.baseType.invalid)
                        }
                    }


                case .calibrationFactor:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 10 * % + 0
                        let value = Double(value) / 10
                        calibrationFactor = Measurement(value: value, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            calibrationFactor = Measurement(value: Double(definition.baseType.invalid), unit: UnitPercent.percent)
                        }
                    }

                case .odometer:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = Double(value) / 100
                        odometer = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            odometer = Measurement(value: Double(definition.baseType.invalid), unit: UnitLength.meters)
                        }
                    }

                case .speedSource:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        speedSourceFootpod = value.boolValue
                    }

                case .transType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        transmissionType = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            transmissionType = UInt8(definition.baseType.invalid)
                        }
                    }

                case .odometerRollover:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        odometerRolloverCounter = value
                    }

                case .messageIndex:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

                }
            }
        }

        return StrideSpeedDistanceMonitorProfileMessage(messageIndex: messageIndex,
                                                        enabled: enabled,
                                                        antID: antID,
                                                        calibrationFactor: calibrationFactor,
                                                        odometer: odometer,
                                                        speedSourceFootpod: speedSourceFootpod,
                                                        transmissionType: transmissionType,
                                                        odometerRolloverCounter: odometerRolloverCounter)
    }
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension StrideSpeedDistanceMonitorProfileMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case enabled                = 0
        case antID                  = 1
        case calibrationFactor      = 2
        case odometer               = 3
        case speedSource            = 4
        case transType              = 5
        case odometerRollover       = 7

        case messageIndex           = 254
    }
}
