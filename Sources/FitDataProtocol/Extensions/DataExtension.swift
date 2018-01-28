//
//  DataExtension.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/20/18.
//

import Foundation


extension Data {

    /// Smartly Decodes String
    var smartString: String? {
        var stringvalue: String?

        if self[(self.count - 1)] == 0 {
            stringvalue = String(bytes: self[0..<(self.count - 1)], encoding: .utf8)
        } else {
            stringvalue = String(bytes: self[0..<(self.count - 1)], encoding: .ascii)
        }

        return stringvalue
    }

    /// Provide Segments of the Data
    ///
    /// - Parameters:
    ///   - size: Size of the Segments
    /// - Returns: Array of Segmented Data
    func segment(size _size: Int, offset: Int = 0) -> [Data] {

        var messages: [Data] = [Data]()

        let myData = self
        let length = self.count
        var internalOffset = offset

        repeat {

            let thisChuckSize = length - internalOffset > _size ? _size : length - internalOffset

            let chunk = myData.subdata(in: Range(internalOffset..<(internalOffset + thisChuckSize)))

            internalOffset = internalOffset + thisChuckSize

            messages.append(chunk)

        } while (internalOffset < length)

        return messages
    }

}
