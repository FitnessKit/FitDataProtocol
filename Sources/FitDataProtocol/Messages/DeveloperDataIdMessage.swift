//
//  DeveloperDataIdMessage.swift
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
import DataDecoder

/// FIT Developer Data ID Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeveloperDataIdMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 207
    }

    /// Developer ID
    private(set) public var developerId: Data?

    /// Application ID
    private(set) public var applicationId: Data?

    /// Application Version
    private(set) public var applicationVersion: UInt32?

    /// Manufacturer
    private(set) public var manufacturer: Manufacturer?

    /// Data Index
    private(set) public var dataIndex: UInt8?

    public required init() {}

    public init(developerId: Data?, applicationId: Data?, applicationVersion: UInt32?, manufacturer: Manufacturer?, dataIndex: UInt8?) {
        self.developerId = developerId
        self.applicationId = applicationId
        self.applicationVersion = applicationVersion
        self.manufacturer = manufacturer
        self.dataIndex = dataIndex
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> DeveloperDataIdMessage  {

        var developerId: Data?
        var applicationId: Data?
        var applicationVersion: UInt32?
        var manufacturer: Manufacturer?
        var dataIndex: UInt8?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .developerId:
                    let value = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(value.count) != definition.baseType.invalid {
                        developerId = value
                    }

                case .applicationId:
                    let value = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(value.count) != definition.baseType.invalid {
                        applicationId = value
                    }

                case .manufacturerId:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        manufacturer = Manufacturer.company(id: value)
                    }

                case .dataIndex:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        dataIndex = value
                    }

                case .applicationVersion:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        applicationVersion = value
                    }

                }
            }
        }

        return DeveloperDataIdMessage(developerId: developerId,
                                      applicationId: applicationId,
                                      applicationVersion: applicationVersion,
                                      manufacturer: manufacturer,
                                      dataIndex: dataIndex)
    }
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension DeveloperDataIdMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    public enum MessageKeys: Int, CodingKey {
        case developerId        = 0
        case applicationId      = 1
        case manufacturerId     = 2
        case dataIndex          = 3
        case applicationVersion = 4
    }
}
