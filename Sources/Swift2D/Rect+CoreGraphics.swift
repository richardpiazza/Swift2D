#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

public extension Rect {
    /// Initialize a `Rect` using the provided `CGRect` values.
    init(_ rect: CGRect) {
        self.init(
            x: Float(rect.origin.x),
            y: Float(rect.origin.y),
            width: Float(rect.width),
            height: Float(rect.height)
        )
    }

    @available(*, deprecated, renamed: "CGRect(_:)", message: "Use CGRect initializer directly")
    var cgRect: CGRect {
        CGRect(self)
    }
}

public extension CGRect {
    /// Initialize a `CGRect` using the provided `Rect` values.
    init(_ rect: Rect) {
        self.init(
            x: CGFloat(rect.x),
            y: CGFloat(rect.y),
            width: CGFloat(rect.width),
            height: CGFloat(rect.height)
        )
    }
}
