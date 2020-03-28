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
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var dataIndex: UInt8?
    
    /// Developer Definition Number
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var definitionNumber: UInt8?
    
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private var baseTypeId: BaseType?
    
    /// Field name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 3)
    private(set) public var fieldName: String?
    
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private var scale: UInt8?
    
    @FitField(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private var offset: Int8?
    
    /// Base Unit Type Information
    private(set) public var baseInfo: BaseTypeData? {
        get {
            let base = self.baseTypeId ?? .unknown
            let scale = self.scale ?? 1
            let offset = self.offset ?? 0
            
            return BaseTypeData(type: base,
                                resolution: Resolution(scale: Double(scale),
                                                       offset: Double(offset)))
        }
        set {
            self.baseTypeId = newValue?.type
            if let res = newValue?.resolution {
                self.scale = UInt8(res.scale)
                self.offset = Int8(res.offset)
            }
        }
    }
    
    /// Units name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private(set) public var units: String?
    
    /// Base Units
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 13)
    private(set) public var baseUnits: BaseUnitType?
    
    /// Message Number
    ///
    /// This will match up with the FitMessage.globalMessageNumber()
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 14)
    private(set) public var messageNumber: UInt16?
    
    /// Field Number
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 15)
    private(set) public var fieldNumber: UInt8?
    
    public required init() {
        super.init()
        
        self.$dataIndex.owner = self
        self.$definitionNumber.owner = self
        self.$baseTypeId.owner = self
        self.$fieldName.owner = self
        self.$scale.owner = self
        self.$offset.owner = self
        self.$units.owner = self
        self.$baseUnits.owner = self
        self.$messageNumber.owner = self
        self.$fieldNumber.owner = self
    }
    
    public convenience init(dataIndex: UInt8?,
                            definitionNumber: UInt8?,
                            fieldName: String?,
                            baseInfo: BaseTypeData?,
                            units: String?,
                            baseUnits: BaseUnitType?,
                            messageNumber: UInt16?,
                            fieldNumber: UInt8?) {
        self.init()
        
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
        
        let msg = FieldDescriptionMessage(fieldDict: fieldDict,
                                          fieldDataDict: fieldDataDict,
                                          architecture: definition.architecture)
        
        let devData = self.decodeDeveloperData(data: fieldData, definition: definition)
        msg.developerData = devData.isEmpty ? nil : devData
        
        return .success(msg as! F)
    }
}

internal extension FieldDescriptionMessage {
    
    func decodeDeveloperDataType(developerData: DeveloperDataType) -> DeveloperDataBox? {
        guard developerData.dataIndex == self.dataIndex else { return nil }
        
        if let fieldNumber = self.definitionNumber {
            guard developerData.fieldNumber == fieldNumber else { return nil }
        }
        
        if let baseInfo = self.baseInfo {
            var decoder = DecodeData()
            
            guard developerData.data.isValidForBaseType(baseInfo.type) else { return nil }
            
            switch baseInfo.type {
            case .enumtype, .uint8, .uint8z, .byte:
                let value = decoder.decodeUInt8(developerData.data)
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .sint8:
                let value = decoder.decodeInt8(developerData.data)
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .sint16:
                let value = developerData.architecture == .little ? decoder.decodeInt16(developerData.data).littleEndian : decoder.decodeInt16(developerData.data).bigEndian
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .uint16, .uint16z:
                let value = developerData.architecture == .little ? decoder.decodeUInt16(developerData.data).littleEndian : decoder.decodeUInt16(developerData.data).bigEndian
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .sint32:
                let value = developerData.architecture == .little ? decoder.decodeInt32(developerData.data).littleEndian : decoder.decodeInt32(developerData.data).bigEndian
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .float32:
                let value = decoder.decodeFloat32(developerData.data)
                
                if value.isNaN {
                    return nil
                }
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .uint32, .uint32z:
                let value = developerData.architecture == .little ? decoder.decodeUInt32(developerData.data).littleEndian : decoder.decodeUInt32(developerData.data).bigEndian
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .string:
                let stringData = decoder.decodeData(developerData.data, length: developerData.data.count)
                if stringData.count != 0 {
                    return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: stringData.smartString)
                }
                
            case .sint64:
                let value = developerData.architecture == .little ? decoder.decodeInt64(developerData.data).littleEndian : decoder.decodeInt64(developerData.data).bigEndian
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .float64:
                let value = decoder.decodeFloat64(developerData.data)
                if value.isNaN {
                    return nil
                }
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .uint64, .uint64z:
                let value = developerData.architecture == .little ? decoder.decodeUInt64(developerData.data).littleEndian : decoder.decodeUInt64(developerData.data).bigEndian
                let resValue = value.resolution(.removing, resolution: baseInfo.resolution)
                
                return DeveloperDataValue(fieldName: self.fieldName, units: self.units, value: resValue)
                
            case .unknown:
                return nil
            }
        }
        return nil
    }
}
