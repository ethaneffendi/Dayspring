// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Dayspring",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Dayspring",
            targets: ["AppModule"],
            bundleIdentifier: "com.Eth.Slide.WWDC24",
            teamIdentifier: "SG2HPZ7TCD",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.orange),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .camera(purposeString: "Do you consent to this app using your iPhone's camera? "),
                .motion(purposeString: "Do you consent to this app using your iPhone's pedometer (\"step counter\")?")
            ],
            appCategory: .healthcareFitness
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .copy("Models")
            ]
        )
    ]
)