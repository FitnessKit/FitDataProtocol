//
//  HrvMessage.swift
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

/// FIT HRV Message
///
/// Used to record heart rate variability data. The hrv data messages contain an
/// array of RR intervals and are interleaved with record and event messages in chronological order
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class HrvMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 78 }
    
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
              fieldNumber: 0)
    private var hrvData: Data?
    
    /// Heart Rate Variability
    ///
    /// Time between beats
    public var hrv: [Measurement<UnitDuration>]? {
        return getHrvMessages()
    }
    
    public required init() {
        super.init()
        
        self.$hrvData.owner = self
    }
    
    public convenience init(hrv: [Measurement<UnitDuration>]) {
        self.init()
        
        if hrv.isEmpty == false {
            
            var msgData = [Data]()
            for time in hrv {
                let hrvTime = time.converted(to: UnitDuration.seconds)
                let result = self.$hrvData.base.type.encodedResolution(value: hrvTime.value,
                                                                       resolution: self.$hrvData.base.resolution)
                
                switch result {
                case .success(let data):
                    msgData.append(data)
                case .failure(_):
                    break
                }
            }
            
            if msgData.isEmpty == false {
                let fields = msgData.compactMap { $0 }.joined()
                self.hrvData = Data(Array(fields))
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
        
        let msg = HrvMessage(fieldDict: fieldDict,
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
                                           globalMessageNumber: HrvMessage.globalMessageNumber(),
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

private extension HrvMessage {
    
    func getHrvMessages() -> [Measurement<UnitDuration>]? {
        let vals = self.fieldDataDict[self.$hrvData.fieldNumber]?.segment(size: MemoryLayout<UInt16>.size)
        
        guard let values = vals else { return nil }
        
        var hrvMsg = [Measurement<UnitDuration>?]()
        for hrv in values {
            if hrv.isValidForBaseType(self.$hrvData.base.type) {
                
                let value = self.$hrvData.base.type.decode(unit: UnitDuration.seconds,
                                                           data: hrv,
                                                           resolution: self.$hrvData.base.resolution,
                                                           arch: self.architecture)
                hrvMsg.append(value)
            }
            
        }
        return hrvMsg.compactMap { $0 }
    }
}
