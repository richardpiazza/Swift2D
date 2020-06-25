// MARK: - Static References
public extension Point {
    static let zero: Point = Point(x: 0, y: 0)
    static let nan: Point = Point(x: Float.nan, y: Float.nan)
    internal static let infinite: Point = Point(x: -Float.greatestFiniteMagnitude / 2, y: -Float.greatestFiniteMagnitude / 2)
    internal static let null: Point = Point(x: Float.infinity, y: Float.infinity)
}

// MARK: - Computed Properties
public extension Point {
    var isZero: Bool {
        return self == .zero
    }
    
    var isNaN: Bool {
        return self == .nan
    }
}
