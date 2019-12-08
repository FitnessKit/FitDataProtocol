//
//  BaseTypeDecode.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 11/23/19.
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

// MARK: - Measurement
internal extension BaseType {

    func decode<UnitType>(unit: UnitType, data: Data?, resolution: Resolution, arch: Endian) -> Measurement<UnitType>? {
        guard let data = data else { return nil }
        
        switch self {
        case .enumtype, .uint8, .unknown, .uint8z, .byte:
            if let value = data.to(type: UInt8.self) {
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }
            
        case .sint8:
            if let value = data.to(type: Int8.self) {
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }

        case .sint16:
            if var value = data.to(type: Int16.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }

        case .uint16, .uint16z:
            if var value = data.to(type: UInt16.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: Double(val), unit: unit)
            }

        case .sint32:
            if var value = data.to(type: Int32.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }
            
        case .uint32, .uint32z:
            if var value = data.to(type: UInt32.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }

        case .string:
            fatalError("String can not be used in Measurement")
            
        case .float32:
            if let value = data.to(type: Float32.self) {
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: Double(val), unit: unit)
            }

        case .float64:
            if let value = data.to(type: Float64.self) {
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: Double(val), unit: unit)
            }

        case .sint64:
            if var value = data.to(type: Int64.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }

        case .uint64, .uint64z:
            if var value = data.to(type: UInt64.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                let val = value.resolution(.removing, resolution: resolution)
                return Measurement(value: val, unit: unit)
            }
        }
        
        return nil
    }

}

// MARK: - Generic
internal extension BaseType {
        
    // KAH - These probably should be ?T on the return
    func decode<T>(type: T.Type, data: Data?, resolution: Resolution, arch: Endian) -> T? {
        guard let data = data else { return nil }
        
        switch self {
        case .enumtype, .uint8, .unknown, .uint8z, .byte:
            if let value = data.to(type: UInt8.self) {
                return (value.resolution(type: UInt8.self, .removing, resolution: resolution) as! T)
            }
            
        case .sint8:
            if let value = data.to(type: Int8.self) {
                return (value.resolution(type: Int8.self, .removing, resolution: resolution) as! T)
            }

        case .sint16:
            if var value = data.to(type: Int16.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                return (value.resolution(type: Int16.self, .removing, resolution: resolution) as! T)
            }

        case .uint16, .uint16z:
            if var value = data.to(type: UInt16.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                return (value.resolution(type: UInt16.self, .removing, resolution: resolution) as! T)
            }

        case .sint32:
            if var value = data.to(type: Int32.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                return (value.resolution(type: Int32.self, .removing, resolution: resolution) as! T)
            }
            
        case .uint32, .uint32z:
            if var value = data.to(type: UInt32.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                return (value.resolution(type: UInt32.self, .removing, resolution: resolution) as! T)
            }

        case .string:
            return (data.smartString as! T)
            
        case .float32:
            if let value = data.to(type: Float32.self) {
                return (value.resolution(.removing, resolution: resolution) as! T)
            }

        case .float64:
            if let value = data.to(type: Float64.self) {
                return (value.resolution(.removing, resolution: resolution) as! T)
            }

        case .sint64:
            if var value = data.to(type: Int64.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                return (value.resolution(type: Int64.self, .removing, resolution: resolution) as! T)
            }

        case .uint64, .uint64z:
            if var value = data.to(type: UInt64.self) {
                value = arch == .little ? value.littleEndian : value.bigEndian
                return (value.resolution(type: UInt64.self, .removing, resolution: resolution) as! T)
            }
        }
        
        return nil
    }
}
