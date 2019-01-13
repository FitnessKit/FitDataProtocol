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

internal struct Resolution {

    /// Scale
    var scale: Double

    // Offset
    var offset: Double
}

protocol Resolutionable {
    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double) -> Double
}

protocol BinaryResolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt8(_ res: Double, offset: Double) -> UInt8

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt8(_ res: Double, offset: Double) -> Int8

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt16(_ res: Double, offset: Double) -> UInt16

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt16(_ res: Double, offset: Double) -> Int16

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt32(_ res: Double, offset: Double) -> UInt32

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt32(_ res: Double, offset: Double) -> Int32

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt64(_ res: Double, offset: Double) -> UInt64

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt64(_ res: Double, offset: Double) -> Int64

}

extension Double: Resolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double = 0) -> Double {
        return (Double(self) * scale) + offset
    }

}

extension Double: BinaryResolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt8(_ res: Double, offset: Double) -> UInt8 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt8.min) else { return UInt8.min }
        guard value <= Double(UInt8.max) else { return UInt8.max }

        return UInt8(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt8(_ res: Double, offset: Double) -> Int8 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int8.min) else { return Int8.min }
        guard value <= Double(Int8.max) else { return Int8.max }

        return Int8(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt16(_ res: Double, offset: Double) -> UInt16 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt16.min) else { return UInt16.min }
        guard value <= Double(UInt16.max) else { return UInt16.max }

        return UInt16(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt16(_ res: Double, offset: Double) -> Int16 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int16.min) else { return Int16.min }
        guard value <= Double(Int16.max) else { return Int16.max }

        return Int16(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt32(_ res: Double, offset: Double) -> UInt32 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt32.min) else { return UInt32.min }
        guard value <= Double(UInt32.max) else { return UInt32.max }

        return UInt32(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt32(_ res: Double, offset: Double) -> Int32 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int32.min) else { return Int32.min }
        guard value <= Double(Int32.max) else { return Int32.max }

        return Int32(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt64(_ res: Double, offset: Double) -> UInt64 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt64.min) else { return UInt64.min }
        guard value <= Double(UInt64.max) else { return UInt64.max }

        return UInt64(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt64(_ res: Double, offset: Double) -> Int64 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int64.min) else { return Int64.min }
        guard value <= Double(Int64.max) else { return Int64.max }

        return Int64(value)
    }

}

extension UInt8: Resolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double = 0) -> Double {
        return (Double(self) * scale) + offset
    }

}

extension UInt16: Resolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double = 0) -> Double {
        return (Double(self) * scale) + offset
    }

}

extension Int16: Resolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double = 0) -> Double {
        return (Double(self) * scale) + offset
    }

}

extension UInt32: Resolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double = 0) -> Double {
        return (Double(self) * scale) + offset
    }

}

extension UInt32: BinaryResolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt8(_ res: Double, offset: Double) -> UInt8 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt8.min) else { return UInt8.min }
        guard value <= Double(UInt8.max) else { return UInt8.max }

        return UInt8(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt8(_ res: Double, offset: Double) -> Int8 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int8.min) else { return Int8.min }
        guard value <= Double(Int8.max) else { return Int8.max }

        return Int8(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt16(_ res: Double, offset: Double) -> UInt16 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt16.min) else { return UInt16.min }
        guard value <= Double(UInt16.max) else { return UInt16.max }

        return UInt16(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt16(_ res: Double, offset: Double) -> Int16 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int16.min) else { return Int16.min }
        guard value <= Double(Int16.max) else { return Int16.max }

        return Int16(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt32(_ res: Double, offset: Double) -> UInt32 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt32.min) else { return UInt32.min }
        guard value <= Double(UInt32.max) else { return UInt32.max }

        return UInt32(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt32(_ res: Double, offset: Double) -> Int32 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int32.min) else { return Int32.min }
        guard value <= Double(Int32.max) else { return Int32.max }

        return Int32(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionUInt64(_ res: Double, offset: Double) -> UInt64 {
        let value = (Double(self) * res) + offset

        guard value >= Double(UInt64.min) else { return UInt64.min }
        guard value <= Double(UInt64.max) else { return UInt64.max }

        return UInt64(value)
    }

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - res: Resolution
    ///   - offset: Value to Add after Scale Applied
    /// - Returns: Number with Resolution applied
    func resolutionInt64(_ res: Double, offset: Double) -> Int64 {
        let value = (Double(self) * res) + offset

        guard value >= Double(Int64.min) else { return Int64.min }
        guard value <= Double(Int64.max) else { return Int64.max }

        return Int64(value)
    }
}


extension Int32: Resolutionable {

    /// Apply a Resolution to a number
    ///
    /// - Parameters:
    ///   - scale: Scale
    ///   - offset: Value to Add
    /// - Returns: Number with Resolution applied
    func resolution(_ scale: Double, offset: Double = 0) -> Double {
        return (Double(self) * scale) + offset
    }
}
