import Foundation
#if canImport(CoreGraphics)
import CoreGraphics

public extension Rect {
    var cgRect: CGRect {
        return CGRect(self)
    }
}

public extension CGRect {
    init(_ rect: Rect) {
        self.init(origin: rect.origin.cgPoint, size: rect.size.cgSize)
    }
    
    var rect: Rect {
        return Rect(origin: origin.point, size: size.size)
    }
}
#endif
