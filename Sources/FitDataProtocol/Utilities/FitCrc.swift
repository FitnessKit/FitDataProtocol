//
//  FitCrc.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
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


/**
 Table of FIT 16 bit CRC
 */
private let crc_table: [UInt16] = [
    0x0000, 0xCC01, 0xD801, 0x1400, 0xF001, 0x3C00, 0x2800, 0xE401,
    0xA001, 0x6C00, 0x7800, 0xB401, 0x5000, 0x9C01, 0x8801, 0x4400]


/// FIT 16bit CRC
final public class CRC16 {
    private(set) var crc: UInt16 = 0

    public init() {}

    public convenience init(data: Data) {
        self.init()

        crc = CRC16.caluclate(data: data)
    }
}

private extension CRC16 {

    private class func caluclate(data: Data) -> UInt16 {

        var tmp: UInt16 = 0
        var crc: UInt16 = 0

        for byte in data {
            // compute checksum of lower four bits of byte
            tmp = crc_table[Int(crc & 0xF)]
            crc = (crc >> 4) & 0x0FFF
            crc = crc ^ tmp ^ crc_table[Int(byte & 0xF)]

            // now compute checksum of upper four bits of byte
            tmp = crc_table[Int(crc & 0xF)];
            crc = (crc >> 4) & 0x0FFF;
            crc = crc ^ tmp ^ crc_table[Int((byte >> 4) & 0xF)]
        }

        return crc
    }

}

extension CRC16: Equatable {
    public static func ==(lhs: CRC16, rhs: CRC16) -> Bool {
        return lhs.crc == rhs.crc
    }
}

extension CRC16: Hashable {
    public var hashValue: Int {
        return crc.hashValue
    }
}
