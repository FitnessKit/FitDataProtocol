//
//  BacklightMode.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/15/19.
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

/// FIT Backlight Mode
public enum BacklightMode: UInt8 {
    /// Off
    case off                            = 0
    /// Manual
    case manual                         = 1
    /// Key and Messages
    case keyMessages                    = 2
    /// Auto Brightness
    case autoBrightness                 = 3
    /// Smart Notifications
    case smartNotifications             = 4
    /// Key and Messages Night
    case keyMessagesNight               = 5
    /// Key and Messages and Smart Notifications
    case keyMessagesSmartNotifications  = 6
    
    /// Invalid
    case invalid                        = 255
}

// MARK: - FitFieldCodeable
extension BacklightMode: FitFieldCodeable {
    
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
            return BacklightMode(rawValue: value) as? T
        }
        
        return nil
    }
}
