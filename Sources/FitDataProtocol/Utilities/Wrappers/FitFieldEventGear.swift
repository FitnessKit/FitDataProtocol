//
//  File.swift
//  
//
//  Created by Antony Gardiner on 3/02/23.
//

import Foundation
import FitnessUnits

public protocol ReadOnlyFieldWrapper {
	associatedtype Value
	
	/// Base Type
	var base: BaseTypeData { get }
	
	/// Field Number
	var fieldNumber: UInt8 { get }
	
	/// Wrapped Value
	var wrappedValue: Value? { get }
}

@propertyWrapper
/// Generated values for gear changes from an event for rear or front gears
final public class FitFieldEventGear<T>: ReadOnlyFieldWrapper where T: FitFieldCodeable {
	public typealias Value = T
	
	weak internal var owner: EventMessage?
	
	/// Base Type
	private(set) public var base: BaseTypeData
	
	/// Field Number for data generated from
	private(set) public var fieldNumber: UInt8
	
	private var byteIndex: Int
	
	/// Wrapped Value
	public var wrappedValue: T? {
		get {
			
			// Only valid for a marker event
			guard owner?.eventType == .marker else {
				return nil
			}
			
			// This decode is only valid for gear change events
			switch owner?.event {
			case .rearGearChange, .frontGearChange:
				break
			default:
				return nil
			}
			
			let fieldData = owner?.fieldDataDict[self.fieldNumber]
			
			guard let data = fieldData?[byteIndex] else { return nil }
			
			// Not really sure what to do here, bytes are zeros if not set not 0xff.
			if data.isValidForBaseType(self.base.type) && data != 0 {
				let value = Value.decode(type: Value.self,
										 data: Data(from: data),
										 base: base,
										 arch: owner?.architecture ?? .little)
				return value
			}
			
			return nil
		}		
	}
	
	/// Projected Value
	public var projectedValue: FitFieldEventGear<T> { self }
	
	public init(base: BaseTypeData, generatedFromDataFieldNumber: UInt8, byteIndex: Int) {
		self.base = base
		self.fieldNumber = generatedFromDataFieldNumber
		self.byteIndex = byteIndex
	}
}
