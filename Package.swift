// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MusicStaffView",
    platforms: [.iOS(.v13), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MusicStaffView",
            targets: ["MusicStaffView"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "git@github.com:mmuszynski/Music.git", from: "1.0.0"),
        .package(url: "git@bitbucket.org:mmuszynski/svgparser.git", from: "0.0.0")
        //.package(name: "Music", url: "git@github.com:mmuszynski/Music.git", from: Version("1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MusicStaffView",
            dependencies: [
                .product(name: "Music", package: "Music"),
                .product(name: "SVGParser", package: "svgparser")
            ],
            resources: [.process("Music Fonts/"),
                        .process("Images/")],
            swiftSettings: [.enableUpcomingFeature("StrictConcurrency")]
        ),
        .testTarget(
            name: "MusicStaffViewTests",
            dependencies: ["MusicStaffView"]),
    ]
)
