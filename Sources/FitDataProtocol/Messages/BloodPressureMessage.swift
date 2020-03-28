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
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class BloodPressureMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 51 }
    
    /// Systolic Pressure
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 0,
                       unit: UnitPressure.millimetersOfMercury)
    private(set) public var systolicPressure: Measurement<UnitPressure>?
    
    /// Diastolic Pressure
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 1,
                       unit: UnitPressure.millimetersOfMercury)
    private(set) public var diastolicPressure: Measurement<UnitPressure>?
    
    /// Mean Arterial Pressure
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 2,
                       unit: UnitPressure.millimetersOfMercury)
    private(set) public var meanArterialPressure: Measurement<UnitPressure>?
    
    /// MAP  Sample Mean
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitPressure.millimetersOfMercury)
    private(set) public var mapSampleMean: Measurement<UnitPressure>?
    
    /// MAP Morning Values
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitPressure.millimetersOfMercury)
    private(set) public var mapMorningValues: Measurement<UnitPressure>?
    
    /// MAP Evening Values
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 5,
                       unit: UnitPressure.millimetersOfMercury)
    private(set) public var mapEveningValues: Measurement<UnitPressure>?
    
    /// Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 6,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var heartRate: Measurement<UnitCadence>?
    
    /// Heart Rate Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var heartRateType: HeartRateType?
    
    /// Blood Pressure Status
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private(set) public var status: BloodPressureStatus?
    
    /// User Profile Index
    ///
    /// Associates this blood pressure message to a user.  This corresponds to the index of the user profile message in the blood pressure file.
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 9)
    private(set) public var userProfileIndex: MessageIndex?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$systolicPressure.owner = self
        self.$diastolicPressure.owner = self
        self.$meanArterialPressure.owner = self
        self.$mapSampleMean.owner = self
        self.$mapMorningValues.owner = self
        self.$mapEveningValues.owner = self
        self.$heartRate.owner = self
        self.$heartRateType.owner = self
        self.$status.owner = self
        self.$userProfileIndex.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            systolicPressure: Measurement<UnitPressure>? = nil,
                            diastolicPressure: Measurement<UnitPressure>? = nil,
                            meanArterialPressure: Measurement<UnitPressure>? = nil,
                            mapSampleMean: Measurement<UnitPressure>? = nil,
                            mapMorningValues: Measurement<UnitPressure>? = nil,
                            mapEveningValues: Measurement<UnitPressure>? = nil,
                            heartRate: UInt8? = nil,
                            heartRateType: HeartRateType? = nil,
                            status: BloodPressureStatus? = nil,
                            userProfileIndex: MessageIndex? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.systolicPressure = systolicPressure
        self.diastolicPressure = diastolicPressure
        self.meanArterialPressure = meanArterialPressure
        self.mapSampleMean = mapSampleMean
        self.mapMorningValues = mapMorningValues
        self.mapEveningValues = mapEveningValues
        
        if let hr = heartRate {
            self.heartRate = Measurement(value: Double(hr), unit: self.$heartRate.unitType)
        }
        
        self.heartRateType = heartRateType
        self.status = status
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
        
        let msg = BloodPressureMessage(fieldDict: fieldDict,
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
                                           globalMessageNumber: BloodPressureMessage.globalMessageNumber(),
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
