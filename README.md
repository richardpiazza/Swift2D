# Swift2D

Swift library for working in two-dimensional coordinate systems.

<p>
  <img src="https://github.com/richardpiazza/Swift2D/workflows/Swift/badge.svg?branch=main" />
  <img src="https://img.shields.io/badge/Swift-5.2-orange.svg" />
  <a href="https://twitter.com/richardpiazza">
    <img src="https://img.shields.io/badge/twitter-@richardpiazza-blue.svg?style=flat" alt="Twitter: @richardpiazza" />
  </a>
</p>

## Usage

Swift2D is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/richardpiazza/Swift2D.git", from: "1.1.0")
    ],
    ...
)
```

Then import the **Swift2D** packages wherever you'd like to use it:

```swift
import Swift2D
```

## Features

This library provides structs for `Point`, `Size`, and `Rect` based on the swift standard library. No `Foundation` or `CoreGraphics` imports are required.
