// MARK: - Common References
public extension Size {
    static let zero: Size = Size(width: 0.0, height: 0.0)
    static let nan: Size = Size(width: Double.nan, height: Double.nan)
    internal static let infinite: Size = Size(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude)
    
    var isZero: Bool { self == .zero }
    var isNaN: Bool { self == .nan }
}

// MARK: - Convenience Accessors
public extension Size {
    /// The horizontal radius (½ of `width`)
    var xRadius: Double { abs(width) / 2.0 }
    
    /// The horizontal radius (½ of `width`)
    var horizontalRadius: Double { xRadius }
    
    /// The vertical radius (½ of `height`)
    var yRadius: Double { abs(height) / 2.0 }
    
    /// The vertical radius (½ of `height`)
    var verticalRadius: Double { yRadius }
    
    /// The largest radius, out of `xRadius` & `yRadius`.
    var maxRadius: Double { max(xRadius, yRadius) }
    
    /// The smallest radius, out of `xRadius` & `yRadius`.
    var minRadius: Double { min(xRadius, yRadius) }
    
    /// The `Point` at which the `xRadius` & `yRadius` intersect.
    var center: Point { Point(x: xRadius, y: yRadius) }
}
