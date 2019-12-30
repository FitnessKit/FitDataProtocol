//
//  SportCapabilities.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/29/19.
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

/// Sport Capabilities
public struct SportCapabilities {
    /// Sports Bits 0
    private(set) public var bits0: SportBits0?
    
    /// Sports Bits 1
    private(set) public var bits1: SportBits1?
    
    /// Sports Bits 2
    private(set) public var bits2: SportBits2?
    
    /// Sports Bits 3
    private(set) public var bits3: SportBits3?
    
    /// Sports Bits 4
    private(set) public var bits4: SportBits4?
    
    /// Sports Bits 5
    private(set) public var bits5: SportBits5?
    
    /// Sports Bits 6
    private(set) public var bits6: SportBits6?
    
    public init(bits0: SportBits0?,
                bits1: SportBits1?,
                bits2: SportBits2?,
                bits3: SportBits3?,
                bits4: SportBits4?,
                bits5: SportBits5?,
                bits6: SportBits6?) {
        self.bits0 = bits0
        self.bits1 = bits1
        self.bits2 = bits2
        self.bits3 = bits3
        self.bits4 = bits4
        self.bits5 = bits5
        self.bits6 = bits6
    }
    
    internal init(data: Data?) {
        if let values = data?.segment(size: MemoryLayout<UInt8>.size) {
            for (index, bits) in values.enumerated() {
                switch index {
                case 0:
                    self.bits0 = SportBits0(rawValue: bits.to(type: UInt8.self))
                case 1:
                    self.bits1 = SportBits1(rawValue: bits.to(type: UInt8.self))
                case 2:
                    self.bits2 = SportBits2(rawValue: bits.to(type: UInt8.self))
                case 3:
                    self.bits3 = SportBits3(rawValue: bits.to(type: UInt8.self))
                case 4:
                    self.bits4 = SportBits4(rawValue: bits.to(type: UInt8.self))
                case 5:
                    self.bits5 = SportBits5(rawValue: bits.to(type: UInt8.self))
                case 6:
                    self.bits6 = SportBits6(rawValue: bits.to(type: UInt8.self))
                
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

public extension SportCapabilities {
    
    /// Bit field corresponding to sport enum
    struct SportBits0: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Generic
        public static let generic = SportBits0(rawValue: 0x01)
        /// Running
        public static let running = SportBits0(rawValue: 0x02)
        /// Cycling
        public static let cycling = SportBits0(rawValue: 0x04)
        /// Multi-Sport Transition
        public static let multisportTransition = SportBits0(rawValue: 0x08)
        /// Fitness Equipment
        public static let fitnessEquipment = SportBits0(rawValue: 0x10)
        /// Swimming
        public static let swimming = SportBits0(rawValue: 0x20)
        /// Basketball
        public static let basketball = SportBits0(rawValue: 0x40)
        /// Soccer
        public static let soccer = SportBits0(rawValue: 0x80)
    }
    
    /// Bit field corresponding to sport enum
    struct SportBits1: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Tennis
        public static let tennis = SportBits1(rawValue: 0x01)
        /// American Football
        public static let americanFootball = SportBits1(rawValue: 0x02)
        /// Training
        public static let training = SportBits1(rawValue: 0x04)
        /// Walking
        public static let walking = SportBits1(rawValue: 0x08)
        /// Cross Country Skiing
        public static let crossCountySkiing = SportBits1(rawValue: 0x10)
        /// Alpine Skiing
        public static let alpineSkiing = SportBits1(rawValue: 0x20)
        /// Snowboarding
        public static let snowboarding = SportBits1(rawValue: 0x40)
        /// Rowing
        public static let rowing = SportBits1(rawValue: 0x80)
    }
    
    /// Bit field corresponding to sport enum
    struct SportBits2: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Mountaineering
        public static let mountaineering = SportBits2(rawValue: 0x01)
        /// Hiking
        public static let hiking = SportBits2(rawValue: 0x02)
        /// Multisport
        public static let multisport = SportBits2(rawValue: 0x04)
        /// Paddling
        public static let paddling = SportBits2(rawValue: 0x08)
        /// Flying
        public static let flying = SportBits2(rawValue: 0x10)
        /// eBiking
        public static let eBiking = SportBits2(rawValue: 0x20)
        /// Motorcycling
        public static let motorcycling = SportBits2(rawValue: 0x40)
        /// Boating
        public static let boating = SportBits2(rawValue: 0x80)
    }
    
    /// Bit field corresponding to sport enum
    struct SportBits3: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Driving
        public static let driving = SportBits3(rawValue: 0x01)
        /// Golf
        public static let golf = SportBits3(rawValue: 0x02)
        /// Hang Gliding
        public static let hangGliding = SportBits3(rawValue: 0x04)
        /// Horseback Riding
        public static let horsebackRiding = SportBits3(rawValue: 0x08)
        /// Hunting
        public static let hunting = SportBits3(rawValue: 0x10)
        /// Fishing
        public static let fishing = SportBits3(rawValue: 0x20)
        /// Inline Skating
        public static let inlineSkating = SportBits3(rawValue: 0x40)
        /// Rock Climbing
        public static let rockClimbing = SportBits3(rawValue: 0x80)
    }
    
    /// Bit field corresponding to sport enum
    struct SportBits4: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Sailing
        public static let sailing = SportBits4(rawValue: 0x01)
        /// Ice Skating
        public static let iceSkating = SportBits4(rawValue: 0x02)
        /// Sky Diving
        public static let skyDiving = SportBits4(rawValue: 0x04)
        /// Snowshoeing
        public static let snowshoeing = SportBits4(rawValue: 0x08)
        /// Snowmobiling
        public static let snowmobiling = SportBits4(rawValue: 0x10)
        /// Stand Up Paddel Boarding
        public static let standUpPaddelboarding = SportBits4(rawValue: 0x20)
        /// Surfing
        public static let surfing = SportBits4(rawValue: 0x40)
        /// Wakeboarding
        public static let wakeboarding = SportBits4(rawValue: 0x80)
    }
    
    /// Bit field corresponding to sport enum
    struct SportBits5: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Water Skiing
        public static let waterSkiing = SportBits5(rawValue: 0x01)
        /// Kayaking
        public static let kayaking = SportBits5(rawValue: 0x02)
        /// Rafting
        public static let rafting = SportBits5(rawValue: 0x04)
        /// Wind Surfing
        public static let windSurfing = SportBits5(rawValue: 0x08)
        /// Kite Surfing
        public static let kiteSurfing = SportBits5(rawValue: 0x10)
        /// Tactical
        public static let tactical = SportBits5(rawValue: 0x20)
        /// Jump Master
        public static let jumpMaster = SportBits5(rawValue: 0x40)
        /// Boxing
        public static let boxing = SportBits5(rawValue: 0x80)
    }
    
    /// Bit field corresponding to sport enum
    struct SportBits6: OptionSet {
        public let rawValue: UInt8
        public init(rawValue: UInt8) { self.rawValue = rawValue }
        
        /// Floor Climbing
        public static let floorClimbing = SportBits5(rawValue: 0x01)
    }
    
}
