//
//  RecordHeader.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation
import DataDecoder


internal struct RecordHeader {

    private(set) var localMessageType: UInt8

    private(set) var isDataMessage: Bool

    private(set) var developerData: Bool
}


internal extension RecordHeader {

    internal static func decode(decoder: inout DataDecoder) throws -> RecordHeader {

        let header = decoder.decodeUInt8()

        var isDataMessage = false
        var developerData = false
        var messageType: UInt8 = 0

        if (header & 0x80 == 0x80) {
            print("Timestamp")

            messageType = header & 0x60 >> 5
            //let timeoffset = header & 0x1F

        } else {
            print("Normal header")

            if (header & 0x40 == 0x40) {
                print("Definition Message")

                if header & 0x20 == 0x20 {
                    developerData = true
                }

            } else {
                print("Data Message")
                isDataMessage = true
            }

            messageType = header & 0x1F

        }

        return RecordHeader(localMessageType: messageType,
                            isDataMessage: isDataMessage,
                            developerData: developerData)
    }
}
