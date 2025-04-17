// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GoogleAuthLib",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "GoogleAuthLib",
            targets: ["GoogleAuthLib"]),
    ],
    dependencies: [
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "GoogleAuthLib",
            dependencies: [
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS")
            ],
            path: "GoogleAuthLib"
        ),
    ]
) 
