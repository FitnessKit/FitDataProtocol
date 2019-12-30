//
//  WeatherSeverity.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/29/18.
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

/// Weather Severity
public enum WeatherSeverity: UInt8 {
    /// Unknown
    case unknown        = 0
    /// Warning
    case warning        = 1
    /// Watch
    case watch          = 2
    /// Advisory
    case advisory       = 3
    /// Statement
    case statement      = 4

    /// Invalid
    case invalid        = 255
}

// MARK: - FitFieldCodeable
extension WeatherSeverity: FitFieldCodeable {
    
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
            return WeatherSeverity(rawValue: value) as? T
        }
        
        return nil
    }
}

/// Weather Severity Type
public enum WeatherSeverityType: UInt8 {
    /// Unspecified
    case unspecified            = 0
    /// Tornado
    case tornado                = 1
    /// Tsunami
    case tsunami                = 2
    /// Hurricane
    case hurricane              = 3
    /// Extreme Wind
    case extremeWind            = 4
    /// Typhoon
    case typhoon                = 5
    /// Inland Hurricane
    case inlandHurricane        = 6
    /// Hurricane Force Wind
    case hurricaneForceWind     = 7
    /// Waterspout
    case waterspout             = 8
    /// Severe Thunderstorm
    case severeThunderstorm     = 9
    /// Wreckhouse Winds
    case wreckhouseWinds        = 10
    /// Les Suetes Winds
    case lesSuetesWinds         = 11
    /// Avalanche
    case avalanche              = 12
    /// Flash Floods
    case flashFloods            = 13
    /// Tropical Storm
    case tropicalStorm          = 14
    /// Inland Tropical Storm
    case inlandTropicalStorm    = 15
    /// Blizzard
    case blizzard               = 16
    /// Ice Storm
    case iceStorm               = 17
    /// Freezing Rain
    case freezingRain           = 18
    /// Debris Flow
    case debrisFlow             = 19
    /// Flash Freeze
    case flashFreeze            = 20
    /// Dust Storm
    case dustStorm              = 21
    /// High Wind
    case highWind               = 22
    /// Winter Storm
    case winterStorm            = 23
    /// Heavy Freezing Spray
    case heavyFreezingSpray     = 24
    /// Extreme Cold
    case extremeCold            = 25
    /// Wind Chill
    case windChill              = 26
    /// Cold Wave
    case coldWave               = 27
    /// Heavy Snow Alert
    case heavySnowAlert         = 28
    /// Lake Effect Blowing Snow
    case lakeEffectBlowingSnow  = 29
    /// Snow Squall
    case snowSquall             = 30
    /// Lake Effect Snow
    case lakeEffectSnow         = 31
    /// Winter Weather
    case winterWeather          = 32
    /// Sleet
    case sleet                  = 33
    /// Snowfall
    case snowfall               = 34
    /// Snow and Blowing Snow
    case snowBlowingSnow        = 35
    /// Blowing Snow
    case blowingSnow            = 36
    /// Snow Alert
    case snowAlert              = 37
    /// Artic Outflow
    case articOutflow           = 38
    /// Freezing Drizzle
    case freezingDrizzle        = 39
    /// Storm
    case storm                  = 40
    /// Storm Surge
    case stormSurge             = 41
    /// Rainfall
    case rainfall               = 42
    /// Areal Flood
    case arealFlood             = 43
    /// Costal Flood
    case costalFlood            = 44
    /// Lakeshore Flood
    case lakeshoreFlood         = 45
    /// Excessive Heat
    case excessiveHeat          = 46
    /// Heat
    case heat                   = 47
    /// Weather
    case weather                = 48
    /// High Heat and Humidity
    case highHeatHumidity       = 49
    /// Humidex and Health
    case humidexHealth          = 50
    /// Humidex
    case humidex                = 51
    /// Gale
    case gale                   = 52
    /// Freezing Spray
    case freezingSpray          = 53
    /// Special Marine
    case specialMarine          = 54
    /// Squall
    case squall                 = 55
    /// Strong Wind
    case strongWind             = 56
    /// Lake Wind
    case lakeWind               = 57
    /// Marine Weather
    case marineWeather          = 58
    /// Wind
    case wind                   = 59
    /// Small Craft Hazardous Seas
    case smallCrafHazardousSeas = 60
    /// Hazardous Seas
    case hazardousSeas          = 61
    /// Small Craft
    case smallCraft             = 62
    /// Small Craft Winds
    case smallCraftWinds        = 63
    /// Small Craft Rough Bar
    case smallCraftRoughBar     = 64
    /// High Water Level
    case highWaterLevel         = 65
    /// Ashfall
    case ashfall                = 66
    /// Freezing Fog
    case freezingFog            = 67
    /// Dense Fog
    case denseFog               = 68
    /// Dense Smoke
    case denseSmoke             = 69
    /// Blowing Dust
    case blowingDust            = 70
    /// Hard Freeze
    case hardFreeze             = 71
    /// Freeze
    case freeze                 = 72
    /// Frost
    case frost                  = 73
    /// Fire Weather
    case fireWeather            = 74
    /// Flood
    case flood                  = 75
    /// Rip Tide
    case ripTide                = 76
    /// High Surf
    case highSurf               = 77
    /// Smog
    case smog                   = 78
    /// Air Quality
    case airQuality             = 79
    /// Brisk Wind
    case briskWind              = 80
    /// Air Stagnation
    case airStagnation          = 81
    /// Low Water
    case lowWater               = 82
    /// Hydrological
    case hydrological           = 83
    /// Special Weather
    case specialWeather         = 84

    /// Invalid
    case invalid                = 255
}

// MARK: - FitFieldCodeable
extension WeatherSeverityType: FitFieldCodeable {
    
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
