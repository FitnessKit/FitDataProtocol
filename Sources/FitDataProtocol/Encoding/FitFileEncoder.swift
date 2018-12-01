//
//  FitFileEncoder.swift
//  FitDataProtocol
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

/// FIT File Encoder
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct FitFileEncoder {

    /// Options for Validity Strategy
    public enum ValidityStrategy {
        /// The default strategy assumes you know what type of Messages should be
        /// included with each type of file.
        case none
        /// File Type Checking
        ///
        /// This will check to make sure you have the correct Messages include for
        /// the file type indicated in the FileIdMessage.
        case fileType
        /// Garmin Connect Activity
        ///
        /// Garmin Connect reqiures some extra Messages in the Activity file type
        /// in order for it to be uploaded.
        case garminConnect
    }

    /// The strategy to use for Data Validity Strategy. Defaults to `.none`.
    public var dataValidityStrategy: ValidityStrategy

    public init(dataValidityStrategy: ValidityStrategy = .none) {
        self.dataValidityStrategy = dataValidityStrategy
    }
}

public extension FitFileEncoder {

    /// Encode FITFile
    ///
    /// - Parameters:
    ///   - fildIdMessage: FileID Message
    ///   - messages: Array of other FitMessages
    /// - Returns: Encoded Data
    /// - Throws: FitError
    public func encode(fildIdMessage: FileIdMessage, messages: [FitMessage]) throws -> Data {

        guard messages.count > 0 else {
            throw FitError(.encodeError(msg: "No Messages to Encode"))
        }

        var msgData = Data()

        try validate(fildIdMessage: fildIdMessage, messages: messages)

        msgData.append(try fildIdMessage.encode(fileType: fildIdMessage.fileType, dataValidityStrategy: dataValidityStrategy))

        for message in messages {

            if message is FileIdMessage {
                throw FitError(.encodeError(msg: "messages can not contain second FileIdMessage"))
            }

            msgData.append(try message.encode(fileType: fildIdMessage.fileType, dataValidityStrategy: dataValidityStrategy))
        }

        if msgData.count > UInt32.max {
            throw FitError(.encodeError(msg: "Fit File has to many Messages. Can only encode \(UInt32.max) bytes"))
        }

        let dataCrc = CRC16(data: msgData).crc
        msgData.append(Data(from:dataCrc.littleEndian))

        let header = FileHeader(dataSize: UInt32(msgData.count))

        var fileData = Data()
        fileData.append(header.encodedData)
        fileData.append(msgData)

        return fileData
    }

}

private extension FitFileEncoder {

    private func validate(fildIdMessage: FileIdMessage, messages: [FitMessage]) throws {

        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:

            guard let fileType = fildIdMessage.fileType else {
                throw FitError(.encodeError(msg: "File Type should not be nil"))
            }

            if fileType == FileType.activity {
                try validateActivity(fildIdMessage: fildIdMessage, messages: messages, isGarmin: false)
            }


        case .garminConnect:
            guard fildIdMessage.fileType != nil else {
                throw FitError(.encodeError(msg: "File Type should not be nil"))
            }

            try validateActivity(fildIdMessage: fildIdMessage, messages: messages, isGarmin: true)
            try validateGarminConnect(fildIdMessage: fildIdMessage, messages: messages)
        }
    }


    private func validateActivity(fildIdMessage: FileIdMessage, messages: [FitMessage], isGarmin: Bool) throws {
        //An activity file shall contain file_id, activity, session, and lap messages

        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"

        /// this should have already been established
        guard fildIdMessage.fileType == FileType.activity else {
            throw FitError(.encodeError(msg: "\(msg) require FileType.activity"))
        }

        guard fildIdMessage.manufacturer != nil else {
            throw FitError(.encodeError(msg: "\(msg) require FileIdMessage to contain Manufacturer, can not be nil"))
        }

        guard fildIdMessage.product != nil else {
            throw FitError(.encodeError(msg: "\(msg) require FileIdMessage to contain product, can not be nil"))
        }

        guard fildIdMessage.deviceSerialNumber != nil else {
            throw FitError(.encodeError(msg: "\(msg) require FileIdMessage to contain deviceSerialNumber, can not be nil"))
        }

        guard fildIdMessage.fileCreationDate != nil else {
            throw FitError(.encodeError(msg: "\(msg) require FileIdMessage to contain fileCreationDate, can not be nil"))
        }

        if containsMessage(SessionMessage.self, messages: messages) == false {
            throw FitError(.encodeError(msg: "\(msg) require SessionMessage"))
        }

        if containsMessage(ActivityMessage.self, messages: messages) == false {
            throw FitError(.encodeError(msg: "\(msg) require ActivityMessage"))
        }

    }

    private func validateGarminConnect(fildIdMessage: FileIdMessage, messages: [FitMessage]) throws {

        /// Garmin Connect Requires
        /// - File type == 4 Activity
        /// - DeviceInfo message
        /// - Record messages
        /// - Lap Message ( however we know it works without)
        /// - Session message - 1 Only
        /// - Activity Message

        if containsMessage(DeviceInfoMessage.self, messages: messages) == false {
            throw FitError(.encodeError(msg: "Garmin Connect requires DeviceInfoMessage"))
        }

        if containsMessage(RecordMessage.self, messages: messages) == false {
            throw FitError(.encodeError(msg: "Garmin Connect requires RecordMessage"))
        }

        if countMessages(SessionMessage.self, messages: messages) != 1 {
            throw FitError(.encodeError(msg: "Garmin Connect requires 1 Session Message"))
        }

    }
}

