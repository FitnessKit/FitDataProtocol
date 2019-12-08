//
//  EncoderValidator.swift
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

/// File Type Validator Protocol
internal protocol EncoderFileTypeValidator {
    static func validate(fildIdMessage: FileIdMessage, messages: [FitMessage], dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<Bool, FitEncodingError>
}

/// Encoder Validator
internal struct EncoderValidator: EncoderFileTypeValidator {
    
    static func validate(fildIdMessage: FileIdMessage, messages: [FitMessage], dataValidityStrategy: FitFileEncoder.ValidityStrategy) ->  Result<Bool, FitEncodingError> {
        
        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:
            
            guard let fileType = fildIdMessage.fileType else {
                return.failure(FitEncodingError.fileType("File Type should not be nil"))
            }
            
            switch fileType {
            case FileType.activity:
                let result = validateActivity(fildIdMessage: fildIdMessage, messages: messages, isGarmin: false)
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    return Result.failure(error)
                }
                
            case FileType.workout:
                let result = WorkoutFileEncoderValidator.validate(fildIdMessage: fildIdMessage,
                                                                  messages: messages,
                                                                  dataValidityStrategy: dataValidityStrategy)
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    return Result.failure(error)
                }
                
            case FileType.goals:
                let result = GoalsFileEncoderValidator.validate(fildIdMessage: fildIdMessage,
                                                                messages: messages,
                                                                dataValidityStrategy: dataValidityStrategy)
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    return Result.failure(error)
                }
                
            default:
                break
            }
            
        case .garminConnect:
            guard fildIdMessage.fileType != nil else {
                return.failure(FitEncodingError.fileType("File Type should not be nil"))
            }
            
            let activity = validateActivity(fildIdMessage: fildIdMessage, messages: messages, isGarmin: true)
            switch activity {
            case .success(_):
                break
            case .failure(let error):
                return Result.failure(error)
            }
            
            let garmin = GarminConnectFileEncoderValidator.validate(fildIdMessage: fildIdMessage,
                                                                    messages: messages,
                                                                    dataValidityStrategy: dataValidityStrategy)
            switch garmin {
            case .success(_):
                break
            case .failure(let error):
                return Result.failure(error)
            }
            
        }
        
        return.success(true)
    }
}


private extension EncoderValidator {
    
    static func validateActivity(fildIdMessage: FileIdMessage, messages: [FitMessage], isGarmin: Bool) -> Result<Bool, FitEncodingError> {
        //An activity file shall contain file_id, activity, session, and lap messages
        
        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"
        
        /// this should have already been established
        guard fildIdMessage.fileType == FileType.activity else {
            return.failure(FitEncodingError.fileType("\(msg) require FileType.activity"))
        }
        
        guard fildIdMessage.manufacturer != nil else {
            return.failure(FitEncodingError.fileType("\(msg) require FileIdMessage to contain Manufacturer, can not be nil"))
        }
        
        guard fildIdMessage.product != nil else {
            return.failure(FitEncodingError.fileType("\(msg) require FileIdMessage to contain product, can not be nil"))
        }
        
        guard fildIdMessage.deviceSerialNumber != nil else {
            return.failure(FitEncodingError.fileType("\(msg) require FileIdMessage to contain deviceSerialNumber, can not be nil"))
        }
        
        guard fildIdMessage.fileCreationDate != nil else {
            return.failure(FitEncodingError.fileType("\(msg) require FileIdMessage to contain fileCreationDate, can not be nil"))
        }
        
        if containsMessage(SessionMessage.self, messages: messages) == false {
            return.failure(FitEncodingError.fileType("\(msg) require SessionMessage"))
        }
        
        if containsMessage(ActivityMessage.self, messages: messages) == false {
            return.failure(FitEncodingError.fileType("\(msg) require ActivityMessage"))
        }
        
        return.success(true)
    }
    
}

internal extension EncoderFileTypeValidator {
    
    /// Count of Message Types in the Message Array
    ///
    /// - Parameters:
    ///   - msgType: FitMessage Type
    ///   - messages: FitMessages
    /// - Returns: Count of msgType
    static func countMessages(_ msgType: FitMessage.Type, messages: [FitMessage]) -> Int {
        
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
    static func containsMessage(_ msgType: FitMessage.Type, messages: [FitMessage]) -> Bool {
        
        if messages.contains(where: { (fitmessage) -> Bool in
            type(of: fitmessage).globalMessageNumber() == msgType.globalMessageNumber()
        }) {
            return true
        }
        
        return false
    }
}
