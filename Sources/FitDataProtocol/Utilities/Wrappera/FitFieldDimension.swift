//
//  FitFieldDimension.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/14/19.
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

/// FitFieldUnit
///
/// Properpty Wrapper for Standard FIT Fields wrapped in a `Measurement<Dimension>`
@propertyWrapper
final public class FitFieldDimension<U: Dimension>: FieldWrapper {
    public typealias Value = Measurement<U>
    
    weak internal var owner: FitMessage?

    /// Base Type
    private(set) public var base: BaseTypeData
    
    /// Field Number
    private(set) public var fieldNumber: UInt8
    
    /// Unit Type
    private(set) public var unitType: U

    /// Wrapped Value
    public var wrappedValue: Value? {
        get {
            let fieldData = owner?.fieldDataDict[self.fieldNumber]
            guard let data = fieldData else { return nil }

            if data.isValidForBaseType(self.base.type) {
                
                let value = self.base.type.decode(unit: self.unitType,
                                                  data: data,
                                                  resolution: base.resolution,
                                                  arch: owner?.architecture ?? .little)
                return value
            }

            return nil
        }
        set {
            func failure() {
                // We remove these values
                owner?.fieldDataDict.removeValue(forKey: self.fieldNumber)
                owner?.fieldDict.removeValue(forKey: self.fieldNumber)
            }
            
            if var value = newValue {
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
    public var projectedValue: FitFieldDimension<U> { self }

    public init(base: BaseTypeData, fieldNumber: UInt8, unit: U) {
        self.base = base
        self.fieldNumber = fieldNumber
        self.unitType = unit
    }
}
