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
    
    public init(x: Double, y: Double) {
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
    public static func ==(lhs: Point, rhs: Point) -> Bool {
        if (lhs.x.isNaN && rhs.x.isNaN) && (lhs.y.isNaN && rhs.y.isNaN) {
            return true
        }
        
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

// MARK: - Hashable
extension Point: Hashable {
}

// MARK: - Codable
extension Point: Codable {
}
