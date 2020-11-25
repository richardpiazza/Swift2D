#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

public extension Size {
    /// Initialize a `Size` using the provided `CGSize` values.
    init(_ size: CGSize) {
        self.init(width: Float(size.width), height: Float(size.height))
    }
    
    @available(*, deprecated, renamed: "CGSize(_:)", message: "Use CGSize initializer directly")
    var cgSize: CGSize {
        return CGSize(self)
    }
}

public extension CGSize {
    /// Initialize a `CGSize` using the provided `Size` values.
    init(_ size: Size) {
        self.init(width: CGFloat(size.width), height: CGFloat(size.height))
    }
    
    @available(*, deprecated, renamed: "Size(_:)", message: "Use Size initializer directly")
    var size: Size {
        return Size(width: Float(width), height: Float(height))
    }
}
