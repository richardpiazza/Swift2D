// MARK: - Common References
public extension Rect {
    static let zero: Rect = Rect(origin: .zero, size: .zero)
    static let nan: Rect = Rect(origin: .nan, size: .nan)
    static let infinite: Rect = Rect(origin: .infinite, size: .infinite)
    static let null: Rect = Rect(origin: .null, size: .zero)
    
    var isZero: Bool {
        return self == .zero
    }
    
    var isNaN: Bool {
        return self == .nan
    }
    
    var isInfinite: Bool {
        return self == .infinite
    }
    
    var isNull: Bool {
        return origin == .infinite || origin == .null
    }
    
    var isEmpty: Bool {
        return isNull || width == 0.0 || height == 0.0
    }
}

// MARK: - Convenience Accessors
public extension Rect {
    /// The x-coordinate of the rectangle origin
    var x: Float {
        return origin.x
    }
    
    /// The y-coordinate of the rectangle origin
    var y: Float {
        return origin.y
    }
    
    /// The width of the rectangle.
    var width: Float {
        return size.width
    }
    
    /// The height of the rectangle.
    var height: Float {
        return size.height
    }
    
    var center: Point {
        return Point(x: midX, y: midY)
    }
    
    /// The smallest value for the x-coordinate of the rectangle.
    var minX: Float {
        if size.width < 0.0 {
            return origin.x - abs(size.width)
        }
        
        return origin.x
    }
    
    /// The x-coordinate that establishes the center of a rectangle.
    var midX: Float {
        return minX + size.xRadius
    }
    
    /// The largest value of the x-coordinate for the rectangle.
    var maxX: Float {
        if size.width < 0.0 {
           return origin.x
        }
        
        return origin.x + size.width
    }
    
    /// The smallest value for the y-coordinate of the rectangle.
    var minY: Float {
        if size.height < 0.0 {
            return origin.y - abs(size.height)
        }
        
        return origin.y
    }
    
    /// The y-coordinate that establishes the center of the rectangle.
    var midY: Float {
        return minY + size.yRadius
    }
    
    /// The largest value for the y-coordinate of the rectangle.
    var maxY: Float {
        if size.height < 0.0 {
            return origin.y
        }
        
        return origin.y + size.height
    }
    
    /// Returns a rectangle with a positive width and height.
    var standardized: Rect {
        guard !isNull else  {
            return .null
        }
        
        return Rect(x: minX, y: minY, width: abs(width), height: abs(height))
    }
}

// MARK: - Relationships (intersection/contains)
public extension Rect {
    
}

// MARK: - Transformations (offset/inset)
public extension Rect {
    
}
