// MARK: - Common References
public extension Point {
    static let zero: Point = Point(x: 0, y: 0)
    static let nan: Point = Point(x: Double.nan, y: Double.nan)
    internal static let infinite: Point = Point(x: -Double.greatestFiniteMagnitude / 2, y: -Double.greatestFiniteMagnitude / 2)
    internal static let null: Point = Point(x: Double.infinity, y: Double.infinity)
    
    var isZero: Bool { self == .zero }
    var isNaN: Bool { self == .nan }
}

// MARK: - Conveniece Accessors & Methods
public extension Point {
    /// Calculates the mirrored point using the provided values
    func reflection(using point: Point) -> Point {
        let x = (2 * point.x) - self.x
        let y = (2 * point.y) - self.y
        return Point(x: x, y: y)
    }
}
