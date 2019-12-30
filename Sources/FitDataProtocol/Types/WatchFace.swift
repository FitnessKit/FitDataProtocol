//
//  WatchFace.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/28/19.
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

/// Watchface Mode
public enum WatchfaceMode: UInt8 {
    /// Digital
    case digital    = 0
    /// Analog
    case analog     = 1
    /// Connect IQ
    case connectIq  = 2
    /// Disabled
    case disabled   = 3
    
    /// Invalid
    case invalid    = 255
    
    /// Layout for the Mode
    internal var layout: WatchfaceLayout.Type? {
        switch self {
        case .digital:
            return DigitalWatchfaceLayout.self
        case .analog:
            return AnalogWatchfaceLayout.self
        case .connectIq:
            return nil
        case .disabled:
            return nil
        case .invalid:
            return nil
        }
    }
    
    /// Create a WatchfaceLayout
    /// - Parameter rawValue: WatchfaceLayout rawValue
    internal func createLayout(rawValue: UInt8?) -> WatchfaceLayout? {
        guard let rawValue = rawValue else { return nil }
        
        switch self {
        case .digital:
            return DigitalWatchfaceLayout(rawValue: rawValue)
        case .analog:
            return AnalogWatchfaceLayout(rawValue: rawValue)
        case .connectIq:
            return nil
        case .disabled:
            return nil
        case .invalid:
            return nil
        }
    }
}

extension WatchfaceMode: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
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
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return WatchfaceMode(rawValue: value) as? T
        }
        
        return nil
    }
}

public protocol WatchfaceLayout: FitFieldCodeable {
    /// Raw Value
    var rawValue: UInt8 { get }
}

/// Analog Watchface Layout
public enum AnalogWatchfaceLayout: UInt8, WatchfaceLayout {
    /// Minimal
    case minimal        = 0
    /// Traditional
    case traditional    = 1
    /// Modern
    case modern         = 2
    
    /// Invalid
    case invalid        = 255
}

extension AnalogWatchfaceLayout: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
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
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return AnalogWatchfaceLayout(rawValue: value) as? T
        }
        
        return nil
    }
}

/// Digital Watchface Layout
public enum DigitalWatchfaceLayout: UInt8, WatchfaceLayout {
    /// Traditional
    case traditional    = 0
    /// Modern
    case modern         = 1
    /// Bold
    case bold           = 2
    
    /// Invalid
    case invalid        = 255
}

extension DigitalWatchfaceLayout: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
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
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return DigitalWatchfaceLayout(rawValue: value) as? T
        }
        
        return nil
    }
}
