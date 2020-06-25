/// A representation of two-dimensional width and height values.
public struct Size {
    public var width: Float
    public var height: Float
    
    public init() {
        width = 0.0
        height = 0.0
    }
    
    public init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    public init(width: Int, height: Int) {
        self.width = Float(width)
        self.height = Float(height)
    }
    
    public init(width: Double, height: Double) {
        self.width = Float(width)
        self.height = Float(height)
    }
}

// MARK: - CustomStringConvertible
extension Size: CustomStringConvertible {
    public var description: String {
        return "Size(width: \(width), height: \(height))"
    }
}

// MARK: - Equatable
extension Size: Equatable {
    public static func ==(lhs: Size, rhs: Size) -> Bool {
        if (lhs.width.isNaN && rhs.width.isNaN) && (lhs.height.isNaN && rhs.height.isNaN) {
            return true
        }
        
        if (lhs.width.isInfinite && rhs.width.isInfinite) && (lhs.height.isInfinite && rhs.height.isInfinite) {
            return true
        }
        
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}

// MARK: - Codable
extension Size: Codable {
}