extension FitFileEncoder {

    /// Count of Message Types in the Message Array
    ///
    /// - Parameters:
    ///   - msgType: FitMessage Type
    ///   - messages: FitMessages
    /// - Returns: Count of msgType
    func countMessages(_ msgType: FitMessage.Type, messages: [FitMessage]) -> Int {

        let count = messages.reduce(0) { (total: Int, message: FitMessage) -> Int in

            if type(of: message).globalMessageNumber() == msgType.globalMessageNumber() {
                return total + 1
            }

            return total
        }

        return count
    }

    /// Checks if Array Contains a FitMessage Type
    ///
    /// - Parameters:
    ///   - msgType: FitMessage Type
    ///   - messages: FitMessages
    /// - Returns: True if msgType is contained in array
    func containsMessage(_ msgType: FitMessage.Type, messages: [FitMessage]) -> Bool {

        if messages.contains(where: { (fitmessage) -> Bool in

            if type(of: fitmessage).globalMessageNumber() == msgType.globalMessageNumber() {
                return true
            }
            return false
        }) {
            return true
        }

        return false
    }
}

//1.    file_id – This message must be first. It must contain serial_number, time_created, manufacturer and type fields.
//Type must equal 4 (ACTIVITY). The manufacturer field should be populated with the correct partner identifier
//from the FIT SDK.
//2.    device_info – The file must contain at least one of these, with information about the device/application that
//created the FIT file. Possible fields to provide include serial_number, manufacturer and software_version.
//3.    record – These represent instantaneous data measurements. The file should contain one per second, if possible.
//4.    lap – These represent laps or intervals within the activity. The activity must contain at least one (which would
//represent the entire activity) but will likely contain many representing various time or distance splits, or sections
//within the workout such as work or rest intervals. These will be interspersed throughout the file at the END of
//the lap or interval. They contain summary measurements (average speed, lap distance, etc) for their respective
//    portions of the activity.
//5.    session – This message will appear in the file exactly once, at the end of the workout. It represents the entire
//workout. It is very much like a lap message. Multisport activities (triathlon, duathlon, etc) can contain multiple
//sessions within a single FIT activity file. The session message should be populated with the appropriate Sport
//and Subsport values to identify the type of activity represented in the data (cycling, running, swimming, etc). If
//the partner application simulates GPS data and records it to the FIT file, the Subsport value must be set to
//“virtual activity”. For applications that do not record simulated GPS data, “treadmill running”, “indoor cycling”,
//“indoor rowing” or other Subsport options may be more appropriate. Partner applications should pick the most
//specific possible Sport/Subsport pair available.
//6.    activity – This message will appear at the end of the file.
