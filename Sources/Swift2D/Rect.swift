import Foundation

/// A structure that contains the location and dimensions of a rectangle.
public struct Rect {
    public var origin: Point
    public var size: Size
    
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
        return "Rect(origin: \(origin.description), size: \(size.description))"
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

// MARK: - Instance Functionality
public extension Rect {
    /// AKA, the center of the Rect.
    var cartesianOrigin: Point {
        return Point(x: size.width / 2.0, y: size.height / 2.0)
    }
    
    /// Translates the provided point within the `Rect` from using the top-left
    /// as the _origin_, to using the center as the _origin_.
    ///
    /// For example: Given `Rect(x: 0, y: 0, width: 100, height: 100)`, the point
    /// `Point(x: 25, y: 25)` would translate to `Point(x: -25, y: 25)`.
    func cartesianPoint(for point: Point) -> Point {
        let origin = cartesianOrigin
        var cartesianPoint: Point = .zero
        
        if point.x < origin.x {
            cartesianPoint.x = -(origin.x - point.x)
        } else if point.x > origin.x {
            cartesianPoint.x = point.x - origin.x
        }
        
        if point.y > origin.y {
            cartesianPoint.y = -(point.y - origin.y)
        } else if point.y < origin.y {
            cartesianPoint.y = origin.y - point.y
        }
        
        return cartesianPoint
    }
}
