import Foundation

/// A structure that represents a point in a two-dimensional coordinate system.
public struct Point {
    public var x: Float
    public var y: Float
    
    public init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
}

// MARK: - CustomStringConvertible
extension Point: CustomStringConvertible {
    public var description: String {
        return String(format: "Point(x: %.5f, y: %.5f)", x, y)
    }
}

// MARK: - Equatable
extension Point: Equatable {
}

// MARK: - Static References
public extension Point {
    static let nan: Point = Point(x: .nan, y: .nan)
    static let zero: Point = Point(x: 0.0, y: 0.0)
}
