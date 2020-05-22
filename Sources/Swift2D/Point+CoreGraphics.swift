import Foundation
#if canImport(CoreGraphics)
import CoreGraphics

public extension Point {
    var cgPoint: CGPoint {
        return CGPoint(self)
    }
}

public extension CGPoint {
    init(_ point: Point) {
        self.init(x: CGFloat(point.x), y: CGFloat(point.y))
    }
    
    var point: Point {
        return Point(x: Float(x), y: Float(y))
    }
}
#endif
