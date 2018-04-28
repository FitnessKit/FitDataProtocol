# FitDataProtocol

[![Swift4](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/FitDataProtocol.svg?style=flat)](http://cocoapods.org/pods/FitDataProtocol)
[![License](https://img.shields.io/cocoapods/l/FitDataProtocol.svg?style=flat)](http://cocoapods.org/pods/FitDataProtocol)
[![Platform](https://img.shields.io/cocoapods/p/FitDataProtocol.svg?style=flat)](http://cocoapods.org/pods/FitDataProtocol)

Swift Version of the Garmin Flexible and Interoperable Data Transfer Protocol.

Supports Revision 2.3

## Installation

FitDataProtocol is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'FitDataProtocol'
```

Swift Package Manager:
```swift
    dependencies: [
        .Package(url: "https://github.com/FitnessKit/FitDataProtocol", from: 0.10.0)
    ]
```
## How to Use

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

                if message is FileIdMessage {
                    let message = message as! FileIdMessage
                    print("mssage", message.deviceSerialNumber)
                }

                if message is RecordMessage {
                    let message = message as! RecordMessage
                    records.append(message)
                }

                if message is SportMessage {
                    let message = message as! SportMessage
                    sports.append(message)
                }

                if message is ActivityMessage {
                    let message = message as! ActivityMessage
                    activity.append(message)
                }
        })

    } catch {
        print(error)
    }
}
```

## Author

Kevin A. Hoogheem

## License

FitDataProtocol is available under the MIT license. See the LICENSE file for more info.
