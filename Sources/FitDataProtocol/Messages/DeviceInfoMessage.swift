//
//  DeviceInfoMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/4/18.
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

/// FIT Device Information Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeviceInfoMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 23 }
    
    /// Device Index
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var deviceIndex: DeviceIndex?
    
    /// Device Type
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var deviceType: DeviceType?
    
    /// Manufacturer
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var manufacturer: Manufacturer?
    
    /// Serial Number
    @FitField(base: BaseTypeData(type: .uint32z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 3)
    private(set) public var serialNumber: UInt32?
    
    /// Product
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var product: UInt16?
    
    /// Software Version
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var softwareVersion: UInt16?
    
    /// Hardware Version
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var hardwareVersion: UInt8?
    
    /// Cumulative Operating Time
    ///
    /// Reset by new battery or charge
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 7,
                       unit: UnitDuration.seconds)
    private(set) public var cumulativeOpTime: Measurement<UnitDuration>?
    
    /// Battery Voltage
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 256.0, offset: 0.0)),
                       fieldNumber: 10,
                       unit: UnitElectricPotentialDifference.volts)
    private(set) public var batteryVoltage: Measurement<UnitElectricPotentialDifference>?
    
    /// Battery Status
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 11)
    private(set) public var batteryStatus: BatteryStatus?
    
    /// Sensor Body Location
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 18)
    private(set) public var bodylocation: BodyLocation?
    
    /// Sensor Description
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 19)
    private(set) public var sensorDescription: String?
    
    /// Transmission Type
    @FitField(base: BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 20)
    private(set) public var transmissionType: TransmissionType?
    
    /// Device Number
    @FitField(base: BaseTypeData(type: .uint16z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 20)
    private(set) public var deviceNumber: UInt16?
    
    /// ANT Network Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 22)
    private(set) public var antNetwork: NetworkType?
    
    /// Source
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 25)
    private(set) public var source: SourceType?
    
    /// Product Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 27)
    private(set) public var productName: String?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$deviceIndex.owner = self
        self.$deviceType.owner = self
        self.$manufacturer.owner = self
        self.$serialNumber.owner = self
        self.$product.owner = self
        self.$softwareVersion.owner = self
        self.$hardwareVersion.owner = self
        self.$cumulativeOpTime.owner = self
        self.$batteryVoltage.owner = self
        self.$batteryStatus.owner = self
        self.$bodylocation.owner = self
        self.$sensorDescription.owner = self
        self.$transmissionType.owner = self
        self.$deviceNumber.owner = self
        self.$antNetwork.owner = self
        self.$source.owner = self
        self.$productName.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            serialNumber: UInt32? = nil,
                            cumulativeOpTime: Measurement<UnitDuration>? = nil,
                            productName: String? = nil,
                            manufacturer: Manufacturer? = nil,
                            product: UInt16? = nil,
                            softwareVersion: UInt16? = nil,
                            hardwareVersion: UInt8? = nil,
                            batteryVoltage: Measurement<UnitElectricPotentialDifference>? = nil,
                            batteryStatus: BatteryStatus? = nil,
                            deviceNumber: UInt16? = nil,
                            deviceType: DeviceType? = nil,
                            deviceIndex: DeviceIndex? = nil,
                            sensorDescription: String? = nil,
                            bodylocation: BodyLocation? = nil,
                            transmissionType: TransmissionType? = nil,
                            antNetwork: NetworkType? = nil,
                            source: SourceType? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.serialNumber = serialNumber
        self.cumulativeOpTime = cumulativeOpTime
        self.productName = productName
        self.manufacturer = manufacturer
        self.product = product
        self.softwareVersion = softwareVersion
        self.hardwareVersion = hardwareVersion
        self.batteryVoltage = batteryVoltage
        self.batteryStatus = batteryStatus
        self.deviceNumber = deviceNumber
        self.deviceType = deviceType
        self.deviceIndex = deviceIndex
        self.sensorDescription = sensorDescription
        self.bodylocation = bodylocation
        self.transmissionType = transmissionType
        self.antNetwork = antNetwork
        self.source = source
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
        
        let msg = DeviceInfoMessage(fieldDict: fieldDict,
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
        
        do {
            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
        } catch let error as FitEncodingError {
            return.failure(error)
        } catch {
            return.failure(FitEncodingError.fileType(error.localizedDescription))
        }
        
        guard sensorDescription?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("sensorDescription size can not exceed 255"))
        }
        
        guard productName?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("productName size can not exceed 255"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: DeviceInfoMessage.globalMessageNumber(),
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

extension DeviceInfoMessage: MessageValidator {
    
    /// Validate Message
    ///
    /// - Parameters:
    ///   - fileType: FileType the Message is being used in
    ///   - dataValidityStrategy: Data Validity Strategy
    /// - Throws: FitError
    internal func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws {
        
        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: false)
            }
        case .garminConnect:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: true)
            }
        }
    }
    
    private func validateActivity(isGarmin: Bool) throws {
        
        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"
        
        guard self.timeStamp != nil else {
            throw FitEncodingError.fileType("\(msg) require DeviceInfoMessage to contain timeStamp, can not be nil")
        }
        
    }
}
