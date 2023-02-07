//
//  File.swift
//  
//
//  Created by Antony Gardiner on 7/02/23.
//

import Foundation

/// FitFieldArray
///
/// Properpty Wrapper for Standard FIT Fields that are arrays of dimentions
@propertyWrapper
final public class FitFieldArray<U: Dimension> {
	public typealias Value = Measurement<U>
	
	weak internal var owner: FitMessage?
	
	/// Base Type
	private(set) public var base: BaseTypeData
	
	/// Field Number
	private(set) public var fieldNumber: UInt8
	
	/// Unit Type
	private(set) public var unitType: U
	
	/// Wrapped Value
	public var wrappedValue: [Value] {
		get {
			let fieldData = owner?.fieldDataDict[self.fieldNumber]
			guard var data = fieldData else { return [] }

			let arraySize = data.count / Int(self.base.type.dataSize)
			
			var values: [Value] = []
			
			for _ in 0..<arraySize {
				
				if data.isValidForBaseType(self.base.type) {
					if let value = self.base.type.decode(unit: self.unitType,
														 data: data,
														 resolution: base.resolution,
														 arch: owner?.architecture ?? .little) {
						values.append(value)
					}
				}
				
				// remove the first bytes so we can process next value
				let range = 0..<Int(self.base.type.dataSize)
				data.removeSubrange(range)

			}
			if values.count == arraySize {
				return values
			}
			return []
		}
		set {
			func failure() {
				// We remove these values
				owner?.fieldDataDict.removeValue(forKey: self.fieldNumber)
				owner?.fieldDict.removeValue(forKey: self.fieldNumber)
			}
			
			// TODO: encode all values not just the first one.
			if var value = newValue.first {
				value = value.converted(to: self.unitType)
				
				if value.value.isValidForBaseType(base.type) {
					let result = base.type.encodedResolution(value: value.value, resolution: base.resolution)
					switch result {
					case .success(let data):
						owner?.fieldDataDict[self.fieldNumber] = data
						let def = FieldDefinition(fieldDefinitionNumber: self.fieldNumber, type: self.base)
						owner?.fieldDict[self.fieldNumber] = def
						return
						
					case .failure(_):
						failure()
					}
				}
				
			}
			
			failure()
		}
	}
	
	/// Projected Value
	public var projectedValue: FitFieldArray<U> { self }
	
	public init(base: BaseTypeData, fieldNumber: UInt8, unit: U) {
		self.base = base
		self.fieldNumber = fieldNumber
		self.unitType = unit
	}
}
