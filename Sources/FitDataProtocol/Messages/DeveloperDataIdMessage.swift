//
//  DeveloperDataIdMessage.swift
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
import FitnessUnits
import AntMessageProtocol

/// FIT Developer Data ID Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeveloperDataIdMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 207 }

    /// Developer ID
    private(set) public var developerId: Data?

    /// Application ID
    private(set) public var applicationId: Data?

    /// Application Version
    private(set) public var applicationVersion: ValidatedBinaryInteger<UInt32>?

    /// Manufacturer
    private(set) public var manufacturer: Manufacturer?

    /// Data Index
    private(set) public var dataIndex: ValidatedBinaryInteger<UInt8>?

    public required init() {}

    public init(developerId: Data? = nil,
                applicationId: Data? = nil,
                applicationVersion: ValidatedBinaryInteger<UInt32>? = nil,
                manufacturer: Manufacturer? = nil,
                dataIndex: ValidatedBinaryInteger<UInt8>? = nil) {
        
        self.developerId = developerId
        self.applicationId = applicationId
        self.applicationVersion = applicationVersion
        self.manufacturer = manufacturer
        self.dataIndex = dataIndex
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: DeveloperDataIdMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
        var developerId: Data?
        var applicationId: Data?
        var applicationVersion: ValidatedBinaryInteger<UInt32>?
        var manufacturer: Manufacturer?
        var dataIndex: ValidatedBinaryInteger<UInt8>?
        
        let arch = definition.architecture
        
        var localDecoder = DecodeData()
        
        for definition in definition.fieldDefinitions {
            
            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))
            
            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("DeveloperDataIdMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")
                
            case .some(let key):
                switch key {
                    
                case .developerId:
                    let value = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if value.isValidForBaseType(definition.baseType) {
                        developerId = value
                    }
                    
                case .applicationId:
                    let value = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if value.isValidForBaseType(definition.baseType) {
                        applicationId = value
                    }
                    
                case .manufacturerId:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        manufacturer = Manufacturer.company(id: value)
                    }
                    
                case .dataIndex:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    dataIndex = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                        definition: definition,
                                                                        dataStrategy: dataStrategy)
                    
                case .applicationVersion:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    applicationVersion = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                                  definition: definition,
                                                                                  dataStrategy: dataStrategy)
                    
                }
            }
        }
        
        let msg = DeveloperDataIdMessage(developerId: developerId,
                                         applicationId: applicationId,
                                         applicationVersion: applicationVersion,
                                         manufacturer: manufacturer,
                                         dataIndex: dataIndex)
        return.success(msg as! F)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {

//        do {
//            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
//        } catch let error as FitEncodingError {
//            return.failure(error)
//        } catch {
//            return.failure(FitEncodingError.fileType(error.localizedDescription))
//        }

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .developerId:
                if let developerId = developerId {
                    //16 typical size..

                    guard developerId.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("developerId size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(developerId.count)))
                }
            case .applicationId:
                if let applicationId = applicationId {
                    //16 typical size..

                    guard applicationId.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("applicationId size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(applicationId.count)))
                }
            case .manufacturerId:
                if let _ = manufacturer { fileDefs.append(key.fieldDefinition()) }
            case .dataIndex:
                if let _ = dataIndex { fileDefs.append(key.fieldDefinition()) }
            case .applicationVersion:
                if let _ = applicationVersion { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: DeveloperDataIdMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return.success(defMessage)
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
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

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {
            case .developerId:
                if let developerId = developerId {
                    msgData.append(developerId)
                }

            case .applicationId:
                if let applicationId = applicationId {
                    msgData.append(applicationId)
                }

            case .manufacturerId:
                if let manufacturer = manufacturer {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: manufacturer.manufacturerID)) {
                        return.failure(error)
                    }
                }

            case .dataIndex:
                if let dataIndex = dataIndex {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: dataIndex)) {
                        return.failure(error)
                    }
                }

            case .applicationVersion:
                if let applicationVersion = applicationVersion {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: applicationVersion)) {
                        return.failure(error)
                    }
                }
            }
        }

        if msgData.message.count > 0 {
            return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData.message))
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }
}
