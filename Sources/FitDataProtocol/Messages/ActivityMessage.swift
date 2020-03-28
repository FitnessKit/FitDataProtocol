//
//  ActivityMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
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

/// FIT Activity Message
///
/// Provides a high level description of the overall activity file.
/// This includes overall time, number of sessions and the type of each session
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ActivityMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 34 }
    
    /// Total Timer Time
    ///
    /// Excludes pauses
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 0,
                       unit: UnitDuration.seconds)
    private(set) public var totalTimerTime: Measurement<UnitDuration>?
    
    /// Number of Sessions
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var numberOfSessions: UInt16?
    
    /// Activity
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var activity: Activity?
    
    /// Event
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 3)
    private(set) public var event: Event?
    
    /// Event Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var eventType: EventType?
    
    /// Local Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 5, local: true)
    private(set) public var localTimeStamp: FitTime?
    
    /// Event Group
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var eventGroup: UInt8?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$totalTimerTime.owner = self
        self.$numberOfSessions.owner = self
        self.$activity.owner = self
        self.$event.owner = self
        self.$eventType.owner = self
        self.$localTimeStamp.owner = self
        self.$eventGroup.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            totalTimerTime: Measurement<UnitDuration>? = nil,
                            localTimeStamp: FitTime? = nil,
                            numberOfSessions: UInt16? = nil,
                            activity: Activity? = nil,
                            event: Event? = nil,
                            eventType: EventType? = nil,
                            eventGroup: UInt8? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.totalTimerTime = totalTimerTime
        self.localTimeStamp = localTimeStamp
        self.numberOfSessions = numberOfSessions
        self.activity = activity
        self.event = event
        self.eventType = eventType
        self.eventGroup = eventGroup
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
        
        let msg = ActivityMessage(fieldDict: fieldDict,
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
        
        do {
            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
        } catch let error as FitEncodingError {
            return.failure(error)
        } catch {
            return.failure(FitEncodingError.fileType(error.localizedDescription))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: ActivityMessage.globalMessageNumber(),
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

extension ActivityMessage: MessageValidator {
    
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
            throw FitEncodingError.fileType("\(msg) require ActivityMessage to contain timeStamp, can not be nil")
        }
        
        guard self.numberOfSessions != nil else {
            throw FitEncodingError.fileType("\(msg) require ActivityMessage to contain numberOfSessions, can not be nil")
        }
        
        guard self.activity != nil else {
            throw FitEncodingError.fileType("\(msg) require ActivityMessage to contain activity, can not be nil")
        }
        
        guard self.event != nil else {
            throw FitEncodingError.fileType("\(msg) require ActivityMessage to contain event, can not be nil")
        }
        
        guard self.eventType != nil else {
            throw FitEncodingError.fileType("\(msg) require ActivityMessage to contain eventType, can not be nil")
        }
        
    }
}
