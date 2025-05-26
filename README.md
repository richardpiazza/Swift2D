<img src="Swift2D.png" width="512" max-width="90%" alt="Swift2D" />

Swift library for working in two-dimensional coordinate systems.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frichardpiazza%2FSwift2D%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/richardpiazza/Swift2D)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frichardpiazza%2FSwift2D%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/richardpiazza/Swift2D)

## Features

This library provides structs for `Point`, `Size`, and `Rect` based on the swift standard library. No `Foundation` or `CoreGraphics` imports are required.

Most of this work is taken from the [swift-corelibs-foundation](https://github.com/swiftlang/swift-corelibs-foundation/blob/cac38ff51cd4a120387afb02f065c3f86fcfd42a/Sources/Foundation/NSGeometry.swift) implementation.

### Point

```swift
struct Point {
  let x: Double
  let y: Double
}
```

`Point` also has accessors for:

```swift
extension Point {
  var description: String
  var isZero: Bool
  var isNaN: Bool
  func x(_:) -> Point
  func y(_:) -> Point
  func reflecting(around:) -> Point
}
```

### Size

```swift
struct Size {
  let width: Double
  let height: Double
}
```

Additional computed properties and functions of `Size`:

```swift
extension Size {
  var description: String
  var isZero: Bool
  var isNaN: Bool
  var widthRadius: Double
  var heightRadius: Double
  var maxRadius: Double
  var minRadius: Double
  var center: Point
  func width(_:) -> Size
  func height(_:) -> Size
}
```

### Rect

```swift
struct Rect {
  let origin: Point
  let size: Size
}
```

The `Rect` type has many additional properties:
```swift
extension Rect {
  var description: String
  var isZero: Bool
  var isNaN: Bool
  var isInfinite: Bool
  var isNull: Bool
  var isEmpty: Bool
  var x: Double
  var y: Double
  var width: Double
  var height: Double
  var center: Point
  var minX: Double
  var midX: Double
  var maxX: Double
  var minY: Double
  var midY: Double
  var maxY: Double
  var standardized: Rect
  func origin(_:) -> Rect
  func size(_:) -> Rect
  func contains(_: Point) -> Bool
  func contains(_: Rect) -> Bool
  func intersects(_: Rect) -> Bool
  func intersection(_: Rect) -> Rect
  func union(_: Rect) -> Rect
  func offsetBy(dx:dy:) -> Rect
  func insetBy(dx:dy:) -> Rect
  func expandedBy(dx:dy:) -> Rect
}
```
