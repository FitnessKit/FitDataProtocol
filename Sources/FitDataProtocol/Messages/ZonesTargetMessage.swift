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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ZonesTargetMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 7
    }

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

    public init(maxHeartRate: UInt8?,
                thresholdHeartRate: UInt8?,
                heartRateZoneType: HeartRateZoneCalculation?,
                ftp: ValidatedBinaryInteger<UInt16>?,
                powerZoneType: PowerZoneCalculation?) {

        if let hr = maxHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.maxHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.maxHeartRate = nil
        }

        if let hr = thresholdHeartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.thresholdHeartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)

        } else {
            self.thresholdHeartRate = nil
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
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        maxHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            maxHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .thresholdHeartRate:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        thresholdHeartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            thresholdHeartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .functionalThresholdPower:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        ftp = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            ftp = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .heartRateCalculation:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        heartRateZoneType = HeartRateZoneCalculation(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heartRateZoneType = HeartRateZoneCalculation.invalid
                        }
                    }

                case .powerCalculation:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        powerZoneType = PowerZoneCalculation(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            powerZoneType = PowerZoneCalculation.invalid
                        }
                    }

                }
            }
        }

        return ZonesTargetMessage(maxHeartRate: maxHeartRate,
                                  thresholdHeartRate: thresholdHeartRate,
                                  heartRateZoneType: heartRateZoneType,
                                  ftp: ftp,
                                  powerZoneType: powerZoneType)
    }
}
