//
//  ConnectivityMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/29/18.
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

/// Connectivity Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ConnectivityMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 127 }
    
    /// Bluetooth Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var bluetoothEnabled: Bool?
    
    /// Bluetooth Low Energy Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var bluetoothLowEnergyEnable: Bool?
    
    /// ANT Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var antEnabled: Bool?
    
    /// Connectivity Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 3)
    private(set) public var name: String?
    
    /// Live Tracking Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var liveTrackingEnabled: Bool?
    
    /// Weather Conditions Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var weatherConditionsEnabled: Bool?
    
    /// Weather Alerts Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var weatherAlertsEnabled: Bool?
    
    /// Auto Activity Upload Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var autoActivityUploadEnabled: Bool?
    
    /// Course Download Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private(set) public var courseDownloadEnabled: Bool?
    
    /// Workout Download Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 9)
    private(set) public var workoutDownloadEnabled: Bool?
    
    /// GPS Ephemeris Download Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 10)
    private(set) public var gpsEphemerisDownloadEnabled: Bool?
    
    /// Incident Detection Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 11)
    private(set) public var incidentDetectionEnabled: Bool?
    
    /// Group Tracking Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 12)
    private(set) public var groupTrackEnabled: Bool?
    
    public required init() {
        super.init()
        
        self.$bluetoothEnabled.owner = self
        self.$bluetoothLowEnergyEnable.owner = self
        self.$antEnabled.owner = self
        self.$name.owner = self
        self.$liveTrackingEnabled.owner = self
        self.$weatherConditionsEnabled.owner = self
        self.$weatherAlertsEnabled.owner = self
        self.$autoActivityUploadEnabled.owner = self
        self.$courseDownloadEnabled.owner = self
        self.$workoutDownloadEnabled.owner = self
        self.$gpsEphemerisDownloadEnabled.owner = self
        self.$incidentDetectionEnabled.owner = self
        self.$groupTrackEnabled.owner = self
    }
    
    public convenience init(bluetoothEnabled: Bool? = nil,
                            bluetoothLowEnergyEnable: Bool? = nil,
                            antEnabled: Bool? = nil,
                            name: String? = nil,
                            liveTrackingEnabled: Bool? = nil,
                            weatherConditionsEnabled: Bool? = nil,
                            weatherAlertsEnabled: Bool? = nil,
                            autoActivityUploadEnabled: Bool? = nil,
                            courseDownloadEnabled: Bool? = nil,
                            workoutDownloadEnabled: Bool? = nil,
                            gpsEphemerisDownloadEnabled: Bool? = nil,
                            incidentDetectionEnabled: Bool? = nil,
                            groupTrackEnabled: Bool? = nil) {
        self.init()
        
        self.bluetoothEnabled = bluetoothEnabled
        self.bluetoothLowEnergyEnable = bluetoothLowEnergyEnable
        self.antEnabled = antEnabled
        self.name = name
        self.liveTrackingEnabled = liveTrackingEnabled
        self.weatherConditionsEnabled = weatherConditionsEnabled
        self.weatherAlertsEnabled = weatherAlertsEnabled
        self.autoActivityUploadEnabled = autoActivityUploadEnabled
        self.courseDownloadEnabled = courseDownloadEnabled
        self.workoutDownloadEnabled = workoutDownloadEnabled
        self.gpsEphemerisDownloadEnabled = gpsEphemerisDownloadEnabled
        self.groupTrackEnabled = groupTrackEnabled
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
        
        let msg = ConnectivityMessage(fieldDict: fieldDict,
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
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) ->  Result<DefinitionMessage, FitEncodingError> {
        
        guard name?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("name size can not exceed 255"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: ConnectivityMessage.globalMessageNumber(),
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
