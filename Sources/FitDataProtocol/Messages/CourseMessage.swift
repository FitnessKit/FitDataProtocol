//
//  CourseMessage.swift
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
import AntMessageProtocol

/// FIT Course Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CourseMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 31 }
    
    /// Sport
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var sport: Sport?
    
    /// Course Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var name: String?
    
    /// Course Capabilities
    @FitField(base: BaseTypeData(type: .uint32z, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var capabilities: Capabilities?
    
    /// Sub Sport
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var subSport: SubSport?
    
    public required init() {
        super.init()
        
        self.$sport.owner = self
        self.$name.owner = self
        self.$capabilities.owner = self
        self.$subSport.owner = self
    }
    
    public convenience init(name: String? = nil,
                            capabilities: Capabilities? = nil,
                            sport: Sport? = nil,
                            subSport: SubSport? = nil) {
        self.init()
        
        self.name = name
        self.capabilities = capabilities
        self.sport = sport
        self.subSport = subSport
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
        
        let msg = CourseMessage(fieldDict: fieldDict,
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
                                           globalMessageNumber: CourseMessage.globalMessageNumber(),
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

public extension CourseMessage {
    
    /// Course Capabilities Options
    struct Capabilities: OptionSet {
        public let rawValue: UInt32
        public init(rawValue: UInt32) { self.rawValue = rawValue }
        
        /// Processed
        public static let processed = Capabilities(rawValue: 0x00000001)
        /// Valid
        public static let valid = Capabilities(rawValue: 0x00000002)
        /// Time
        public static let time = Capabilities(rawValue: 0x00000004)
        /// Distance
        public static let distance = Capabilities(rawValue: 0x00000008)
        /// Position
        public static let position = Capabilities(rawValue: 0x00000010)
        /// Heart Rate
        public static let heartRate = Capabilities(rawValue: 0x00000020)
        /// Power
        public static let power = Capabilities(rawValue: 0x00000040)
        /// Cadence
        public static let cadence = Capabilities(rawValue: 0x00000080)
        /// Training
        public static let training = Capabilities(rawValue: 0x00000100)
        /// Navigation
        public static let navigation  = Capabilities(rawValue: 0x00000200)
        /// Bikeway
        public static let bikeway = Capabilities(rawValue: 0x00000400)
    }
    
}

// MARK: - FitFieldCodeable
extension CourseMessage.Capabilities: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
    }
    
    /// Decode FIT Field
    ///
    /// - Parameters:
    ///   - type: Type of Field
    ///   - data: Data to Decode
    ///   - base: BaseTypeData
    ///   - arch: Endian
    /// - Returns: Decoded Value
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = base.type.decode(type: UInt32.self, data: data, resolution: base.resolution, arch: arch) {
            return CourseMessage.Capabilities(rawValue: value) as? T
        }
        
        return nil
    }
}
