//
//  CoursePointMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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

/// FIT Course Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CoursePointMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 32 }
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 1, local: false)
    private(set) public var timeStamp: FitTime?
    
    /// Position in Latitude
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 2,
                       unit: UnitAngle.garminSemicircle)
    private var latitude: Measurement<UnitAngle>?
    
    /// Position in Longitude
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 3,
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
    
    /// Distance
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitLength.meters)
    private(set) public var distance: Measurement<UnitLength>?
    
    /// Course Point Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var pointType: CoursePoint?
    
    /// Course Point Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var name: String?
    
    /// Is Favorite Point
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var isFavorite: Bool?
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 254)
    private(set) public var messageIndex: MessageIndex?
    
    public required init() {
        super.init()
        
        self.$messageIndex.owner = self
        
        self.$timeStamp.owner = self
        
        self.$latitude.owner = self
        self.$longitude.owner = self
        self.$distance.owner = self
        self.$pointType.owner = self
        self.$name.owner = self
        self.$isFavorite.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            messageIndex: MessageIndex? = nil,
                            name: String? = nil,
                            position: Position? = nil,
                            distance: Measurement<UnitLength>? = nil,
                            pointType: CoursePoint? = nil,
                            isFavorite: Bool? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex
        self.name = name
        self.position = position
        self.distance = distance
        self.pointType = pointType
        self.isFavorite = isFavorite
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
        
        let msg = CoursePointMessage(fieldDict: fieldDict,
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
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: CoursePointMessage.globalMessageNumber(),
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
