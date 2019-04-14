// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FitDataProtocol",
    //platforms: [.iOS("10.0"), .macOS("10.12"), .tvOS("10.0"), .watchOS("3.0")],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FitDataProtocol",
            targets: ["FitDataProtocol"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/FitnessKit/FitnessUnits", from: "2.1.4"),
        .package(url: "https://github.com/FitnessKit/DataDecoder", from: "4.4.0"),
        .package(url: "https://github.com/FitnessKit/AntMessageProtocol", from: "0.3.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FitDataProtocol",
            dependencies: [
                "FitnessUnits",
                "DataDecoder",
                "AntMessageProtocol"
                ]
        ),
        .testTarget(
            name: "FitDataProtocolTests",
            dependencies: ["FitDataProtocol"]),
    ]
)

