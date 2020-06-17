import Foundation

/// The location and dimensions of a rectangle.
public struct Rect {
    /// A point that specifies the coordinates of the rectangle’s origin.
    public var origin: Point
    /// A size that specifies the height and width of the rectangle.
    public var size: Size
    
    public init() {
        origin = .zero
        size = .zero
    }
    
    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    public init(x: Float, y: Float, width: Float, height: Float) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

// MARK: - CustomStringConvertible
extension Rect: CustomStringConvertible {
    public var description: String {
        return "Rect(origin: \(origin), size: \(size))"
    }
}

// MARK: - Equatable
extension Rect: Equatable {
}

// MARK: - Static References
public extension Rect {
    static let nan: Rect = Rect(origin: .nan, size: .nan)
    static let zero: Rect = Rect(origin: .zero, size: .zero)
}

// MARK: - Convenience Accessors
public extension Rect {
    /// The x-coordinate of the rectangle origin
    var x: Float {
        return origin.x
    }
    
    /// The y-coordinate of the rectangle origin
    var y: Float {
        return origin.y
    }
    
    /// The width of the rectangle.
    var width: Float {
        return size.width
    }
    
    /// The height of the rectangle.
    var height: Float {
        return size.height
    }
    
    var center: Point {
        return Point(x: midX, y: midY)
    }
    
    /// The smallest value for the x-coordinate of the rectangle.
    var minX: Float {
        if size.width < 0.0 {
            return origin.x - abs(size.width)
        }
        
        return origin.x
    }
    
    /// The x-coordinate that establishes the center of a rectangle.
    var midX: Float {
        return minX + size.xRadius
    }
    
    /// The largest value of the x-coordinate for the rectangle.
    var maxX: Float {
        if size.width < 0.0 {
           return origin.x
        }
        
        return origin.x + size.width
    }
    
    /// The smallest value for the y-coordinate of the rectangle.
    var minY: Float {
        if size.height < 0.0 {
            return origin.y - abs(size.height)
        }
        
        return origin.y
    }
    
    /// The y-coordinate that establishes the center of the rectangle.
    var midY: Float {
        return minY + size.yRadius
    }
    
    /// The largest value for the y-coordinate of the rectangle.
    var maxY: Float {
        if size.height < 0.0 {
            return origin.y
        }
        
        return origin.y + size.height
    }
}

// MARK: - Instance Functionality
@available(*, deprecated, message: "This steps beyond the initial intent of the library. See https://github.com/richardpiazza/GraphPoint")
public extension Rect {
    /// AKA, the center of the Rect.
    var cartesianOrigin: Point {
        return center
    }
    
    /// Translates the provided point within the `Rect` from using the top-left
    /// as the _origin_, to using the center as the _origin_.
    ///
    /// For example: Given `Rect(x: 0, y: 0, width: 100, height: 100)`, the point
    /// `Point(x: 25, y: 25)` would translate to `Point(x: -25, y: 25)`.
    func cartesianPoint(for point: Point) -> Point {
        var cartesianPoint: Point = .zero
        
        if point.x < center.x {
            cartesianPoint.x = -(center.x - point.x)
        } else if point.x > center.x {
            cartesianPoint.x = point.x - center.x
        }
        
        if point.y > center.y {
            cartesianPoint.y = -(point.y - center.y)
        } else if point.y < center.y {
            cartesianPoint.y = center.y - point.y
        }
        
        return cartesianPoint
    }
}
