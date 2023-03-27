// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtensionHelper6",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ExtensionHelper6",
            targets: ["ExtensionHelper6"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/danha1998/ExtensionHelper6", from: "1.0.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ExtensionHelper6",
            dependencies: []),
        .testTarget(
            name: "ExtensionHelper6Tests",
            dependencies: ["ExtensionHelper6"]),
    ]
)
