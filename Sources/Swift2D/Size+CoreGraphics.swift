#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

public extension Size {
    /// Initialize a `Size` using the provided `CGSize` values.
    init(_ size: CGSize) {
        self.init(width: Double(size.width), height: Double(size.height))
    }
}

public extension CGSize {
    /// Initialize a `CGSize` using the provided `Size` values.
    init(_ size: Size) {
        self.init(width: CGFloat(size.width), height: CGFloat(size.height))
    }
}
