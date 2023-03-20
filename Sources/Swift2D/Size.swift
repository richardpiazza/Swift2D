/// A representation of two-dimensional width and height values.
public struct Size {
    
    public var width: Double
    public var height: Double
    
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
}

// MARK: - CustomStringConvertible
extension Size: CustomStringConvertible {
    public var description: String {
        "Size(width: \(width), height: \(height))"
    }
}

// MARK: - Equatable
extension Size: Equatable {
    public static func ==(lhs: Size, rhs: Size) -> Bool {
        if (lhs.width.isNaN && rhs.width.isNaN) && (lhs.height.isNaN && rhs.height.isNaN) {
            return true
        }
        
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}

// MARK: - Codable
extension Size: Codable {
}
