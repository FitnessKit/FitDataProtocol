//
//  FitFieldTime.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 11/23/19.
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

/// FitFieldTime
///
/// Properpty Wrapper for Time Values
@propertyWrapper
final public class FitFieldTime: FieldWrapper {
    public typealias Value = FitTime
    
    weak internal var owner: FitMessage?

    /// Base Type
    private(set) public var base: BaseTypeData
    
    /// Field Number
    private(set) public var fieldNumber: UInt8
    
    /// Time is Local
    private(set) public var local: Bool

    /// Wrapped Value
    public var wrappedValue: FitTime? {
        get {
            let fieldData = owner?.fieldDataDict[self.fieldNumber]
            guard let data = fieldData else { return nil }

            if data.isValidForBaseType(self.base.type) {
                
                let value = FitTime.decode(data: data,
                                           base: base,
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
            
            if let value = newValue {
                
                let result = value.encode(isLocal: self.local)
                if result.isValidForBaseType(base.type) {
                    owner?.fieldDataDict[self.fieldNumber] = result
                    let def = FieldDefinition(fieldDefinitionNumber: self.fieldNumber, type: self.base)
                    owner?.fieldDict[self.fieldNumber] = def
                    return
                }
                
            }
            
            failure()
        }
    }

    /// Projected Value
    public var projectedValue: FitFieldTime { self }

    public init(base: BaseTypeData, fieldNumber: UInt8, local: Bool) {
        self.base = base
        self.fieldNumber = fieldNumber
        self.local = local
    }

}
