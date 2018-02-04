//
//  DeviceIndex.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/4/18.
//

import Foundation


/// Device Index
public struct DeviceIndex {

    /// Is File Creator
    public let isFileCreator: Bool

    /// Validity of Index
    public let isInvalid: Bool

    /// Index
    public let index: UInt8

    public init(isCreator: Bool) {
        self.isFileCreator = true
        self.isInvalid = false
        self.index = 0
    }

    public init(index: UInt8) {
        self.index = index

        if index == 0 {
            self.isFileCreator = true
        } else {
            self.isFileCreator = false
        }

        if index == 255 {
            self.isInvalid = true
        } else {
            self.isInvalid = false
        }
    }
}
