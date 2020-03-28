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
    
    /// Weight
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var weight: Weight?
    
    /// Percent Fat
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 1,
                  unit: UnitPercent.percent)
    private(set) public var percentFat: Measurement<UnitPercent>?
    
    /// Percent Hydration
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 2,
                  unit: UnitPercent.percent)
    private(set) public var percentHydration: Measurement<UnitPercent>?
    
    /// Visceral Fat Mass
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitMass.kilograms)
    private(set) public var visceralFatMass: Measurement<UnitMass>?
    
    /// Bone Mass
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitMass.kilograms)
    private(set) public var boneMass: Measurement<UnitMass>?
    
    /// Muscle Mass
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 5,
                       unit: UnitMass.kilograms)
    private(set) public var muscleMass: Measurement<UnitMass>?
    
    /// Basal MET
    ///
    /// Units are per day
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 4.0, offset: 0.0)),
                       fieldNumber: 7,
                       unit: UnitEnergy.kilocalories)
    private(set) public var basalMet: Measurement<UnitEnergy>?
    
    /// Physique Rating
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 8,
                  unit: RatingUnit.physique)
    private(set) public var physiqueRating: Measurement<RatingUnit>?
    
    /// Active MET
    ///
    /// Units are per day
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 4.0, offset: 0.0)),
                       fieldNumber: 9,
                       unit: UnitEnergy.kilocalories)
    private(set) public var activeMet: Measurement<UnitEnergy>?
    
    /// Metabolic Age
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 10,
                       unit: UnitDuration.year)
    private(set) public var metabolicAge: Measurement<UnitDuration>?
    
    /// Visceral Fat Rating
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 11,
                  unit: RatingUnit.visceralFat)
    private(set) public var visceralFatRating: Measurement<RatingUnit>?
    
    /// User Profile Index
    ///
    /// Associates this blood pressure message to a user.  This corresponds to the index of the user profile message in the blood pressure file.
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 12)
    private(set) public var userProfileIndex: MessageIndex?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$weight.owner = self
        self.$percentFat.owner = self
        self.$percentHydration.owner = self
        self.$visceralFatMass.owner = self
        self.$boneMass.owner = self
        self.$muscleMass.owner = self
        self.$basalMet.owner = self
        self.$physiqueRating.owner = self
        self.$activeMet.owner = self
        self.$metabolicAge.owner = self
        self.$visceralFatRating.owner = self
        self.$userProfileIndex.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            weight: Weight? = nil,
                            percentFat: Measurement<UnitPercent>? = nil,
                            percentHydration: Measurement<UnitPercent>? = nil,
                            visceralFatMass: Measurement<UnitMass>? = nil,
                            boneMass: Measurement<UnitMass>? = nil,
                            muscleMass: Measurement<UnitMass>? = nil,
                            basalMet: Measurement<UnitEnergy>? = nil,
                            physiqueRating: UInt8? = nil,
                            activeMet: Measurement<UnitEnergy>? = nil,
                            metabolicAge: Measurement<UnitDuration>? = nil,
                            visceralFatRating: UInt8? = nil,
                            userProfileIndex: MessageIndex? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.weight = weight
        self.percentFat = percentFat
        self.percentHydration = percentHydration
        self.visceralFatMass = visceralFatMass
        self.boneMass = boneMass
        self.muscleMass = muscleMass
        self.basalMet = basalMet
        
        if let physiqueRating = physiqueRating {
            self.physiqueRating = Measurement(value: Double(physiqueRating), unit: self.$physiqueRating.unitType)
        }
        
        self.activeMet = activeMet
        self.metabolicAge = metabolicAge
        
        if let visceralFatRating = visceralFatRating {
            self.visceralFatRating = Measurement(value: Double(visceralFatRating), unit: self.$visceralFatRating.unitType)
        }
        
        self.userProfileIndex = userProfileIndex
    }
    
    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    /// - Returns: FitMessage Result
    override func decode<F>(fieldData: FieldData, definition: DefinitionMessage) -> Result<F, FitDecodingError> where F: FitMessage {
        var testDecoder = DecodeData()
        
        var fieldDict: [UInt8: FieldDefinition] = [UInt8: FieldDefinition]()
        var fieldDataDict: [UInt8: Data] = [UInt8: Data]()
        
        for definition in definition.fieldDefinitions {
            let fieldData = testDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
            
            fieldDict[definition.fieldDefinitionNumber] = definition
            fieldDataDict[definition.fieldDefinitionNumber] = fieldData
        }
        
        let msg = WeightScaleMessage(fieldDict: fieldDict,
                                     fieldDataDict: fieldDataDict,
                                     architecture: definition.architecture)
        
        let devData = self.decodeDeveloperData(data: fieldData, definition: definition)
        msg.developerData = devData.isEmpty ? nil : devData
        
        return .success(msg as! F)
    }
    
    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: WeightScaleMessage.globalMessageNumber(),
                                           fields: UInt8(fields.count),
                                           fieldDefinitions: fields,
                                           developerFieldDefinitions: [DeveloperFieldDefinition]())
        
        return.success(defMessage)
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
        
        return self.encodeMessageFields(localMessageType: localMessageType)
    }
}
