//
//  JumpMessage.swift
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

/// Jump Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class JumpMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 285 }
    
    /// Distance
    @FitFieldDimension(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 0,
                       unit: UnitLength.meters)
    private(set) public var distance: Measurement<UnitLength>?
    
    /// Height
    @FitFieldDimension(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 1,
                       unit: UnitLength.meters)
    private(set) public var height: Measurement<UnitLength>?
    
    /// Rotations
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var rotations: UInt8?
    
    /// Hang Time
    @FitFieldDimension(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitDuration.seconds)
    private(set) public var hangTime: Measurement<UnitDuration>?
    
    /// Score
    @FitField(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var score: Float32?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 5,
                       unit: UnitAngle.garminSemicircle)
    private var latitude: Measurement<UnitAngle>?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 6,
                       unit: UnitAngle.garminSemicircle)
    private var longitude: Measurement<UnitAngle>?
    
    /// Position
    private(set) public var position: Position? {
        get {
            return Position(latitude: self.latitude, longitude: self.longitude)
        }
        set {
            self.latitude = newValue?.latitude
            self.longitude = newValue?.longitude
        }
    }
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 7,
                       unit: UnitSpeed.metersPerSecond)
    private var _speed: Measurement<UnitSpeed>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 8,
                       unit: UnitSpeed.metersPerSecond)
    private var enhanceSpeed: Measurement<UnitSpeed>?
    
    /// Speed
    private(set) public var speed: Measurement<UnitSpeed>? {
        get {
            return preferredField(preferred: self.enhanceSpeed, fallbakck: self._speed)
        }
        set {
            self.enhanceSpeed = newValue
        }
    }
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$distance.owner = self
        self.$height.owner = self
        self.$rotations.owner = self
        self.$hangTime.owner = self
        self.$score.owner = self
        self.$latitude.owner = self
        self.$longitude.owner = self
        self.$_speed.owner = self
        self.$enhanceSpeed.owner = self
    }
    
    public init(timeStamp: FitTime? = nil,
                distance: Measurement<UnitLength>? = nil,
                height: Measurement<UnitLength>? = nil,
                rotations: UInt8? = nil,
                hangTime: Measurement<UnitDuration>? = nil,
                score: Float32? = nil,
                position: Position? = nil,
                speed: Measurement<UnitSpeed>? = nil) {
        super.init()
        
        self.timeStamp = timeStamp
        
        self.distance = distance
        self.height = height
        self.rotations = rotations
        self.hangTime = hangTime
        self.score = score
        self.position = position
        self.speed = speed
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
        
        let msg = JumpMessage(fieldDict: fieldDict,
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
                                           globalMessageNumber: ZonesTargetMessage.globalMessageNumber(),
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
