//
//  UserProfileMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
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
import AntMessageProtocol
import FitnessUnits

/// FIT File User Profile Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class UserProfileMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 3 }
    
    /// Friendly Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var friendlyName: String?
    
    /// Gender
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var gender: Gender?
    
    /// Age in Years
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 2,
                       unit: UnitDuration.year)
    private(set) public var age: Measurement<UnitDuration>?
    
    /// Height
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitLength.meters)
    private(set) public var height: Measurement<UnitLength>?
    
    /// Weight
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitMass.kilograms)
    private(set) public var weight: Measurement<UnitMass>?
    
    /// Language
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var language: Language?
    
    /// Elevation Settings
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var elevationSetting: MeasurementDisplayType?
    
    /// Weight Settings
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var weightSetting: MeasurementDisplayType?
    
    /// Resting Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 8,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var restingHeartRate: Measurement<UnitCadence>?
    
    /// Max Running Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 9,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var maxRunningHeartRate: Measurement<UnitCadence>?
    
    /// Max Biking Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 10,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var maxBikingHeartRate: Measurement<UnitCadence>?
    
    /// Max Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 11,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var maxHeartRate: Measurement<UnitCadence>?
    
    /// Heartrate Display Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 12)
    private(set) public var heartRateSetting: HeartRateDisplayType?
    
    /// Speed Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 13)
    private(set) public var speedSetting: MeasurementDisplayType?
    
    /// Distance Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 14)
    private(set) public var distanceSetting: PositionDisplayType?
    
    /// Power Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 16)
    private(set) public var powerSetting: PowerDisplayType?
    
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 17)
    private(set) public var activityClass: UInt8?
    
    /// Position Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 18)
    private(set) public var positionSetting: PositionDisplayType?
    
    /// Temperature Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 21)
    private(set) public var temperatureSetting: MeasurementDisplayType?
    
    /// Local ID
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 22)
    private(set) public var localId: UInt16?
    
    /// Local ID
    @FitField(base: BaseTypeData(type: .byte, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 23)
    private(set) public var globalId: Data?
    
    /// Height Setting
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 30)
    private(set) public var heightSetting: MeasurementDisplayType?
    
    /// Running Step Length
    ///
    /// User defined running step length set to 0 for auto length
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 31,
                       unit: UnitLength.meters)
    private(set) public var runningStepLength: Measurement<UnitLength>?
    
    /// Walking Step Length
    ///
    /// User defined step length set to 0 for auto length
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 32,
                       unit: UnitLength.meters)
    private(set) public var walkingStepLength: Measurement<UnitLength>?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 254)
    private(set) public var messageIndex: MessageIndex?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        self.$messageIndex.owner = self
        
        self.$friendlyName.owner = self
        self.$gender.owner = self
        self.$age.owner = self
        self.$height.owner = self
        self.$weight.owner = self
        self.$language.owner = self
        self.$elevationSetting.owner = self
        self.$weightSetting.owner = self
        self.$restingHeartRate.owner = self
        self.$maxRunningHeartRate.owner = self
        self.$maxBikingHeartRate.owner = self
        self.$maxHeartRate.owner = self
        self.$heartRateSetting.owner = self
        self.$speedSetting.owner = self
        self.$powerSetting.owner = self
        self.$activityClass.owner = self
        self.$positionSetting.owner = self
        self.$temperatureSetting.owner = self
        self.$localId.owner = self
        self.$globalId.owner = self
        self.$heightSetting.owner = self
        self.$runningStepLength.owner = self
        self.$walkingStepLength.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            messageIndex: MessageIndex? = nil,
                            friendlyName: String? = nil,
                            weight: Measurement<UnitMass>? = nil,
                            speedSetting: MeasurementDisplayType? = nil,
                            heartRateSetting: HeartRateDisplayType? = nil,
                            distanceSetting: PositionDisplayType? = nil,
                            powerSetting: PowerDisplayType? = nil,
                            positionSetting: PositionDisplayType? = nil,
                            temperatureSetting: MeasurementDisplayType? = nil,
                            localId: UInt16? = nil,
                            heightSetting: MeasurementDisplayType? = nil,
                            runningStepLength: Measurement<UnitLength>? = nil,
                            walkingStepLength: Measurement<UnitLength>? = nil,
                            gender: Gender? = nil,
                            age: UInt8? = nil,
                            height: Measurement<UnitLength>? = nil,
                            language: Language? = nil,
                            elevationSetting: MeasurementDisplayType? = nil,
                            weightSetting: MeasurementDisplayType? = nil,
                            restingHeartRate: UInt8? = nil,
                            maxRunningHeartRate: UInt8? = nil,
                            maxBikingHeartRate: UInt8? = nil,
                            maxHeartRate: UInt8? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex
        
        self.friendlyName = friendlyName
        self.weight = weight
        self.speedSetting = speedSetting
        self.heartRateSetting = heartRateSetting
        self.distanceSetting = distanceSetting
        self.powerSetting = powerSetting
        self.positionSetting = positionSetting
        self.temperatureSetting = temperatureSetting
        self.localId = localId
        self.heightSetting = heightSetting
        self.runningStepLength = runningStepLength
        self.walkingStepLength = walkingStepLength
        self.gender = gender
        
        if let age = age {
            self.age = Measurement(value: Double(age), unit: self.$age.unitType)
        }
        
        self.height = height
        self.language = language
        self.elevationSetting = elevationSetting
        self.weightSetting = weightSetting
        
        if let hr = restingHeartRate {
            self.restingHeartRate = Measurement(value: Double(hr), unit: self.$restingHeartRate.unitType)
        }
        
        if let hr = maxRunningHeartRate {
            self.maxRunningHeartRate = Measurement(value: Double(hr), unit: self.$maxRunningHeartRate.unitType)
        }
        
        if let hr = maxBikingHeartRate {
            self.maxBikingHeartRate = Measurement(value: Double(hr), unit: self.$maxBikingHeartRate.unitType)
        }
        
        if let hr = maxHeartRate {
            self.maxHeartRate = Measurement(value: Double(hr), unit: self.$maxHeartRate.unitType)
        }
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
        
        let msg = UserProfileMessage(fieldDict: fieldDict,
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
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError>  {
        
        guard friendlyName?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("friendlyName size can not exceed 255"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: UserProfileMessage.globalMessageNumber(),
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
