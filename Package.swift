// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "GraphQLAndVaporBeta",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/alexsteinerde/graphql-kit.git", from: "2.0.0-beta"),
        .package(url: "https://github.com/alexsteinerde/graphiql-vapor.git", from: "2.0.0-beta"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "Vapor",
            "GraphQLKit",
            "GraphiQLVapor"
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
