<img src="Swift2D.png" width="512" max-width="90%" alt="Swift2D" />

Swift library for working in two-dimensional coordinate systems.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frichardpiazza%2FSwift2D%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/richardpiazza/Swift2D)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frichardpiazza%2FSwift2D%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/richardpiazza/Swift2D)

## Features

This library provides structs for `Point`, `Size`, and `Rect` based on the swift standard library. No `Foundation` or `CoreGraphics` imports are required.

### Point

```swift
struct Point {
  var x: Double
  var y: Double
}
```

### Size

```swift
struct Size {
  var width: Double
  var height: Double
}
```

### Rect

```swift
struct Rect {
  var origin: Point
  var size: Size
}
```

## Installation

This package is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/richardpiazza/Swift2D.git", from: "2.1.0")
    ],
    ...
)
```

Then import the **Swift2D** packages wherever you'd like to use it:

```swift
import Swift2D
```
