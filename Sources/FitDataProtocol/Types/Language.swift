//
//  Language.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
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

/// Language Type
public enum Language: UInt8 {
    /// English
    case english                = 0
    /// French
    case french                 = 1
    /// Italian
    case italian                = 2
    /// German
    case german                 = 3
    /// Spanish
    case spanish                = 4
    /// Croatian
    case croatian               = 5
    /// Czech
    case czech                  = 6
    /// Danish
    case danish                 = 7
    /// Dutch
    case dutch                  = 8
    /// Finnish
    case finnish                = 9
    /// Greek
    case greek                  = 10
    /// Hungarian
    case hungarian              = 11
    /// Norwegian
    case norwegian              = 12
    /// Polish
    case polish                 = 13
    /// Portuguese
    case portuguese             = 14
    /// Slovakian
    case slovakian              = 15
    /// Slovenian
    case slovenian              = 16
    /// Swedish
    case swedish                = 17
    /// Russian
    case russian                = 18
    /// Turkish
    case turkish                = 19
    /// Latvian
    case latvian                = 20
    /// Ukrainian
    case ukrainian              = 21
    /// Arabic
    case arabic                 = 22
    /// Farsi
    case farsi                  = 23
    /// Bulgarian  
    case bulgarian              = 24
    /// Romanian
    case romanian               = 25
    /// Chinese
    case chinese                = 26
    /// Japanese
    case japanese               = 27
    /// Korean
    case korean                 = 28
    /// Taiwanese
    case taiwanese              = 29
    /// Thai
    case thai                   = 30
    /// Hebrew
    case hebrew                 = 31
    /// Brazilian Portuguese
    case brazilianPortuguese    = 32
    /// Indonesian
    case indonesian             = 33
    /// Malaysian
    case malaysian              = 34
    /// Vietnamese
    case vietnamese             = 35
    /// Burmese
    case burmese                = 36
    /// Mongolian
    case mongolian              = 37

    /// Custom
    case custom                 = 254
    /// Invalid
    case invalid                = 255
}

// MARK: - FitFieldCodeable
extension Language: FitFieldCodeable {
    
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
            return Language(rawValue: value) as? T
        }
        
        return nil
    }
}
