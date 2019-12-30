//
//  FitMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
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


/// Message Validator
internal protocol MessageValidator {
    
    // kah - Result<Bool, FitEncodingError>
    
    /// Validate Message
    ///
    /// - Parameters:
    ///   - fileType: FileType the Message is being used in
    ///   - dataValidityStrategy: Data Validity Strategy
    /// - Throws: FitError
    func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws
}

/// Base Class for FIT Messages
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FitMessage {
    internal var fieldDict: [UInt8: FieldDefinition] = [UInt8: FieldDefinition]()
    internal var fieldDataDict: [UInt8: Data] = [UInt8: Data]()
    internal var architecture: Endian = .little
    internal var developerData: [DeveloperDataType]?
    
    /// Developer Data Values
    internal(set) public var developerValues: [DeveloperDataBox] = [DeveloperDataBox]()
    
    /// FIT Message Global Number
    public class func globalMessageNumber() -> UInt16 {
        fatalError("*** You must override in your class.")
    }
    
    public required init() {}
    
    internal convenience init(fieldDict: [UInt8: FieldDefinition], fieldDataDict: [UInt8: Data], architecture: Endian) {
        self.init()
        
        self.fieldDict = fieldDict
        self.fieldDataDict = fieldDataDict
        self.architecture = architecture
    }
    
    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    /// - Returns: FitMessage Result
    internal func decode<F: FitMessage>(fieldData: FieldData, definition: DefinitionMessage) -> Result<F, FitDecodingError> {
        fatalError("*** You must override in your class.")
    }
    
    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {
        return.failure(FitEncodingError.notSupported)
    }
    
    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data Result
    internal func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {
        return.failure(FitEncodingError.notSupported)
    }
    
}

//MARK: - Standard Decodes
internal extension FitMessage {
    
    func decodeDeveloperData(data: FieldData, definition: DefinitionMessage) -> [DeveloperDataType] {
        
        var devDecoder = DecodeData()
        var devDataTypes = [DeveloperDataType]()
        let arch = definition.architecture
        
        for definition in definition.developerFieldDefinitions {
            let devdata = devDecoder.decodeData(data.developerFieldData, length: Int(definition.size))
            let devType = DeveloperDataType(architecture: arch,
                                            fieldNumber: definition.fieldNumber,
                                            dataIndex: definition.dataIndex,
                                            data: devdata)
            
            devDataTypes.append(devType)
        }
        
        return devDataTypes
    }
}

internal extension FitMessage {
    
    /// Create a FitError for Wrong DefinitionMessage for FitMessage
    ///
    /// - Parameter messageType: FitMessage Name
    /// - Returns: FitError
    func encodeWrongDefinitionMessage() -> FitEncodingError {
        return FitEncodingError.wrongDefinitionMessage("Wrong DefinitionMessage used for Encoding \(self.messageName)")
    }
    
    func encodeNoPropertiesAvailable() -> FitEncodingError {
        return FitEncodingError.noProperties("\(self.messageName) contains no Properties Available to Encode")
    }
    
    /// Name of the FitMessage
    var messageName: String {
        return String(describing: self)
    }
    
    /// Encode Message Fields
    /// - Parameter localMessageType: Local Message Type
    /// - Returns: Encoded Data Result
    func encodeMessageFields(localMessageType: UInt8) -> Result<Data, FitEncodingError> {
        let fields = self.fieldDataDict.sorted { $0.key < $1.key }.compactMap { $0.value }.joined()
        let msgData = Data(Array(fields))
        
        guard msgData.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData))
    }
    
    /// Encoded Data Message with Header
    ///
    /// - Parameters:
    ///   - localMessageType: Local Message Type
    ///   - msgData: Message Data
    /// - Returns: Encoded DataMessage
    private func encodedDataMessage(localMessageType: UInt8, msgData: Data) -> Data {
        var encodedMsg = Data()
        
        let recHeader = RecordHeader(localMessageType: localMessageType,
                                     isDataMessage: true).normalHeader
        encodedMsg.append(recHeader)
        encodedMsg.append(msgData)
        
        return encodedMsg
    }
}

//MARK: - Preferred Values
internal extension FitMessage {
    
    /// Pick a Preferred Value
    ///
    ///  If the Preferred is nil it will use the fallback else nil
    ///
    /// - Parameter preferred: preferred value to use
    /// - Parameter fallbakck: fallback value to use
    func preferredField<T>(preferred: Measurement<T>?, fallbakck: Measurement<T>?) -> Measurement<T>? {
        return preferred != nil ? preferred : fallbakck
    }
}
