// MARK: - Static References
public extension Point {
    static let zero: Point = Point(x: 0, y: 0)
    static let nan: Point = Point(x: Double.nan, y: Double.nan)
    internal static let infinite: Point = Point(x: -Double.greatestFiniteMagnitude / 2, y: -Double.greatestFiniteMagnitude / 2)
    internal static let null: Point = Point(x: Double.infinity, y: Double.infinity)
    
    var isZero: Bool {
        return self == .zero
    }
    
    var isNaN: Bool {
        return self == .nan
    }
}
