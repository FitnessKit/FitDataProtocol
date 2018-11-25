//
//  ExerciseTitleMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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
import FitnessUnits

/// FIT Exercise Title Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ExerciseTitleMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 264
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Workout Step Name
    private(set) public var stepName: String?

    /// Exercise Category
    private(set) public var category: ExerciseCategory?

    /// Exercise Name
    private(set) public var exerciseName: ExerciseNameType?

    public required init() {}

    public init(messageIndex: MessageIndex?,
                stepName: String?,
                category: ExerciseCategory?,
                exerciseName: ExerciseNameType?) {
        
        self.messageIndex = messageIndex
        self.stepName = stepName
        self.category = category
        self.exerciseName = exerciseName
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> ExerciseTitleMessage  {

        var messageIndex: MessageIndex?

        var stepName: String?
        var category: ExerciseCategory?
        var exerciseName: ExerciseNameType?

        var exerciseNumber: UInt16?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ExerciseTitleMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .category:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        category = ExerciseCategory(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            category = ExerciseCategory.invalid
                        }
                    }

                case .exerciseName:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        exerciseNumber = value
                    }

                case .stepName:
                    stepName = String.decode(decoder: &localDecoder,
                                             definition: definition,
                                             data: fieldData,
                                             dataStrategy: dataStrategy)

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        if let exerciseNumber = exerciseNumber {
            exerciseName = category?.exerciseName(from: exerciseNumber)
        }

        return ExerciseTitleMessage(messageIndex: messageIndex,
                                    stepName: stepName,
                                    category: category,
                                    exerciseName: exerciseName)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode() throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .category:
                if let category = category {
                    msgData.append(Data(from: category.rawValue.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .exerciseName:
                if let exerciseName = exerciseName {
                    msgData.append(Data(from: exerciseName.number.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .stepName:
                if let stepName = stepName {
                    if let stringData = stepName.data(using: .utf8) {
                        msgData.append(stringData)

                        //200 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ExerciseTitleMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            var encodedMsg = Data()

            let defHeader = RecordHeader(localMessageType: 0, isDataMessage: false)
            encodedMsg.append(defHeader.normalHeader)
            encodedMsg.append(defMessage.encode())

            let recHeader = RecordHeader(localMessageType: 0, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "ExerciseTitleMessage contains no Properties Available to Encode"))
        }
    }

}
