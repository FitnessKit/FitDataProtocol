//
//  PausedMessage.swift
//  
//
//  Created by Antony Gardiner on 23/02/23.
//

import Foundation
import DataDecoder
import FitnessUnits

/// Wahoo custome FIT Paused Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class PausedMessage: RecordMessage {

	/// FIT Message Global Number
	public override class func globalMessageNumber() -> UInt16 { return 65280 }
	
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
		
		let msg = PausedMessage(fieldDict: fieldDict,
								fieldDataDict: fieldDataDict,
								architecture: definition.architecture)
		
		let devData = self.decodeDeveloperData(data: fieldData, definition: definition)
		msg.developerData = devData.isEmpty ? nil : devData
		
		return .success(msg as! F)
	}
}
