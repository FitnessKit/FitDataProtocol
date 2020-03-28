# FitDataProtocol

[![Swift5.2](https://img.shields.io/badge/swift5.2-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/FitDataProtocol.svg?style=flat)](http://cocoapods.org/pods/FitDataProtocol)
[![License](https://img.shields.io/cocoapods/l/FitDataProtocol.svg?style=flat)](http://cocoapods.org/pods/FitDataProtocol)
[![Platform](https://img.shields.io/cocoapods/p/FitDataProtocol.svg?style=flat)](http://cocoapods.org/pods/FitDataProtocol)

Swift Version of the Garmin Flexible and Interoperable Data Transfer Protocol.

Supports SDK Revision 21.16.0

## Installation

FitDataProtocol is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'FitDataProtocol'
```

Swift Package Manager:
```swift
    dependencies: [
        .package(url: "https://github.com/FitnessKit/FitDataProtocol", from: "2.1.0")
    ]
```

Swift4
```swift
    dependencies: [
        .package(url: "https://github.com/FitnessKit/FitDataProtocol", .branch("swift42")),
    ]
```

## How to Use


### Decoding FIT Files

```
let fileUrl = URL(fileURLWithPath: "WeightScaleMultiUser" + ".fit")
let fileData = try? Data(contentsOf: fileUrl)

if let fileData = fileData {
    var decoder = FitFileDecoder(crcCheckingStrategy: .throws)

    do {

        try decoder.decode(data: fileData,
                       messages: FitFileDecoder.defaultMessages,
            decoded: { (message: FitMessage) in

                print("Got Message: \(message)")

                if let message = message as? FileIdMessage {
                    print("mssage", message.deviceSerialNumber)
                }

                if let message = message as? RecordMessage {
                    records.append(message)
                }

                if let message = message as? SportMessage {
                    sports.append(message)
                }

                if let message = message as? ActivityMessage {
                    activity.append(message)
                }
        })

    } catch {
        print(error)
    }
}
```

### Encoding FIT Files

As part of the Encoding of the FIT Files you can check for Validity of the data you are encoding.

The options are

* none - No Validity Checks are done
* fileType - Based on the File Type, checks will be done to insure correct fields are included
* garminConnect - Special Check for creating FIT files for GarminConnect

Example:
```
let activity = ActivityMessage(timeStamp: FitTime(date: Date()),
                               totalTimerTime: nil,
                               localTimeStamp: nil,
                               numberOfSessions: nil,
                               activity: Activity.multisport,
                               event: nil,
                               eventType: nil,
                               eventGroup: nil)


let fieldId = FileIdMessage(deviceSerialNumber: nil,
                            fileCreationDate: time,
                            manufacturer: Manufacturer.garmin,
                            product: nil,
                            fileNumber: nil,
                            fileType: FileType.activity,
                            productName: nil)

let encoder = FitFileEncoder(dataValidityStrategy: .none)

let result = encoder.encode(fildIdMessage: fiel, messages: [activity])
switch result {
case .success(let encodedData):
    print(encodedData as NSData)
    /// you can save off the file data
case .failure(let error):
    print(error.localizedDescription)
}

///
/// You can still use doCatch 
///
do {
    let encoder = FitFileEncoder(dataValidityStrategy: .none)

    let data = try encoder.encode(fildIdMessage: fieldId, messages: [activity]).get()
    print(data as NSData)

    /// you can save off the file data

} catch  {
    print(error)
}
```

## Author

This package is developed and maintained by Kevin A. Hoogheem

## License

FitDataProtocol is available under the [MIT license](http://opensource.org/licenses/MIT)
