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

    public override class func globalMessageNumber() -> UInt16 {
        return 30
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Weight
    private(set) public var weight: Weight?

    /// Percent Fat
    private(set) public var percentFat: Measurement<UnitPercent>?

    /// Percent Hydration
    private(set) public var percentHydration: Measurement<UnitPercent>?

    /// Visceral Fat Mass
    private(set) public var visceralFatMass: Measurement<UnitMass>?

    /// Bone Mass
    private(set) public var boneMass: Measurement<UnitMass>?

    /// Muscle Mass
    private(set) public var muscleMass: Measurement<UnitMass>?

    /// Basal MET
    ///
    /// Units are per day
    private(set) public var basalMet: Measurement<UnitEnergy>?

    /// Physique Rating
    private(set) public var physiqueRating: ValidatedMeasurement<RatingUnit>?

    /// Active MET
    ///
    /// Units are per day
    private(set) public var activeMet: Measurement<UnitEnergy>?

    /// Metabolic Age
    private(set) public var metabolicAge: ValidatedMeasurement<UnitDuration>?

    /// Visceral Fat Rating
    private(set) public var visceralFatRating: ValidatedMeasurement<RatingUnit>?

    /// User Profile Index
    ///
    /// Associates this blood pressure message to a user.  This corresponds to the index of the user profile message in the blood pressure file.
    private(set) public var userProfileIndex: MessageIndex?


    public required init() {}

    public init(timeStamp: FitTime?, weight: Weight?, percentFat: Measurement<UnitPercent>?, percentHydration: Measurement<UnitPercent>?, visceralFatMass: Measurement<UnitMass>?, boneMass: Measurement<UnitMass>?, muscleMass: Measurement<UnitMass>?, basalMet: Measurement<UnitEnergy>?, physiqueRating: ValidatedMeasurement<RatingUnit>?, activeMet: Measurement<UnitEnergy>?, metabolicAge: ValidatedMeasurement<UnitDuration>?, visceralFatRating: ValidatedMeasurement<RatingUnit>?, userProfileIndex: MessageIndex? ) {

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
        var percentFat: Measurement<UnitPercent>?
        var percentHydration: Measurement<UnitPercent>?
        var visceralFatMass: Measurement<UnitMass>?
        var boneMass: Measurement<UnitMass>?
        var muscleMass: Measurement<UnitMass>?
        var basalMet: Measurement<UnitEnergy>?
        var physiqueRating: ValidatedMeasurement<RatingUnit>?
        var activeMet: Measurement<UnitEnergy>?
        var metabolicAge: ValidatedMeasurement<UnitDuration>?
        var visceralFatRating: ValidatedMeasurement<RatingUnit>?
        var userProfileIndex: MessageIndex?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                //print("WeightScaleMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {


                case .weight:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        /// 100 * kg + 0
                        weight = Weight(rawValue: value, scale: 100.0)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            weight = Weight(rawValue: UInt16(definition.baseType.invalid), scale: 100.0)
                        }
                    }

                case .percentFat:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * % + 0
                        let value = Double(value) / 100.0
                        percentFat = Measurement(value: value, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            percentFat = Measurement(value: Double(definition.baseType.invalid), unit: UnitPercent.percent)
                        }
                    }

                case .percentHydration:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * % + 0
                        let value = Double(value) / 100.0
                        percentHydration = Measurement(value: value, unit: UnitPercent.percent)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            percentHydration = Measurement(value: Double(definition.baseType.invalid), unit: UnitPercent.percent)
                        }
                    }

                case .visceralFatMass:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * kg + 0
                        let value = Double(value) / 100.0
                        visceralFatMass = Measurement(value: value, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            visceralFatMass = Measurement(value: Double(definition.baseType.invalid), unit: UnitMass.kilograms)
                        }
                    }

                case .boneMass:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * kg + 0
                        let value = Double(value) / 100.0
                        boneMass = Measurement(value: value, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            boneMass = Measurement(value: Double(definition.baseType.invalid), unit: UnitMass.kilograms)
                        }
                    }

                case .muscleMass:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * kg + 0
                        let value = Double(value) / 100.0
                        muscleMass = Measurement(value: value, unit: UnitMass.kilograms)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            muscleMass = Measurement(value: Double(definition.baseType.invalid), unit: UnitMass.kilograms)
                        }
                    }

                case .basalMet:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 4 * kcal/day + 0
                        let value = Double(value) / 4.0
                        basalMet = Measurement(value: value, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            basalMet = Measurement(value: Double(definition.baseType.invalid), unit: UnitEnergy.kilocalories)
                        }
                    }

                case .physiqueRating:
                    let value = localDecoder.decodeUInt8()
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
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 4 * kcal/day + 0
                        let value = Double(value) / 4.0
                        activeMet = Measurement(value: value, unit: UnitEnergy.kilocalories)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            activeMet = Measurement(value: Double(definition.baseType.invalid), unit: UnitEnergy.kilocalories)
                        }
                    }

                case .metabolicAge:
                    let value = localDecoder.decodeUInt8()
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
                    let value = localDecoder.decodeUInt8()
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

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension WeightScaleMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case weight                 = 0
        case percentFat             = 1
        case percentHydration       = 2
        case visceralFatMass        = 3
        case boneMass               = 4
        case muscleMass             = 5
        case basalMet               = 7
        case physiqueRating         = 8
        case activeMet              = 9
        case metabolicAge           = 10
        case visceralFatRating      = 11
        case userProfileIndex       = 12

        case timestamp              = 253

    }
}
