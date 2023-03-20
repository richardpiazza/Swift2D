/// The representation of a single point in a two-dimensional plane.
public struct Point {
    
    public var x: Double
    public var y: Double
    
    public init(x: Double = 0.0, y: Double = 0.0) {
        self.x = x
        self.y = y
    }
    
    public init(x: Float, y: Float) {
        self.x = Double(x)
        self.y = Double(y)
    }
    
    public init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
}

// MARK: - CustomStringConvertible
extension Point: CustomStringConvertible {
    public var description: String {
        "Point(x: \(x), y: \(y))"
    }
}

// MARK: - Equatable
extension Point: Equatable {
    public static func ==(lhs: Point, rhs: Point) -> Bool {
        if (lhs.x.isNaN && rhs.x.isNaN) && (lhs.y.isNaN && rhs.y.isNaN) {
            return true
        }
        
        if (lhs.x.isInfinite && rhs.x.isInfinite) && (lhs.y.isInfinite && rhs.y.isInfinite) {
            return true
        }
        
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

// MARK: - Codable
extension Point: Codable {
}
