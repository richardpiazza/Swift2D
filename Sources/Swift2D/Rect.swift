/// The location and dimensions of a rectangle.
public struct Rect {
    
    /// A point that specifies the coordinates of the rectangle’s origin.
    public var origin: Point
    /// A size that specifies the height and width of the rectangle.
    public var size: Size
    
    public init(origin: Point = .zero, size: Size = .zero) {
        self.origin = origin
        self.size = size
    }
    
    public init(x: Double, y: Double, width: Double, height: Double) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
    
    public init(x: Float, y: Float, width: Float, height: Float) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
    
    public init(x: Int, y: Int, width: Int, height: Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

// MARK: - CustomStringConvertible
extension Rect: CustomStringConvertible {
    public var description: String {
        "Rect(origin: \(origin), size: \(size))"
    }
}

// MARK: - Equatable
extension Rect: Equatable {
}

// MARK: - Codable
extension Rect: Codable {
}
