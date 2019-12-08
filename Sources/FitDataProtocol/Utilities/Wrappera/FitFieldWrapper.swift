//
//  FitFieldWrapper.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 11/17/19.
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
import FitnessUnits

public protocol FieldWrapper {
    associatedtype Value
    
    var base: BaseTypeData { get }
    
    var fieldNumber: UInt8 { get }
    
    var wrappedValue: Value? { get set }
}

@propertyWrapper
public class FitField<T>: FieldWrapper where T: FitFieldCodeable {
    public typealias Value = T
    
    weak internal var owner: FitMessage?
    
    private(set) public var base: BaseTypeData
    
    private(set) public var fieldNumber: UInt8
    
    public var wrappedValue: T? {
        get {
            let fieldData = owner?.fieldDataDict[self.fieldNumber]
            
            guard let data = fieldData else { return nil }
            
            if data.isValidForBaseType(self.base.type) {
                let value = Value.decode(type: Value.self,
                                         data: data,
                                         base: base,
                                         arch: owner?.architecture ?? .little)
                
                //                let value = self.base.type.decode(type: Value.self,
                //                                                  data: data,
                //                                                  resolution: base.resolution,
                //                                                  arch: owner?.architecture ?? .little)
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
                
                if let data = value.encode(base: base) {
                    owner?.fieldDataDict[self.fieldNumber] = data
                    
                    let def: FieldDefinition
                    
                    if let value = value as? String {
                        def = FieldDefinition(fieldDefinitionNumber: self.fieldNumber, size: UInt8(value.count), type: self.base)
                    } else if let value = value as? Data {
                        def = FieldDefinition(fieldDefinitionNumber: self.fieldNumber, size: UInt8(value.count), type: self.base)
                    } else {
                        def = FieldDefinition(fieldDefinitionNumber: self.fieldNumber, type: self.base)
                    }
                    owner?.fieldDict[self.fieldNumber] = def
                    
                    return
                }
            }
            
            failure()
        }
    }
    
    public var projectedValue: FitField<T> { self }
    
    public init(base: BaseTypeData, fieldNumber: UInt8) {
        self.base = base
        self.fieldNumber = fieldNumber
    }
}

public typealias FitFieldCodeable = FitFieldEncodeable & FitFieldDecodeable
public protocol FitFieldEncodeable {
    
    func encode(base: BaseTypeData) -> Data?
}

public protocol FitFieldDecodeable {
    
    static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T?
}

extension Double: FitFieldCodeable {
    
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        return base.type.decode(type: T.self, data: data, resolution: base.resolution, arch: arch)
    }
    
    public func encode(base: BaseTypeData) -> Data? {
        if self.isValidForBaseType(base.type) {
            let result = base.type.encodedResolution(value: self, resolution: base.resolution)
            switch result {
            case .success(let data):
                return data
            case .failure(_):
                return nil
            }
        }
        
        return nil
    }
}

extension Float: FitFieldCodeable {
    
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = data.to(type: Float32.self) {
            return (value.resolution(.removing, resolution: base.resolution) as! T)
        }
        
        return nil
    }
    
    public func encode(base: BaseTypeData) -> Data? {
        if self.isValidForBaseType(base.type) {
            let result = base.type.encodedResolution(value: self, resolution: base.resolution)
            switch result {
            case .success(let data):
                return data
            case .failure(_):
                return nil
            }
        }
        
        return nil
    }
}

extension UInt8: FitFieldCodeable {}
extension Int8: FitFieldCodeable {}
extension UInt16: FitFieldCodeable {}
extension Int16: FitFieldCodeable {}
extension UInt32: FitFieldCodeable {}
extension Int32: FitFieldCodeable {}
extension UInt64: FitFieldCodeable {}
extension Int64: FitFieldCodeable {}

extension FixedWidthInteger {
    
    public func encode(base: BaseTypeData) -> Data? {
        if self.isValidForBaseType(base.type) {
            let result = base.type.encodedResolution(value: self, resolution: base.resolution)
            switch result {
            case .success(let data):
                return data
            case .failure(_):
                return nil
            }
        }
        
        return nil
    }
}

extension FixedWidthInteger {
    
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        return base.type.decode(type: type, data: data, resolution: base.resolution, arch: arch)
    }
    
}
