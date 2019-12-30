//
//  Weight.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/22/18.
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

/// FIT Weight
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct Weight {
    private static let calculatingValue: UInt16 = 0xFFFE
    
    /// Weight is being Calculated
    private(set) public var calculating: Bool
    
    /// Weight
    private(set) public var weight: Measurement<UnitMass>?
    
    public init(weight: Measurement<UnitMass>?, calculating: Bool) {
        
        self.calculating = calculating
        
        if calculating == false {
            self.weight = weight
        }
    }
}

extension Weight: Equatable {
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Weight, rhs: Weight) -> Bool {
        return lhs.calculating == rhs.calculating && lhs.weight == rhs.weight
    }
}

// MARK: - FitFieldCodeable
extension Weight: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        var msgData = Data()
        
        if calculating {
            msgData.append(Data(from: Weight.calculatingValue.littleEndian))
        } else {
            
            if var weightV = self.weight {
                weightV = weightV.converted(to: UnitMass.kilograms)
                
                let value = weightV.value.resolution(type: UInt16.self,
                                                     ResolutionDirection.adding,
                                                     resolution: base.resolution)
                
                msgData.append(Data(from: value.littleEndian))
                
            } else {
                return nil
            }
        }
        
        return msgData
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
        let calculating = Data(from: Weight.calculatingValue.littleEndian)
        
        if calculating == data {
            return Weight(weight: nil, calculating: true) as? T
        }
        
        if let value = base.type.decode(unit: UnitMass.kilograms,
                                        data: data,
                                        resolution: base.resolution,
                                        arch: arch) {
            return Weight(weight: value, calculating: false) as? T
        }
        
        return nil
    }
}
