//
//  WeightScaleMessage.swift
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

/// FIT Weight Scale Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WeightScaleMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 30
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Weight
    private(set) public var weight: Weight?

    /// Percent Fat
    private(set) public var percentFat: ValidatedMeasurement<UnitPercent>?

    /// Percent Hydration
    private(set) public var percentHydration: ValidatedMeasurement<UnitPercent>?

    /// Visceral Fat Mass
    private(set) public var visceralFatMass: ValidatedMeasurement<UnitMass>?

    /// Bone Mass
    private(set) public var boneMass: ValidatedMeasurement<UnitMass>?

    /// Muscle Mass
    private(set) public var muscleMass: ValidatedMeasurement<UnitMass>?

    /// Basal MET
    ///
    /// Units are per day
    private(set) public var basalMet: ValidatedMeasurement<UnitEnergy>?

    /// Physique Rating
    private(set) public var physiqueRating: ValidatedMeasurement<RatingUnit>?

    /// Active MET
    ///
    /// Units are per day
    private(set) public var activeMet: ValidatedMeasurement<UnitEnergy>?

    /// Metabolic Age
    private(set) public var metabolicAge: ValidatedMeasurement<UnitDuration>?

    /// Visceral Fat Rating
    private(set) public var visceralFatRating: ValidatedMeasurement<RatingUnit>?

    /// User Profile Index
    ///
    /// Associates this blood pressure message to a user.  This corresponds to the index of the user profile message in the blood pressure file.
    private(set) public var userProfileIndex: MessageIndex?


    public required init() {}

    public init(timeStamp: FitTime?,
                weight: Weight?,
                percentFat: ValidatedMeasurement<UnitPercent>?,
                percentHydration: ValidatedMeasurement<UnitPercent>?,
                visceralFatMass: ValidatedMeasurement<UnitMass>?,
                boneMass: ValidatedMeasurement<UnitMass>?,
                muscleMass: ValidatedMeasurement<UnitMass>?,
                basalMet: ValidatedMeasurement<UnitEnergy>?,
                physiqueRating: ValidatedMeasurement<RatingUnit>?,
                activeMet: ValidatedMeasurement<UnitEnergy>?,
                metabolicAge: ValidatedMeasurement<UnitDuration>?,
                visceralFatRating: ValidatedMeasurement<RatingUnit>?,
                userProfileIndex: MessageIndex? ) {

        self.timeStamp = timeStamp
        self.weight = weight
        self.percentFat = percentFat
        self.percentHydration = percentHydration
        self.visceralFatMass = visceralFatMass
        self.boneMass = boneMass
        self.muscleMass = muscleMass
        self.basalMet = basalMet
        self.physiqueRating = physiqueRating
        self.activeMet = activeMet
        self.metabolicAge = metabolicAge
        self.visceralFatRating = visceralFatRating
        self.userProfileIndex = userProfileIndex
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WeightScaleMessage  {

        var timeStamp: FitTime?
        var weight: Weight?
        var percentFat: ValidatedMeasurement<UnitPercent>?
        var percentHydration: ValidatedMeasurement<UnitPercent>?
        var visceralFatMass: ValidatedMeasurement<UnitMass>?
        var boneMass: ValidatedMeasurement<UnitMass>?
        var muscleMass: ValidatedMeasurement<UnitMass>?
        var basalMet: ValidatedMeasurement<UnitEnergy>?
        var physiqueRating: ValidatedMeasurement<RatingUnit>?
        var activeMet: ValidatedMeasurement<UnitEnergy>?
        var metabolicAge: ValidatedMeasurement<UnitDuration>?
        var visceralFatRating: ValidatedMeasurement<RatingUnit>?
        var userProfileIndex: MessageIndex?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("WeightScaleMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {


                case .weight:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        /// 100 * kg + 0
                        weight = Weight(rawValue: value, scale: 100.0)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            weight = Weight(rawValue: UInt16(definition.baseType.invalid), scale: 100.0, valid: false)
                        }
                    }

                case .percentFat:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        percentFat = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            percentFat = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .percentHydration:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        percentHydration = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            percentHydration = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPercent.percent)
                        }
                    }

                case .visceralFatMass:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * kg + 0
                        let value = value.resolution(1 / 100)
                        visceralFatMass = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            visceralFatMass = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitMass.kilograms)
                        }
                    }

                case .boneMass:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * kg + 0
                        let value = value.resolution(1 / 100)
                        boneMass = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            boneMass = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitMass.kilograms)
                        }
                    }

                case .muscleMass:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * kg + 0
                        let value = value.resolution(1 / 100)
                        muscleMass = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            muscleMass = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitMass.kilograms)
                        }
                    }

                case .basalMet:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 4 * kcal/day + 0
                        let value = value.resolution(1 / 4)
                        basalMet = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            basalMet = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .physiqueRating:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        let value = Double(value)
                        physiqueRating = ValidatedMeasurement(value: value, valid: true, unit: RatingUnit.physique)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            physiqueRating = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: RatingUnit.physique)
                        }
                    }

                case .activeMet:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 4 * kcal/day + 0
                        let value = value.resolution(1 / 4)
                        activeMet = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            activeMet = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitEnergy.kilocalories)
                        }
                    }

                case .metabolicAge:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        /// 1 * years
                        let value = Double(value)
                        metabolicAge = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.year)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            metabolicAge = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitDuration.year)
                        }
                    }

                case .visceralFatRating:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        let value = Double(value)
                        visceralFatRating = ValidatedMeasurement(value: value, valid: true, unit: RatingUnit.visceralFat)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            visceralFatRating = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: RatingUnit.visceralFat)
                        }
                    }


                case .userProfileIndex:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        userProfileIndex = MessageIndex(value: value)
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timeStamp = FitTime(time: value)
                    }

                }
            }
        }

        return WeightScaleMessage(timeStamp: timeStamp,
                                  weight: weight,
                                  percentFat: percentFat,
                                  percentHydration: percentHydration,
                                  visceralFatMass: visceralFatMass,
                                  boneMass: boneMass,
                                  muscleMass: muscleMass,
                                  basalMet: basalMet,
                                  physiqueRating: physiqueRating,
                                  activeMet: activeMet,
                                  metabolicAge: metabolicAge,
                                  visceralFatRating: visceralFatRating,
                                  userProfileIndex: userProfileIndex)
    }
}
