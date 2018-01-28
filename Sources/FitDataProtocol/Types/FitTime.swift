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
    private(set) var recordDate: Date?

    /// Time since device power up
    private(set) var secondSincePowerUp: TimeInterval?

    internal init(time: UInt32, isLocal: Bool = false) {
        // if date_time is < 0x10000000 then it is system time (seconds from device power on)
        if time < 0x10000000 {
            self.secondSincePowerUp = TimeInterval(time)
        } else {
            if isLocal {
                self.recordDate = Date(timeInterval: TimeInterval(time), since: Date.localAntEPOCH)
            } else {
                self.recordDate = Date(timeInterval: TimeInterval(time), since: Date.antEPOCH)
            }
        }
    }
}
