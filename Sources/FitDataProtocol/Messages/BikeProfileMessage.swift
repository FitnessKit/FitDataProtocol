//
//  BikeProfileMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/27/19.
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

/// Bike Profile Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class BikeProfileMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 6 }
    
    /// Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var name: String?
    
    /// Sport
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var sport: Sport?
    
    /// Sub Sport
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var subSport: SubSport?
    
    /// Odometer
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitLength.meters)
    private(set) public var odometer: Measurement<UnitLength>?
    
    /// Bike Speed ANT Id
    @FitField(base: BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var speedAntId: UInt16?
    
    /// Bike Cadence ANT Id
    @FitField(base: BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var cadenceAntId: UInt16?
    
    /// Bike Speed Cadence ANT Id
    @FitField(base: BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var speedCadenceAntId: UInt16?
    
    /// Bike Power ANT Id
    @FitField(base: BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var powerAntId: UInt16?
    
    /// Custom Wheel Size
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 8,
                       unit: UnitLength.meters)
    private(set) public var customWheelSize: Measurement<UnitLength>?
    
    /// Auto Wheel Size
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 9,
                       unit: UnitLength.meters)
    private(set) public var autoWheelSize: Measurement<UnitLength>?
    
    /// Bike Weight
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 10,
                       unit: UnitMass.kilograms)
    private(set) public var bikeWeight: Measurement<UnitMass>?
    
    /// Power Calibration Factor
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 11,
                  unit: UnitPercent.percent)
    private(set) public var powerCalibrationFactor: Measurement<UnitPercent>?
    
    /// Auto Wheel Calibration
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 12)
    private(set) public var autoWheelCalibration: Bool?
    
    /// Auto Power Zero
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 13)
    private(set) public var autoPowerZero: Bool?
    
    /// Id
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 14)
    private(set) public var id: UInt8?
    
    /// Speed Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 15)
    private(set) public var speedEnabled: Bool?
    
    /// Cadence Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 16)
    private(set) public var cadenceEnabled: Bool?
    
    /// Speed Cadence Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 17)
    private(set) public var speedCadenceEnabled: Bool?
    
    /// Power Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 18)
    private(set) public var powerEnabled: Bool?
    
    /// Crank Length
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: -110.0)),
                       fieldNumber: 19,
                       unit: UnitLength.millimeters)
    private(set) public var crankLength: Measurement<UnitLength>?
    
    /// Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 20)
    private(set) public var enbled: Bool?
    
    /// Speed Transmission Type
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 21)
    private(set) public var speedTransmissionType: TransmissionType?
    
    /// Cadence Transmission Type
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 22)
    private(set) public var cadenceTransmissionType: TransmissionType?
    
    /// Speed Cadence Transmission Type
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 23)
    private(set) public var speedCadenceTransmissionType: TransmissionType?
    
    /// Power Transmission Type
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 24)
    private(set) public var powerTransmissionType: TransmissionType?
    
    /// Odometer Rollover
    ///
    /// Rollover counter that can be used to extend the odometer
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 37)
    private(set) public var odometerRollover: UInt8?
    
    /// Number of Front Gears
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 38)
    private(set) public var frontGears: UInt8?
    
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 39)
    private var _frontGearTeeth: Data?
    
    /// Font Gear Teeth
    ///
    /// Number of Teeth on Each Gear
    ///
    /// - note: 0 is innermost
    private(set) public var frontGearTeeth: [UInt8]? {
        get {
            if let values = self.fieldDataDict[self.$_frontGearTeeth.fieldNumber]?.segment(size: MemoryLayout<UInt8>.size) {
                var teeth = [UInt8]()
                for val in values {
                    teeth.append(val.to(type: UInt8.self))
                }
            }
            
            return nil
        }
        set {
            if let newValue = newValue {
                self._frontGearTeeth = Data(newValue)
            } else {
                self._frontGearTeeth = nil
            }
        }
    }
    
    /// Number of Rear Gears
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 40)
    private(set) public var rearGears: UInt8?
    
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 41)
    private var _rearGearTeeth: Data?
    
    /// Rear Gear Teeth
    ///
    /// Number of Teeth on Each Gear
    ///
    /// - note: 0 is innermost
    private(set) public var rearGearTeeth: [UInt8]? {
        get {
            if let values = _rearGearTeeth?.segment(size: MemoryLayout<UInt8>.size) {
                var teeth = [UInt8]()
                for val in values {
                    teeth.append(val.to(type: UInt8.self))
                }
            }
            
            return nil
        }
        set {
            if let newValue = newValue {
                self._rearGearTeeth = Data(newValue)
            } else {
                self._rearGearTeeth = nil
            }
        }
    }
    
    /// Shimano Di2 Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 44)
    private(set) public var shimanoDi2Enabled: Bool?
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 254)
    private(set) public var messageIndex: MessageIndex?
    
    public required init() {
        super.init()
        
        self.$messageIndex.owner = self
        
        self.$name.owner = self
        self.$sport.owner = self
        self.$subSport.owner = self
        self.$odometer.owner = self
        self.$speedAntId.owner = self
        self.$cadenceAntId.owner = self
        self.$speedCadenceAntId.owner = self
        self.$powerAntId.owner = self
        self.$customWheelSize.owner = self
        self.$autoWheelSize.owner = self
        self.$bikeWeight.owner = self
        self.$powerCalibrationFactor.owner = self
        self.$autoWheelCalibration.owner = self
        self.$autoPowerZero.owner = self
        self.$id.owner = self
        self.$speedEnabled.owner = nil
        self.$cadenceEnabled.owner = nil
        self.$speedCadenceEnabled.owner = nil
        self.$powerEnabled.owner = self
        self.$crankLength.owner = self
        self.$enbled.owner = self
        self.$speedTransmissionType.owner = self
        self.$cadenceTransmissionType.owner = self
        self.$speedCadenceTransmissionType.owner = self
        self.$powerTransmissionType.owner = self
        self.$odometerRollover.owner = self
        self.$frontGears.owner = self
        self.$_frontGearTeeth.owner = self
        self.$rearGears.owner = self
        self.$_rearGearTeeth.owner = self
        self.$shimanoDi2Enabled.owner = self
    }
    
    public convenience init(messageIndex: MessageIndex? = nil,
                            name: String? = nil,
                            sport: Sport? = nil,
                            subSport: SubSport? = nil,
                            odometer: Measurement<UnitLength>? = nil,
                            speedAntId: UInt16? = nil,
                            cadenceAntId: UInt16? = nil,
                            speedCadenceAntId: UInt16? = nil,
                            powerAntId: UInt16? = nil,
                            customWheelSize: Measurement<UnitLength>? = nil,
                            autoWheelSize: Measurement<UnitLength>? = nil,
                            bikeWeight: Measurement<UnitMass>? = nil,
                            powerCalibrationFactor: Measurement<UnitPercent>? = nil,
                            autoWheelCalibration: Bool? = nil,
                            autoPowerZero: Bool? = nil,
                            id: UInt8?,
                            speedEnabled: Bool? = nil,
                            cadenceEnabled: Bool? = nil,
                            speedCadenceEnabled: Bool? = nil,
                            powerEnabled: Bool? = nil,
                            crankLength: Measurement<UnitLength>? = nil,
                            enbled: Bool? = nil,
                            speedTransmissionType: TransmissionType? = nil,
                            cadenceTransmissionType: TransmissionType? = nil,
                            speedCadenceTransmissionType: TransmissionType? = nil,
                            powerTransmissionType: TransmissionType? = nil,
                            odometerRollover: UInt8? = nil,
                            frontGears: UInt8? = nil,
                            frontGearTeeth: [UInt8]? = nil,
                            rearGears: UInt8? = nil,
                            rearGearTeeth: [UInt8]? = nil,
                            shimanoDi2Enabled: Bool? = nil) {
        self.init()
        
        precondition(frontGears ?? 0 == frontGearTeeth?.count ?? 0, "frontGearTeeth count must equal fontGears")
        precondition(rearGears ?? 0 == rearGearTeeth?.count ?? 0, "rearGearTeeth count must equal rearGears")
        
        self.messageIndex = messageIndex
        
        self.name = name
        self.sport = sport
        self.subSport = subSport
        self.odometer = odometer
        self.speedAntId = speedAntId
        self.cadenceAntId = cadenceAntId
        self.speedCadenceAntId = speedCadenceAntId
        self.powerAntId = powerAntId
        self.customWheelSize = customWheelSize
        self.autoWheelSize = autoWheelSize
        self.bikeWeight = bikeWeight
        self.powerCalibrationFactor = powerCalibrationFactor
        self.autoWheelCalibration = autoWheelCalibration
        self.autoPowerZero = autoPowerZero
        self.id = id
        self.speedEnabled = speedEnabled
        self.cadenceEnabled = cadenceEnabled
        self.speedCadenceEnabled = speedCadenceEnabled
        self.powerEnabled = powerEnabled
        self.crankLength = crankLength
        self.enbled = enbled
        self.speedTransmissionType = speedTransmissionType
        self.cadenceTransmissionType = cadenceTransmissionType
        self.speedCadenceTransmissionType = speedCadenceTransmissionType
        self.powerTransmissionType = powerTransmissionType
        self.odometerRollover = odometerRollover
        self.frontGears = frontGears
        self.frontGearTeeth = frontGearTeeth
        self.rearGears = rearGears
        self.rearGearTeeth = rearGearTeeth
        self.shimanoDi2Enabled = shimanoDi2Enabled
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
        
        let msg = BikeProfileMessage(fieldDict: fieldDict,
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
        
        guard name?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("name size can not exceed 255"))
        }
        
        guard frontGears ?? 0 == frontGearTeeth?.count ?? 0 else {
            return.failure(FitEncodingError.properySize("frontGearTeeth count must equal fontGears"))
        }
        
        guard rearGears ?? 0 == rearGearTeeth?.count ?? 0 else {
            return.failure(FitEncodingError.properySize("rearGearTeeth count must equal rearGears"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: HeartrateProfileMessage.globalMessageNumber(),
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
