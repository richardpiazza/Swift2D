import Foundation

/// A structure that contains width and height values.
public struct Size {
    public var width: Float
    public var height: Float
    
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
        return String(format: "Size(width: %.5f, height: %.5f)", width, height)
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
    var xRadius: Float {
        return width / 2.0
    }
    
    var yRadius: Float {
        return height / 2.0
    }
    
    var maxRadius: Float {
        return max(xRadius, yRadius)
    }
    
    var minRadius: Float {
        return min(xRadius, yRadius)
    }
    
    var center: Point {
        return Point(x: xRadius, y: yRadius)
    }
}
