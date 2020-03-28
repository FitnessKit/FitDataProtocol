//
//  SegmentPointMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/30/19.
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

/// Segment Point Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SegmentPointMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 150 }
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 1,
                       unit: UnitAngle.garminSemicircle)
    private var latitude: Measurement<UnitAngle>?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 2,
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
    
    /// Accumulated distance along the segment at the described point
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitLength.meters)
    private(set) public var distance: Measurement<UnitLength>?
    
    /// Accumulated altitude along the segment at the described point
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 4,
                       unit: UnitLength.meters)
    private(set) public var altitude: Measurement<UnitLength>?
    
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
              fieldNumber: 5)
    private var leader: Data?
    
    /// Accumualted time each leader board member required to reach the described point.
    ///
    /// This value is zero for all leader board members at the starting point of the segment
    public var leaderTime: [Measurement<UnitDuration>]? {
        get {
            return getLeaderTimes()
        }
    }
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 254)
    private(set) public var messageIndex: MessageIndex?
    
    public required init() {
        super.init()
        
        self.$messageIndex.owner = self
        
        self.$latitude.owner = self
        self.$longitude.owner = self
        self.$distance.owner = self
        self.$altitude.owner = self
        self.$leader.owner = self
    }
    
    public convenience init(messageIndex: MessageIndex? = nil,
                            position: Position? = nil,
                            distance: Measurement<UnitLength>? = nil,
                            altitude: Measurement<UnitLength>? = nil,
                            leaderTime: [Measurement<UnitDuration>]? = nil) {
        self.init()
        
        self.messageIndex = messageIndex
        
        self.position = position
        self.distance = distance
        self.altitude = altitude
        
        if let leaderTime = leaderTime, leaderTime.isEmpty == false {
            var msgData = [Data]()
            
            for time in leaderTime {
                let leaderTime = time.converted(to: UnitDuration.seconds)
                let result = self.$leader.base.type.encodedResolution(value: leaderTime.value,
                                                                      resolution: self.$leader.base.resolution)
                
                switch result {
                case .success(let data):
                    msgData.append(data)
                case .failure(_):
                    break
                }
            }
            
            if msgData.isEmpty == false {
                let fields = msgData.compactMap { $0 }.joined()
                self.leader = Data(Array(fields))
            }
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
        
        let msg = SegmentPointMessage(fieldDict: fieldDict,
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
                                           globalMessageNumber: SegmentLeaderboardEntryMessage.globalMessageNumber(),
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

private extension SegmentPointMessage {
    
    func getLeaderTimes() -> [Measurement<UnitDuration>]? {
        let vals = self.fieldDataDict[self.$leader.fieldNumber]?.segment(size: MemoryLayout<UInt32>.size)
        
        guard let values = vals else { return nil }
        
        var message = [Measurement<UnitDuration>?]()
        for value in values {
            if value.isValidForBaseType(self.$leader.base.type) {
                
                let value = self.$leader.base.type.decode(unit: UnitDuration.seconds,
                                                          data: value,
                                                          resolution: self.$leader.base.resolution,
                                                          arch: self.architecture)
                message.append(value)
            }
            
        }
        return message.compactMap { $0 }
    }
}
