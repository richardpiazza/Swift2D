import Foundation
#if canImport(CoreGraphics)
import CoreGraphics

public extension Size {
    var cgSize: CGSize {
        return CGSize(self)
    }
}

public extension CGSize {
    init(_ size: Size) {
        self.init(width: CGFloat(size.width), height: CGFloat(size.height))
    }
    
    var size: Size {
        return Size(width: Float(width), height: Float(height))
    }
}
#endif
