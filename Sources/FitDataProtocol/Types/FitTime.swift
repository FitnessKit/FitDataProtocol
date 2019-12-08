//
//  FitTime.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
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

/// FIT Time
public struct FitTime {

    /// Timestamp in UTC
    private(set) public var recordDate: Date?

    /// Time since device power up
    private(set) public var secondSincePowerUp: TimeInterval?

    /// Is Local Date
    private(set) public var isLocal: Bool

    internal init(time: UInt32, isLocal: Bool = false) {
        // if date_time is < 0x10000000 then it is system time (seconds from device power on)
        if time < 0x10000000 {
            self.secondSincePowerUp = TimeInterval(time)
            self.isLocal = false
        } else {
            if isLocal {
                self.recordDate = Date(timeInterval: TimeInterval(time), since: Date.localAntEPOCH)
                self.isLocal = isLocal
            } else {
                self.recordDate = Date(timeInterval: TimeInterval(time), since: Date.antEPOCH)
                self.isLocal = false
            }
        }
    }

    public init(date: Date, isLocal: Bool = false) {
        self.recordDate = date
        self.isLocal = isLocal
    }

    public init(secondSincePowerUp: TimeInterval) {
        self.secondSincePowerUp = secondSincePowerUp
        self.isLocal = false
    }

}

internal extension FitTime {

    /// Encodes the FileIdMessage into Data
    ///
    /// - Returns: Data representation
    func encode(isLocal: Bool = false) -> Data {
        var msgData = Data()

        if let recordDate = recordDate {

            if isLocal {
                let time = UInt32(recordDate.timeIntervalSince(Date.localAntEPOCH))
                msgData.append(Data(from: time.littleEndian))
            } else {
                let time = UInt32(recordDate.timeIntervalSince(Date.antEPOCH))
                msgData.append(Data(from: time.littleEndian))
            }
            
        } else if let seconds = secondSincePowerUp {
            let time = UInt32(seconds)
            msgData.append(Data(from: time.littleEndian))
        }

        return msgData
    }
    
    static func decode(data: Data, base: BaseTypeData, arch: Endian, isLocal: Bool = false) -> FitTime? {
        if let value = base.type.decode(type: UInt32.self, data: data, resolution: base.resolution, arch: arch) {
            return FitTime(time: value, isLocal: isLocal)
        }

        return nil
    }
}
