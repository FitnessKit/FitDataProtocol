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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class BloodPressureMessage: FitMessage {

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

    public init(timeStamp: FitTime?, systolicPressure: ValidatedMeasurement<UnitPressure>?, diastolicPressure: ValidatedMeasurement<UnitPressure>?, meanArterialPressure: ValidatedMeasurement<UnitPressure>?, mapSampleMean: ValidatedMeasurement<UnitPressure>?, mapMorningValues: ValidatedMeasurement<UnitPressure>?, mapEveningValues: ValidatedMeasurement<UnitPressure>?, heartRate: UInt8?, heartRateType: HeartRateType?, status: BloodPressureStatus?, userProfileIndex: MessageIndex? ) {

        self.timeStamp = timeStamp
        self.systolicPressure = systolicPressure
        self.diastolicPressure = diastolicPressure
        self.meanArterialPressure = meanArterialPressure
        self.mapSampleMean = mapSampleMean
        self.mapMorningValues = mapMorningValues
        self.mapEveningValues = mapEveningValues

        if let hr = heartRate {

            let valid = !(Int64(hr) == BaseType.uint8.invalid)
            self.heartRate = ValidatedMeasurement(value: Double(hr), valid: valid, unit: UnitCadence.beatsPerMinute)
            
        } else {
            self.heartRate = nil
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

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                //print("BloodPressureMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .systolicPressure:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * mmHg + 0
                        let value = Double(value)
                        systolicPressure = ValidatedMeasurement(value: value, valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            systolicPressure = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPressure.millimetersOfMercury)
                        }
                    }

                case .diastolicPressure:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * mmHg + 0
                        let value = Double(value)
                        diastolicPressure = ValidatedMeasurement(value: value, valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            diastolicPressure = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPressure.millimetersOfMercury)
                        }
                    }

                case .meanArterialPressure:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * mmHg + 0
                        let value = Double(value)
                        meanArterialPressure = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            meanArterialPressure = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPressure.millimetersOfMercury)
                        }
                    }

                case .mapSampleMean:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * mmHg + 0
                        let value = Double(value)
                        mapSampleMean = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            mapSampleMean = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPressure.millimetersOfMercury)
                        }
                    }

                case .mapMorningValues:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * mmHg + 0
                        let value = Double(value)
                        mapMorningValues = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            mapMorningValues = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPressure.millimetersOfMercury)
                        }
                    }

                case .mapEveningValues:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * mmHg + 0
                        let value = Double(value)
                        mapEveningValues = ValidatedMeasurement(value: value,valid: true, unit: UnitPressure.millimetersOfMercury)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            mapEveningValues = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPressure.millimetersOfMercury)
                        }
                    }

                case .heartRate:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * bpm + 0
                        heartRate = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            heartRate = UInt8(definition.baseType.invalid)
                        }
                    }

                case .heartRateType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
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
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
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
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        userProfileIndex = MessageIndex(value: value)
                    }
                    
                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timeStamp = FitTime(time: value)
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
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension BloodPressureMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case systolicPressure       = 0
        case diastolicPressure      = 1
        case meanArterialPressure   = 2
        case mapSampleMean          = 3
        case mapMorningValues       = 4
        case mapEveningValues       = 5
        case heartRate              = 6
        case heartRateType          = 7
        case status                 = 8
        case userProfileIndex       = 9

        case timestamp              = 253

    }
}
