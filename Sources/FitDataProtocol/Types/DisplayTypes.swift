//
//  DisplayTypes.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
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
import DataDecoder

/// Display Type for Measurement
public enum MeasurementDisplayType: UInt8 {
    /// Metric
    case metric         = 0
    /// Statute
    case statute        = 1
    /// Nautical
    case nautical       = 2

    /// Invalid
    case invalid        = 255
}

internal extension MeasurementDisplayType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> MeasurementDisplayType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return MeasurementDisplayType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return MeasurementDisplayType.invalid
            }
        }

    }
}

/// Display Type for Heeart Rate
public enum HeartRateDisplayType: UInt8 {
    /// BPM
    case beatsPerMinute     = 0
    /// MAX
    case max                = 1
    /// Reserved
    case reserved           = 2

    /// Invalid
    case invalid            = 255
}

internal extension HeartRateDisplayType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> HeartRateDisplayType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return HeartRateDisplayType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return HeartRateDisplayType.invalid
            }
        }
    }
}

/// Display Type for Power
public enum PowerDisplayType: UInt8 {
    /// Watts
    case watts              = 0
    /// Percent FTP
    case percentFTP         = 1

    /// Invalid
    case invalid            = 255
}

internal extension PowerDisplayType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> PowerDisplayType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return PowerDisplayType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return PowerDisplayType.invalid
            }
        }
    }
}

/// Display Type for Position
public enum PositionDisplayType: UInt8 {
    /// Degree (dd.dddddd)
    case degree                         = 0
    /// Degree Minute (dddmm.mmm)
    case degreeMinute                   = 1
    /// Degree Minute Second (dddmmss)
    case degreeMinuteSecond             = 2
    /// Austrian Grid (BMN)
    case austrianGrid                   = 3
    /// British National Grid
    case britishNationalGrid            = 4
    /// Dutch grid system
    case dutchGridSystem                = 5
    /// Hungarian grid system
    case hungarianGridSystem            = 6
    /// Finnish grid system Zone3 KKJ27
    case finnishGridSystem              = 7
    /// Gausss Krueger (German)
    case germanGrid                     = 8
    /// Icelandic Grid
    case icelandicGrid                  = 9
    /// Indonesian Equatorial LCO
    case indonesianEquatorial           = 10
    /// Indonesian Irian LCO
    case indonesianIrian                = 11
    /// Indonesian Southern LCO
    case indonesianSouthern             = 12
    /// India zone 0
    case indiaZone0                     = 13
    /// India zone IA
    case indiaZoneIA                    = 14
    /// India zone IB
    case indiaZoneIB                    = 15
    /// India zone IIA
    case indiaZoneIIA                   = 16
    /// India zone IIB
    case indiaZoneIIB                   = 17
    /// India zone IIIA
    case indiaZoneIIIA                  = 18
    /// India zone IIIB
    case indiaZoneIIIB                  = 19
    /// India zone IVA
    case indiaZoneIVA                   = 20
    /// India zone IVB
    case indiaZoneIVB                   = 21
    /// Irish Transverse Mercator
    case irishTransverseMercator        = 22
    /// Irish Grid
    case irishGrid                      = 23
    /// Loran TD
    case loranTD                        = 24
    /// Maidenhead grid system
    case maidenheadGridSystem           = 25
    /// MGRS grid system
    case mgrsGridSystem                 = 26
    /// New Zealand grid system
    case newZealandGridSystem           = 27
    /// New Zealand Transverse Mercator
    case newZealandTransverseMercator   = 28
    /// Qatar National Grid
    case qatarNationalGrid              = 29
    /// Modified RT-90 (Sweden)
    case modifiedSwedishGrid            = 30
    /// RT-90 (Sweden)
    case swedishGrid                    = 31
    /// South African Grid
    case southAfricanGrid               = 32
    /// Swiss CH-1903 grid
    case swissGrid                      = 33
    /// Taiwan Grid
    case taiwanGrid                     = 34
    /// United States National Grid
    case unitedStatesNationalGrid       = 35
    /// UTM/UPS grid system
    case utmUpsGrid                     = 36
    /// West Malayan RSO
    case westMalayan                    = 37
    /// Borneo RSO
    case borneo                         = 38
    /// Estonian grid system
    case estonianGrid                   = 39
    /// Latvian Transverse Mercator
    case latvianTransverseMercator      = 40
    /// Reference Grid 99 TM (Swedish)
    case swedishReferenceGrid99         = 41

    /// Invalid
    case invalid                        = 255
}

internal extension PositionDisplayType {

    internal static func decode(decoder: inout DecodeData, definition: FieldDefinition, data: FieldData, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> PositionDisplayType? {

        let value = decoder.decodeUInt8(data.fieldData)
        if value.isValidForBaseType(definition.baseType) {
            return PositionDisplayType(rawValue: value)
        } else {

            switch dataStrategy {
            case .nil:
                return nil
            case .useInvalid:
                return PositionDisplayType.invalid
            }
        }
    }
}
