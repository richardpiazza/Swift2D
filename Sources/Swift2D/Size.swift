import Foundation

/// A representation of two-dimensional width and height values.
public struct Size {
    public var width: Float
    public var height: Float
    
    public init() {
        width = 0.0
        height = 0.0
    }
    
    public init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    public init(width: Int, height: Int) {
        self.width = Float(width)
        self.height = Float(height)
    }
}

// MARK: - CustomStringConvertible
extension Size: CustomStringConvertible {
    public var description: String {
        return "Size(width: \(width), height: \(height))"
    }
}

// MARK: - Equatable
extension Size: Equatable {
}

// MARK: - Static References
public extension Size {
    static let nan: Size = Size(width: .nan, height: .nan)
    static let zero: Size = Size(width: 0.0, height: 0.0)
}

// MARK: - Instance Functionality
public extension Size {
    /// The horizontal radius (½ of `width`)
    var xRadius: Float {
        return abs(width) / 2.0
    }
    
    /// The vertical radius (½ of `height`)
    var yRadius: Float {
        return abs(height) / 2.0
    }
    
    /// The largest radius, out of `xRadius` & `yRadius`.
    var maxRadius: Float {
        return max(xRadius, yRadius)
    }
    
    /// The smallest radius, out of `xRadius` & `yRadius`.
    var minRadius: Float {
        return min(xRadius, yRadius)
    }
    
    /// The `Point` at which the `xRadius` & `yRadius` intersect.
    var center: Point {
        return Point(x: xRadius, y: yRadius)
    }
}
