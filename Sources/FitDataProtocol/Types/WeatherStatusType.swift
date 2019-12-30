//
//  WeatherStatusType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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

/// Weather Status Type
public enum WeatherStatus: UInt8 {
    /// Clear
    case clear                      = 0
    /// Partly Cloudy
    case partlyCloudy               = 1
    /// Mostly Cloudy
    case mostlyCloudy               = 2
    /// Rain
    case rain                       = 3
    /// Snow
    case snow                       = 4
    /// Windy
    case windy                      = 5
    /// Thunderstorms
    case thunderstorms              = 6
    /// Wintery Mix
    case winteryMix                 = 7
    /// Fog
    case fog                        = 8
    /// Hazy
    case hazy                       = 11
    /// Hail
    case hail                       = 12
    /// Scattered Showers
    case scatteredShowers           = 13
    /// Scattered Thunderstorms
    case scatteredThunderstorms     = 14
    /// Unknown Precipitation
    case unknownPrecipitation       = 15
    /// Light Rain
    case lightRain                  = 16
    /// Heavy Rain
    case heavyRain                  = 17
    /// Light Snow
    case lightSnow                  = 18
    /// Heavy Snow
    case heavySnow                  = 19
    /// Light Rain Snow
    case lightRainSnow              = 20
    /// Heavy Rain Snow
    case heavyRainSnow              = 21
    /// Cloudy
    case cloudy                     = 22

    /// Invalid
    case invalid                    = 255
}

// MARK: - FitFieldCodeable
extension WeatherStatus: FitFieldCodeable {
    
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
            return WeatherSeverityType(rawValue: value) as? T
        }
        
        return nil
    }
}
