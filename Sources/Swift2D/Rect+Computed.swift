// MARK: - Common References
public extension Rect {
    static let zero: Rect = Rect(origin: .zero, size: .zero)
    static let nan: Rect = Rect(origin: .nan, size: .nan)
    static let infinite: Rect = Rect(origin: .infinite, size: .infinite)
    static let null: Rect = Rect(origin: .null, size: .zero)
    
    var isZero: Bool { self == .zero }
    var isNaN: Bool { self == .nan }
    var isInfinite: Bool { self == .infinite }
    var isNull: Bool { origin == .infinite || origin == .null }
    var isEmpty: Bool { isNull || width == 0.0 || height == 0.0 }
}

// MARK: - Convenience Accessors
public extension Rect {
    /// The x-coordinate of the rectangle origin
    var x: Double { origin.x }
    
    /// The y-coordinate of the rectangle origin
    var y: Double { origin.y }
    
    /// The width of the rectangle.
    var width: Double { size.width
    }
    
    /// The height of the rectangle.
    var height: Double { size.height
    }
    
    var center: Point { Point(x: midX, y: midY) }
    
    /// The smallest value for the x-coordinate of the rectangle.
    var minX: Double {
        if size.width < 0.0 {
            return origin.x - abs(size.width)
        }
        
        return origin.x
    }
    
    /// The x-coordinate that establishes the center of a rectangle.
    var midX: Double { minX + size.xRadius }
    
    /// The largest value of the x-coordinate for the rectangle.
    var maxX: Double {
        if size.width < 0.0 {
           return origin.x
        }
        
        return origin.x + size.width
    }
    
    /// The smallest value for the y-coordinate of the rectangle.
    var minY: Double {
        if size.height < 0.0 {
            return origin.y - abs(size.height)
        }
        
        return origin.y
    }
    
    /// The y-coordinate that establishes the center of the rectangle.
    var midY: Double { minY + size.yRadius }
    
    /// The largest value for the y-coordinate of the rectangle.
    var maxY: Double {
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
    func contains(_ point: Point) -> Bool {
        guard !isNull else {
            return false
        }
        
        guard !isEmpty else {
            return false
        }
        
        return (minX..<maxX).contains(point.x) && (minY..<maxY).contains(point.y)
    }
    
    func contains(_ rect: Rect) -> Bool { union(rect) == self }
    
    func intersects(_ rect: Rect) -> Bool { !intersection(rect).isNull }
    
    func intersection(_ rect: Rect) -> Rect {
        guard !isNull else {
            return .null
        }
        
        guard !rect.isNull else {
            return .null
        }
        
        let r1 = self.standardized
        let r1spanH = r1.minX...r1.maxX
        let r1spanV = r1.minY...r1.maxY
        
        let r2 = rect.standardized
        let r2spanH = r2.minX...r2.maxX
        let r2spanV = r2.minY...r2.maxY
        
        guard r1spanH.overlaps(r2spanH) && r2spanV.overlaps(r2spanV) else {
            return .null
        }
        
        let overlapH = r1spanH.clamped(to: r2spanH)
        let width: Double
        if overlapH == r1spanH {
            width = r1.width
        } else if overlapH == r2spanH {
            width = r2.width
        } else {
            width = overlapH.upperBound - overlapH.lowerBound
        }
        
        let overlapV = r1spanV.clamped(to: r2spanV)
        let height: Double
        if overlapV == r1spanV {
            height = r1.height
        } else if overlapV == r2spanV {
            height = r2.height
        } else {
            height = overlapV.upperBound - overlapV.lowerBound
        }
        
        return Rect(x: overlapH.lowerBound, y: overlapV.lowerBound, width: width, height: height)
    }
    
    func union(_ rect: Rect) -> Rect {
        guard !isNull else {
            return rect
        }
        
        guard !rect.isNull else {
            return self
        }
        
        let r1 = self.standardized
        let r2 = rect.standardized
        
        let minX = min(r1.minX, r2.minX)
        let maxX = max(r1.maxX, r2.maxX)
        let minY = min(r1.minY, r2.minY)
        let maxY = max(r1.maxY, r2.maxY)
        
        return Rect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}

// MARK: - Transformations (offset/inset)
public extension Rect {
    func offsetBy(dx: Double, dy: Double) -> Rect {
        guard !isNull else {
            return self
        }
        
        var rect = self.standardized
        rect.origin.x += dx
        rect.origin.y += dy
        return rect
    }
    
    func insetBy(dx: Double, dy: Double) -> Rect {
        guard !isNull else {
            return self
        }
        
        var rect = self.standardized
        rect.origin.x += dx
        rect.origin.y += dy
        rect.size.width -= dx * 2
        rect.size.height -= dy * 2
        
        guard rect.size.width >= 0 && rect.size.height >= 0 else {
            return .null
        }
        
        return rect
    }
    
    func expandedBy(dx: Double, dy: Double) -> Rect {
        return insetBy(dx: -dx, dy: -dy)
    }
}
