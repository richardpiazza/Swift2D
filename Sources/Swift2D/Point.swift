/// The representation of a single point in a two-dimensional plane.
public struct Point: Hashable, Codable, Sendable {

    public let x: Double
    public let y: Double

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

    public static let zero: Point = .init(x: 0, y: 0)
    public static let nan: Point = .init(x: Double.nan, y: Double.nan)
    static let infinite: Point = .init(x: -Double.greatestFiniteMagnitude / 2, y: -Double.greatestFiniteMagnitude / 2)
    static let null: Point = .init(x: Double.infinity, y: Double.infinity)

    public var isZero: Bool { self == .zero }
    public var isNaN: Bool { self == .nan }

    public func with(x value: Double) -> Point {
        Point(x: value, y: y)
    }

    public func with(y value: Double) -> Point {
        Point(x: x, y: value)
    }

    /// Calculates the mirrored point using the provided values
    public func reflection(using point: Point) -> Point {
        let x = (2 * point.x) - x
        let y = (2 * point.y) - y
        return Point(x: x, y: y)
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        "Point(x: \(x), y: \(y))"
    }
}

public extension Point {
    static func == (lhs: Point, rhs: Point) -> Bool {
        if lhs.x.isNaN, rhs.x.isNaN, lhs.y.isNaN, rhs.y.isNaN {
            return true
        }

        if lhs.x.isInfinite, rhs.x.isInfinite, lhs.y.isInfinite, rhs.y.isInfinite {
            return true
        }

        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
