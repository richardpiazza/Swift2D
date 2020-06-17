import Foundation

/// The representation of a single point in a two-dimensional plane.
public struct Point {
    public var x: Float
    public var y: Float
    
    public init() {
        x = 0.0
        y = 0.0
    }
    
    public init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
    
    public init(x: Int, y: Int) {
        self.x = Float(x)
        self.y = Float(y)
    }
}

// MARK: - CustomStringConvertible
extension Point: CustomStringConvertible {
    public var description: String {
        return "Point(x: \(x), y: \(y))"
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
