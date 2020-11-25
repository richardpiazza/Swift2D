#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

public extension Point {
    /// Initialize a `Point` using the provided `CGPoint` values.
    init(_ point: CGPoint) {
        self.init(x: Float(point.x), y: Float(point.y))
    }
    
    @available(*, deprecated, renamed: "CGPoint(_:)", message: "Use CGPoint initializer directly")
    var cgPoint: CGPoint {
        return CGPoint(self)
    }
}

public extension CGPoint {
    /// Initialize a `CPPoint` using the provided `Point` values.
    init(_ point: Point) {
        self.init(x: CGFloat(point.x), y: CGFloat(point.y))
    }
    
    @available(*, deprecated, renamed: "Point(_:)", message: "Use Point initializer directly")
    var point: Point {
        return Point(x: Float(x), y: Float(y))
    }
}
