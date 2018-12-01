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
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WeightScaleMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 30 }

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

    public init(timeStamp: FitTime? = nil,
                weight: Weight? = nil,
                percentFat: ValidatedMeasurement<UnitPercent>? = nil,
                percentHydration: ValidatedMeasurement<UnitPercent>? = nil,
                visceralFatMass: ValidatedMeasurement<UnitMass>? = nil,
                boneMass: ValidatedMeasurement<UnitMass>? = nil,
                muscleMass: ValidatedMeasurement<UnitMass>? = nil,
                basalMet: ValidatedMeasurement<UnitEnergy>? = nil,
                physiqueRating: ValidatedMeasurement<RatingUnit>? = nil,
                activeMet: ValidatedMeasurement<UnitEnergy>? = nil,
                metabolicAge: ValidatedMeasurement<UnitDuration>? = nil,
                visceralFatRating: ValidatedMeasurement<RatingUnit>? = nil,
                userProfileIndex: MessageIndex? = nil) {

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

        var timestamp: FitTime?
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
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        /// 100 * kg + 0
                        weight = Weight(rawValue: value, scale: 100.0)
                    } else {
                        if let value = ValidatedBinaryInteger<UInt16>.invalidValue(definition.baseType, dataStrategy: dataStrategy) {
                            weight = Weight(rawValue: value.value, scale: 1.0, valid: false)
                        } else {
                            weight = nil
                        }
                    }

                case .percentFat:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        percentFat = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        percentFat = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .percentHydration:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * % + 0
                        let value = value.resolution(1 / 100)
                        percentHydration = ValidatedMeasurement(value: value, valid: true, unit: UnitPercent.percent)
                    } else {
                        percentHydration = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitPercent.percent)
                    }

                case .visceralFatMass:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * kg + 0
                        let value = value.resolution(1 / 100)
                        visceralFatMass = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {
                        visceralFatMass = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitMass.kilograms)
                    }

                case .boneMass:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * kg + 0
                        let value = value.resolution(1 / 100)
                        boneMass = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {
                        boneMass = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitMass.kilograms)
                    }

                case .muscleMass:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 100 * kg + 0
                        let value = value.resolution(1 / 100)
                        muscleMass = ValidatedMeasurement(value: value, valid: true, unit: UnitMass.kilograms)
                    } else {
                        muscleMass = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitMass.kilograms)
                    }

                case .basalMet:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 4 * kcal/day + 0
                        let value = value.resolution(1 / 4)
                        basalMet = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        basalMet = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .physiqueRating:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        let value = Double(value)
                        physiqueRating = ValidatedMeasurement(value: value, valid: true, unit: RatingUnit.physique)
                    } else {
                        physiqueRating = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: RatingUnit.physique)
                    }

                case .activeMet:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 4 * kcal/day + 0
                        let value = value.resolution(1 / 4)
                        activeMet = ValidatedMeasurement(value: value, valid: true, unit: UnitEnergy.kilocalories)
                    } else {
                        activeMet = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitEnergy.kilocalories)
                    }

                case .metabolicAge:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        /// 1 * years
                        let value = Double(value)
                        metabolicAge = ValidatedMeasurement(value: value, valid: true, unit: UnitDuration.year)
                    } else {
                        metabolicAge = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: UnitDuration.year)
                    }

                case .visceralFatRating:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        let value = Double(value)
                        visceralFatRating = ValidatedMeasurement(value: value, valid: true, unit: RatingUnit.visceralFat)
                    } else {
                        visceralFatRating = ValidatedMeasurement.invalidValue(definition.baseType, dataStrategy: dataStrategy, unit: RatingUnit.visceralFat)
                    }


                case .userProfileIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        userProfileIndex = MessageIndex(value: value)
                    }

                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                }
            }
        }

        return WeightScaleMessage(timeStamp: timestamp,
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

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .weight:
                if let weight = weight {
                    msgData.append(weight.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .percentFat:
                if let percentFat = percentFat {
                    // 100 * % + 0
                    let value = percentFat.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .percentHydration:
                if let percentHydration = percentHydration {
                    // 100 * % + 0
                    let value = percentHydration.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .visceralFatMass:
                if var visceralFatMass = visceralFatMass {
                    // 100 * kg + 0
                    visceralFatMass = visceralFatMass.converted(to: UnitMass.kilograms)

                    let value = visceralFatMass.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .boneMass:
                if var boneMass = boneMass {
                    // 100 * kg + 0
                    boneMass = boneMass.converted(to: UnitMass.kilograms)

                    let value = boneMass.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .muscleMass:
                if var muscleMass = muscleMass {
                    // 100 * kg + 0
                    muscleMass = muscleMass.converted(to: UnitMass.kilograms)

                    let value = muscleMass.value.resolutionUInt16(100)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .basalMet:
                if var basalMet = basalMet {
                    // 4 * kcal/day + 0
                    basalMet = basalMet.converted(to: UnitEnergy.kilocalories)

                    let value = basalMet.value.resolutionUInt16(4)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .physiqueRating:
                if let physiqueRating = physiqueRating {
                    let value = physiqueRating.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .activeMet:
                if var activeMet = activeMet {
                    // 4 * kcal/day + 0
                    activeMet = activeMet.converted(to: UnitEnergy.kilocalories)

                    let value = activeMet.value.resolutionUInt16(4)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .metabolicAge:
                if var metabolicAge = metabolicAge {
                    /// 1 * years
                    metabolicAge = metabolicAge.converted(to: UnitDuration.year)
                    let value = metabolicAge.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .visceralFatRating:
                if let visceralFatRating = visceralFatRating {
                    let value = visceralFatRating.value.resolutionUInt8(1)

                    msgData.append(value)

                    fileDefs.append(key.fieldDefinition())
                }


            case .userProfileIndex:
                if let userProfileIndex = userProfileIndex {
                    msgData.append(userProfileIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: WeightScaleMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "WeightScaleMessage contains no Properties Available to Encode"))
        }
    }
}
