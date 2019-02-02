//
//  Resolutionable.swift
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

/// Struct to Hold Resolution Scale and Offset
internal struct Resolution {

    /// Scale
    var scale: Double

    // Offset
    var offset: Double
}

internal enum ResolutionDirection {
    /// Adds Resolution
    case adding
    /// Removes Resolution
    case removing
}

protocol Resolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double
}

protocol FixedWidthIntegerResolutionable {

    /// Apply Resolution With Direction
    ///
    /// - Parameters:
    ///   - type: Type to resolve to
    ///   - direction: Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution Applied
    func resolution<T>(type: T.Type, _ direction: ResolutionDirection, resolution: Resolution) -> T where T: FixedWidthInteger
}

extension Double: Resolutionable, FixedWidthIntegerResolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double {
        switch direction {
        case .adding:
            return (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            return (Double(self) * (1 / resolution.scale)) - resolution.offset
        }
    }

    /// Apply Resolution With Direction
    ///
    /// - Parameters:
    ///   - type: Type to resolve to
    ///   - direction: Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution Applied
    func resolution<T>(type: T.Type, _ direction: ResolutionDirection, resolution: Resolution) -> T where T: FixedWidthInteger {
        var value = Double(T.min)

        switch direction {
        case .adding:
            value = (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            value = (Double(self) * (1 / resolution.scale)) - resolution.offset
        }

        guard value >= Double(T.min) else { return T.min }
        guard value <= Double(T.max) else { return T.max }

        return T(value)
    }
}

extension UInt8: Resolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double {
        switch direction {
        case .adding:
            return (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            return (Double(self) * (1 / resolution.scale)) - resolution.offset
        }
    }
}

extension UInt16: Resolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double {
        switch direction {
        case .adding:
            return (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            return (Double(self) * (1 / resolution.scale)) - resolution.offset
        }
    }
}

extension Int16: Resolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double {
        switch direction {
        case .adding:
            return (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            return (Double(self) * (1 / resolution.scale)) - resolution.offset
        }
    }
}

extension UInt32: Resolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double {
        switch direction {
        case .adding:
            return (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            return (Double(self) * (1 / resolution.scale)) - resolution.offset
        }
    }
}

extension UInt32: FixedWidthIntegerResolutionable {

    /// Apply Resolution With Direction
    ///
    /// - Parameters:
    ///   - type: Type to resolve to
    ///   - direction: Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution Applied
    func resolution<T>(type: T.Type, _ direction: ResolutionDirection, resolution: Resolution) -> T where T: FixedWidthInteger {
        var value = Double(T.min)

        switch direction {
        case .adding:
            value = (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            value = (Double(self) * (1 / resolution.scale)) - resolution.offset
        }

        guard value >= Double(T.min) else { return T.min }
        guard value <= Double(T.max) else { return T.max }

        return T(value)
    }
}

extension Int32: Resolutionable {

    /// Apply Resolution with Direction
    ///
    /// - Parameters:
    ///   - direction: Type of Resolution Direction
    ///   - resolution: Resolution
    /// - Returns: Number with Resolution applied
    func resolution(_ direction: ResolutionDirection, resolution: Resolution) -> Double {
        switch direction {
        case .adding:
            return (Double(self) * resolution.scale) + resolution.offset
        case .removing:
            return (Double(self) * (1 / resolution.scale)) - resolution.offset
        }
    }
}
