//
//  GoalsFileEncoderValidator.swift
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

/// Goals File Validator
internal struct GoalsFileEncoderValidator: EncoderFileTypeValidator {    
    
    static func validate(fildIdMessage: FileIdMessage, messages: [FitMessage], dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<Bool, FitEncodingError> {
        //Goals file shall contain file_id, workout, and workout_step

        let msg = "Goals Files"

        /// this should have already been established
        guard fildIdMessage.fileType == FileType.goals else {
            return.failure(FitEncodingError.fileType("\(msg) require FileType.goals"))
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

        if EncoderValidator.containsMessage(GoalMessage.self, messages: messages) == false {
            return.failure(FitEncodingError.fileType("\(msg) require GoalMessage"))
        }
        
        return.success(true)
    }
}
