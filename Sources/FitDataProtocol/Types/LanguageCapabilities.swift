//
//  LanguageCapabilities.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/30/19.
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

/// Language Capabilities
public struct LanguageCapabilities {
    /// Language Bits 0
    private(set) public var bits0: LanguageBits0?
    
    /// Language Bits 1
    private(set) public var bits1: LanguageBits1?
    
    /// Language Bits 2
    private(set) public var bits2: LanguageBits2?
    
    /// Language Bits 3
    private(set) public var bits3: LanguageBits3?
    
    /// Language Bits 4
    private(set) public var bits4: LanguageBits4?
    
    public init(bits0: LanguageBits0?,
                bits1: LanguageBits1?,
                bits2: LanguageBits2?,
                bits3: LanguageBits3?,
                bits4: LanguageBits4) {
        self.bits0 = bits0
        self.bits1 = bits1
        self.bits2 = bits2
        self.bits3 = bits3
        self.bits4 = bits4
    }
    
    internal init(data: Data?) {
        if let values = data?.segment(size: MemoryLayout<UInt8>.size) {
            for (index, bits) in values.enumerated() {
                switch index {
                case 0:
                    self.bits0 = LanguageBits0(rawValue: bits.to(type: UInt8.self))
                case 1:
                    self.bits1 = LanguageBits1(rawValue: bits.to(type: UInt8.self))
                case 2:
                    self.bits2 = LanguageBits2(rawValue: bits.to(type: UInt8.self))
                case 3:
                    self.bits3 = LanguageBits3(rawValue: bits.to(type: UInt8.self))
                case 4:
                    self.bits4 = LanguageBits4(rawValue: bits.to(type: UInt8.self))
                    
                default:
                    break
                }
            }
        }
    }
    
    internal func encode() -> Data? {
        var returnData: Data?
        for child in Mirror(reflecting: self).children {
            if returnData == nil { returnData = Data() }
            if let value = child.value as? UInt8 {
                returnData?.append(Data(from: value))
            } else {
                returnData?.append(Data(from: UInt8(0)))
            }
        }
        
        return returnData
    }
    
}

public extension LanguageCapabilities {
    
    /// Bit field corresponding to language enum
    struct LanguageBits0: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// English
        public static let english = LanguageBits0(rawValue: 0x01)
        /// French
        public static let french = LanguageBits0(rawValue: 0x02)
        /// Italian
        public static let italian = LanguageBits0(rawValue: 0x04)
        /// German
        public static let german = LanguageBits0(rawValue: 0x08)
        /// Spanish
        public static let spanish = LanguageBits0(rawValue: 0x10)
        /// Croatian
        public static let croatian = LanguageBits0(rawValue: 0x20)
        /// Czech
        public static let czech = LanguageBits0(rawValue: 0x40)
        /// Danish
        public static let danish = LanguageBits0(rawValue: 0x80)
    }
    
    /// Bit field corresponding to language enum
    struct LanguageBits1: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Dutch
        public static let dutch = LanguageBits1(rawValue: 0x01)
        /// Finnish
        public static let finnish = LanguageBits1(rawValue: 0x02)
        /// Greek
        public static let greek = LanguageBits1(rawValue: 0x04)
        /// Hungarian
        public static let hungarian = LanguageBits1(rawValue: 0x08)
        /// Norwegian
        public static let norwegian = LanguageBits1(rawValue: 0x10)
        /// Polish
        public static let polish = LanguageBits1(rawValue: 0x20)
        /// Portuguese
        public static let portuguese = LanguageBits1(rawValue: 0x40)
        /// Slovakian
        public static let slovakian = LanguageBits1(rawValue: 0x80)
    }
    
    /// Bit field corresponding to language enum
    struct LanguageBits2: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Slovenian
        public static let slovenian = LanguageBits2(rawValue: 0x01)
        /// Swedish
        public static let swedish = LanguageBits2(rawValue: 0x02)
        /// Russian
        public static let russian = LanguageBits2(rawValue: 0x04)
        /// Turkish
        public static let turkish = LanguageBits2(rawValue: 0x08)
        /// Latvian
        public static let latvian = LanguageBits2(rawValue: 0x10)
        /// Ukrainian
        public static let ukrainian = LanguageBits2(rawValue: 0x20)
        /// Arabic
        public static let arabic = LanguageBits2(rawValue: 0x40)
        /// Farsi
        public static let farsi = LanguageBits2(rawValue: 0x80)
    }
    
    /// Bit field corresponding to language enum
    struct LanguageBits3: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Bulgarian
        public static let bulgarian = LanguageBits3(rawValue: 0x01)
        /// Romanian
        public static let romanian = LanguageBits3(rawValue: 0x02)
        /// Chinnese
        public static let chinnese = LanguageBits3(rawValue: 0x04)
        /// Japannese
        public static let japannese = LanguageBits3(rawValue: 0x08)
        /// Korean
        public static let korean = LanguageBits3(rawValue: 0x10)
        /// Taiwanese
        public static let taiwanese = LanguageBits3(rawValue: 0x20)
        /// Thai
        public static let thai = LanguageBits3(rawValue: 0x40)
        /// Hewbrew
        public static let hewbrew = LanguageBits3(rawValue: 0x80)
    }
    
    /// Bit field corresponding to language enum
    struct LanguageBits4: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Brazilian Portuguese
        public static let brazilianPortuguese = LanguageBits4(rawValue: 0x01)
        /// Indonesian
        public static let indonesian = LanguageBits4(rawValue: 0x02)
        /// Malaysian
        public static let malaysian = LanguageBits4(rawValue: 0x04)
        /// Vietnamese
        public static let vietnamese = LanguageBits4(rawValue: 0x08)
        /// Burmese
        public static let burmese = LanguageBits4(rawValue: 0x10)
        /// Mongolain
        public static let mongolain = LanguageBits4(rawValue: 0x20)
    }
    
}
