// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServiceLocatorService",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ServiceLocatorService",
            targets: ["ServiceLocatorService"]),
        .plugin(name: "FindNotImplementedServices", targets: ["FindNotImplementedServices"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ServiceLocatorService",
            dependencies: []),
        .testTarget(
            name: "ServiceLocatorTests",
            dependencies: ["ServiceLocatorService"]),
        .plugin(
            name: "FindNotImplementedServices", capability: .command(
                intent: .custom(
                    verb: "regenerate-not-implemented-services",
                    description: "Generate NotImplemented.txt file based on git log"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "This command write the new CONTRIBUTORS.txt to the source root")
                ]
            )
        )
    ]
    
)
