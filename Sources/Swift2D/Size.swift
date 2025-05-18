/// A representation of two-dimensional width and height values.
public struct Size: Hashable, Codable, Sendable {
    public let width: Double
    public let height: Double

    public init(width: Double = 0.0, height: Double = 0.0) {
        self.width = width
        self.height = height
    }

    public init(width: Float, height: Float) {
        self.width = Double(width)
        self.height = Double(height)
    }

    public init(width: Int, height: Int) {
        self.width = Double(width)
        self.height = Double(height)
    }

    public static let zero: Size = .init(width: 0.0, height: 0.0)
    public static let nan: Size = .init(width: Double.nan, height: Double.nan)
    static let infinite: Size = .init(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude)

    public var isZero: Bool { self == .zero }
    public var isNaN: Bool { self == .nan }

    /// The horizontal radius (½ of `width`)
    public var xRadius: Double { abs(width) / 2.0 }

    /// The horizontal radius (½ of `width`)
    public var horizontalRadius: Double { xRadius }

    /// The vertical radius (½ of `height`)
    public var yRadius: Double { abs(height) / 2.0 }

    /// The vertical radius (½ of `height`)
    public var verticalRadius: Double { yRadius }

    /// The largest radius, out of `xRadius` & `yRadius`.
    public var maxRadius: Double { max(xRadius, yRadius) }

    /// The smallest radius, out of `xRadius` & `yRadius`.
    public var minRadius: Double { min(xRadius, yRadius) }

    /// The `Point` at which the `xRadius` & `yRadius` intersect.
    public var center: Point { Point(x: xRadius, y: yRadius) }

    public func with(width value: Double) -> Size {
        Size(width: value, height: height)
    }

    public func with(height value: Double) -> Size {
        Size(width: width, height: value)
    }
}

extension Size: CustomStringConvertible {
    public var description: String {
        "Size(width: \(width), height: \(height))"
    }
}

public extension Size {
    static func == (lhs: Size, rhs: Size) -> Bool {
        if lhs.width.isNaN, rhs.width.isNaN, lhs.height.isNaN, rhs.height.isNaN {
            return true
        }

        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}
