//
//  Position.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/18/18.
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

/// FIT Position Data
public struct Position: NilInitializer {

    /// Position in Latitude
    private(set) public var latitude: ValidatedMeasurement<UnitAngle>?

    /// Position in Longitude
    private(set) public var longitude: ValidatedMeasurement<UnitAngle>?

    /// Create nil Object
    public static var nilSelf: Position {
        return Position(latitude: nil, longitude: nil)
    }

    public init(latitude: ValidatedMeasurement<UnitAngle>?,
                longitude: ValidatedMeasurement<UnitAngle>?) {
        
        self.latitude = latitude
        self.longitude = longitude
    }
}

internal extension Position {

    func encodeLatitude() -> Data? {

        if let latitude = latitude {
            return Data(encodeSemiCircles(latitude))
        }

        return nil
    }

    func encodeLongitude() -> Data? {

        if let longitude = longitude {
            return Data(encodeSemiCircles(longitude))
        }

        return nil
    }

    private func encodeSemiCircles(_ semi: ValidatedMeasurement<UnitAngle>) -> Data {
        var vSemi = semi
        //  1 * semicircles + 0
        vSemi = vSemi.converted(to: UnitAngle.garminSemicircle)
        let value = vSemi.value.resolutionInt32(1)

        return Data(from: value.littleEndian)
    }

}
