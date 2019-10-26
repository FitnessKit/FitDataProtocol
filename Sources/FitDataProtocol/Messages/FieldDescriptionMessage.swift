//
//  FieldDescriptionMessage.swift
//  AntMessageProtocol
//
//  Created by Kevin Hoogheem on 10/26/19.
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

/// FIT Field Description Message
///
/// For use with Developer Defined Data
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FieldDescriptionMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 206 }

    /// Developer Data Index
    private(set) public var dataIndex: UInt8?
    
    /// Developer Definition Number
    private(set) public var definitionNumber: UInt8?
    
    /// Field name
    private(set) public var fieldName: String?
    
    /// Base Unit Type Information
    private(set) public var baseInfo: BaseTypeData?

    /// Units name
    private(set) public var units: String?
    
    /// Base Units
    private(set) public var baseUnits: BaseUnitType?

    /// Message Number
    ///
    /// This will match up with the FitMessage.globalMessageNumber()
    private(set) public var messageNumber: UInt16?
    
    /// Field Number
    private(set) public var fieldNumber: UInt8?

    public required init() {}

    public init(dataIndex: UInt8?,
                definitionNumber: UInt8?,
                fieldName: String?,
                baseInfo: BaseTypeData?,
                units: String?,
                baseUnits: BaseUnitType?,
                messageNumber: UInt16?,
                fieldNumber: UInt8?) {
        self.dataIndex = dataIndex
        self.definitionNumber = definitionNumber
        self.fieldName = fieldName
        self.baseInfo = baseInfo
        self.units = units
        self.baseUnits = baseUnits
        self.messageNumber = messageNumber
        self.fieldNumber = fieldNumber
    }
    
    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: FieldDescriptionMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
        var dataIndex: UInt8?
        var definitionNumber: UInt8?
        var baseTypeId: BaseType = .unknown
        var fieldName: String?
        var scale: UInt8 = 1
        var offset: UInt8 = 0
        var units: String?
        var baseUnits: BaseUnitType?
        var messageNumber: UInt16?
        var fieldNumber: UInt8?

        let arch = definition.architecture
        
        var localDecoder = DecodeData()
        
        for definition in definition.fieldDefinitions {
            
            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))
            
            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("FieldDescriptionMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")
                
            case .some(let key):
                switch key {
                case .dataIndex:
                    dataIndex = localDecoder.decodeUInt8(fieldData.fieldData)

                case .definitionNumber:
                    definitionNumber = localDecoder.decodeUInt8(fieldData.fieldData)
                case .baseTypeId:
                    let base = localDecoder.decodeUInt8(fieldData.fieldData)
                    baseTypeId = BaseType(rawValue: (base & 0x1F)) ?? .unknown

                case .fieldName:
                    fieldName = String.decode(decoder: &localDecoder,
                                              definition: definition,
                                              data: fieldData,
                                              dataStrategy: dataStrategy)

                case .scale:
                    scale = localDecoder.decodeUInt8(fieldData.fieldData)
                    
                case .offset:
                    offset = localDecoder.decodeUInt8(fieldData.fieldData)

                case .units:
                    units = String.decode(decoder: &localDecoder,
                                          definition: definition,
                                          data: fieldData,
                                          dataStrategy: dataStrategy)

                case .baseUnits:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        baseUnits = BaseUnitType(rawValue: value)
                    }

                case .messageNumber:
                    messageNumber = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)

                case .fieldNumber:
                    fieldNumber = localDecoder.decodeUInt8(fieldData.fieldData)
                }
            }
        }
        
        let baseInfo = BaseTypeData(type: baseTypeId,
                                    resolution: Resolution(scale: Double(scale), offset: Double(offset)))
        
        let msg = FieldDescriptionMessage(dataIndex: dataIndex,
                                          definitionNumber: definitionNumber,
                                          fieldName: fieldName,
                                          baseInfo: baseInfo,
                                          units: units,
                                          baseUnits: baseUnits,
                                          messageNumber: messageNumber,
                                          fieldNumber: fieldNumber)
        
        return.success(msg as! F)
    }

}
