// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swift2D",
    platforms: [
        .macOS(.v13),
        .macCatalyst(.v16),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Swift2D",
            targets: ["Swift2D"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-testing", from: "6.2.0"),
    ],
    targets: [
        .target(
            name: "Swift2D",
            dependencies: []
        ),
        .testTarget(
            name: "Swift2DTests",
            dependencies: [
                "Swift2D",
                .product(name: "Testing", package: "swift-testing"),
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)

for target in package.targets {
    var settings = target.swiftSettings ?? []
    settings.append(contentsOf: [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("StrictConcurrency=complete"),
    ])
    target.swiftSettings = settings
}
