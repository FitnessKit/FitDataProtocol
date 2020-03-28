//
//  SetMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/23/19.
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

/// Set Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SetMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 225 }
    
    /// Set Duration
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 0,
                       unit: UnitDuration.seconds)
    private(set) public var duration: Measurement<UnitDuration>?
    
    /// Repetitions
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 3)
    private(set) public var repetitions: UInt16?
    
    /// Weight
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 16, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitMass.kilograms)
    private(set) public var weight: Measurement<UnitMass>?
    
    /// Set Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var setType: SetType?
    
    /// Start Time of the Set
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 6, local: false)
    private(set) public var startTime: FitTime?
    
    /// Start Time of the Set
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var category: ExerciseCategory?
    
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private var _exerciseName: UInt16?
    
    /// Exercise Name
    public var exerciseName: ExerciseNameType? {
        get {
            guard let name = _exerciseName else { return nil}
            return category?.exerciseName(from: name)
        }
    }
    
    /// Weight Display Unit
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 9)
    private(set) public var weightDisplayUnit: BaseUnitType?
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 10)
    private(set) public var messageIndex: MessageIndex?
    
    /// Workout Step Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 11)
    private(set) public var workoutSetpIndex: MessageIndex?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 254, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$duration.owner = self
        self.$repetitions.owner = self
        self.$weight.owner = self
        self.$setType.owner = self
        self.$startTime.owner = self
        self.$category.owner = self
        self.$_exerciseName.owner = self
        self.$weightDisplayUnit.owner = self
        self.$messageIndex.owner = self
        self.$workoutSetpIndex.owner = self
    }
    
    public init(timeStamp: FitTime? = nil,
                duration: Measurement<UnitDuration>? = nil,
                repetitions: UInt16? = nil,
                weight: Measurement<UnitMass>? = nil,
                setType: SetType? = nil,
                startTime: FitTime? = nil,
                category: ExerciseCategory? = nil,
                exerciseName: ExerciseNameType? = nil,
                weightDisplayUnit: BaseUnitType? = nil,
                messageIndex: MessageIndex? = nil,
                workoutSetpIndex: MessageIndex? = nil) {
        super.init()
        
        let catPre = category ?? .invalid
        let namePre = exerciseName?.catagory ?? ExerciseCategory.invalid
        
        precondition(catPre == namePre, "exerciseName is not of ExerciseCategory type")
        
        self.timeStamp = timeStamp
        
        self.duration = duration
        self.repetitions = repetitions
        self.weight = weight
        self.setType = setType
        self.startTime = startTime
        self.category = category
        self._exerciseName = exerciseName?.number
        self.weightDisplayUnit = weightDisplayUnit
        self.messageIndex = messageIndex
        self.workoutSetpIndex = workoutSetpIndex
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
        
        let msg = SetMessage(fieldDict: fieldDict,
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
