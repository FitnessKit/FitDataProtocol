//
//  WorkoutStepMessage.swift
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

/// FIT Workout Step Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutStepMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 27 }
    
    /// Workout Step Name
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var name: String?
    
    /// Durationm Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private(set) public var durationType: WorkoutStepDurationType?
    
    /// Duration
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var duration: UInt32?
    
    /// Target Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 3)
    private(set) public var targetType: WorkoutStepTargetType?
    
    /// Target
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var target: UInt32?
    
    /// Target Value Low
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var targetLow: UInt32?
    
    /// Target Value High
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 6)
    private(set) public var targetHigh: UInt32?
    
    /// Intensity Level
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var intensity: Intensity?
    
    /// Notes
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private(set) public var notes: String?
    
    /// Equipment
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 9)
    private(set) public var equipment: WorkoutEquipment?
    
    /// Exercise Category
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 10)
    private(set) public var category: ExerciseCategory?
    
    /// Message Index
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 254)
    private(set) public var messageIndex: MessageIndex?
    
    public required init() {
        super.init()
        
        // TODO: targetLow/targetHigh Change to a Protocol that provides the value for targetType
        
        self.$messageIndex.owner = self
        
        self.$name.owner = self
        self.$durationType.owner = self
        self.$duration.owner = self
        self.$targetType.owner = self
        self.$target.owner = self
        self.$targetLow.owner = self
        self.$targetHigh.owner = self
        self.$intensity.owner = self
        self.$notes.owner = self
        self.$equipment.owner = self
        self.$category.owner = self
    }
    
    public convenience init(messageIndex: MessageIndex? = nil,
                            name: String? = nil,
                            duration: UInt32? = nil,
                            durationType: WorkoutStepDurationType? = nil,
                            target: UInt32? = nil,
                            targetLow: UInt32? = nil,
                            targetHigh: UInt32? = nil,
                            targetType: WorkoutStepTargetType? = nil,
                            category: ExerciseCategory? = nil,
                            intensity: Intensity? = nil,
                            notes: String? = nil,
                            equipment: WorkoutEquipment? = nil) {
        self.init()
        
        self.messageIndex = messageIndex
        self.name = name
        self.duration = duration
        self.durationType = durationType
        self.target = target
        self.targetLow = targetLow
        self.targetHigh = targetHigh
        self.targetType = targetType
        self.category = category
        self.intensity = intensity
        self.notes = notes
        self.equipment = equipment
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
        
        let msg = WorkoutStepMessage(fieldDict: fieldDict,
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
        
        do {
            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
        } catch let error as FitEncodingError {
            return.failure(error)
        } catch {
            return.failure(FitEncodingError.fileType(error.localizedDescription))
        }
        
        guard name?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("name size can not exceed 255"))
        }
        
        guard notes?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("notes size can not exceed 255"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: WorkoutStepMessage.globalMessageNumber(),
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

extension WorkoutStepMessage: MessageValidator {
    
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
            if fileType == FileType.workout {
                try validateWorkout()
            }
        case .garminConnect:
            break // do nothing
        }
    }
    
    private func validateWorkout() throws {
        
        let msg = "Workout Files"
        
        guard self.messageIndex != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutStepMessage to contain messageIndex, can not be nil")
        }
        
        guard self.durationType != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutStepMessage to contain durationType, can not be nil")
        }
        
        guard self.targetType != nil else {
            throw FitEncodingError.fileType("\(msg) require WorkoutStepMessage to contain targetType, can not be nil")
        }
        
    }
}
