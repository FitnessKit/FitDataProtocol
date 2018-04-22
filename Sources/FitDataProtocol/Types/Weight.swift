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
import FitnessUnits

/// FIT Weight
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct Weight {

    /// Weight is being Calculated
    private(set) public var calculating: Bool

    /// Weight
    private(set) public var weight: ValidatedMeasurement<UnitMass>?

    internal init(rawValue: UInt16, scale: Double, valid: Bool = true) {
        self.calculating = false

        if rawValue == 0xFFFE {
            self.calculating = true
        } else {
            //  scale * kg + 0
            let value = Double(rawValue) / scale
            weight = ValidatedMeasurement(value: value, valid: valid, unit: UnitMass.kilograms)
        }
    }

    public init(weight: ValidatedMeasurement<UnitMass>?, calculating: Bool) {

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
    public static func ==(lhs: Weight, rhs: Weight) -> Bool {
        return lhs.calculating == rhs.calculating && lhs.weight == rhs.weight
    }
}
