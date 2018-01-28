//
//  FitMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
//

import Foundation
import DataDecoder

public protocol FitMessageKeys {
    associatedtype FitCodingKeys: CodingKey
}

/// Base Class for FIT Messages
open class FitMessage {

    public required init() {}

    func globalMessageNumber() -> UInt16 {
        fatalError("*** You must override in your class.")
    }

    internal func decode(fieldData: Data, definition: DefinitionMessage) throws -> Self  {
        fatalError("*** You must override in your class.")
    }

}
