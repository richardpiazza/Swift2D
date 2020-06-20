import XCTest
@testable import Swift2D
#if canImport(CoreGraphics)
import CoreGraphics
#endif

final class SizeTests: XCTestCase {
    
    static var allTests = [
        ("testSize", testSize),
        ("testSizeCoreGraphics", testSizeCoreGraphics),
    ]
    
    func testSize() throws {
        var size: Size = .zero
        XCTAssertEqual(size.width, 0.0)
        XCTAssertEqual(size.height, 0.0)
        
        size = .nan
        XCTAssertTrue(size.width.isNaN)
        XCTAssertTrue(size.height.isNaN)
        
        size = .init(width: 47.0, height: 42.0)
        XCTAssertNotEqual(size, Size(width: 124.0, height: 56.0))
        
        size = .init(width: 15.0, height: -5.0)
        XCTAssertEqual(size.width, 15.0)
        XCTAssertEqual(size.height, -5.0)
        XCTAssertEqual(size.description, "Size(width: 15.0, height: -5.0)")
        XCTAssertEqual(size.xRadius, 7.5)
        XCTAssertEqual(size.yRadius, 2.5)
        XCTAssertEqual(size.maxRadius, 7.5)
        XCTAssertEqual(size.minRadius, 2.5)
        XCTAssertEqual(size.center, Point(x: 7.5, y: 2.5))
    }
    
    func testSizeCoreGraphics() throws {
        let size = Size(width: 45, height: 60)
        var cgSize = size.cgSize
        XCTAssertEqual(cgSize.width, 45.0)
        XCTAssertEqual(cgSize.height, 60.0)
        XCTAssertEqual(cgSize.size, .init(width: 45.0, height: 60.0))
        cgSize = CGSize(Size(width: 24.7, height: 31.5))
        XCTAssertEqual(cgSize.width, 24.7, accuracy: 0.0001)
        XCTAssertEqual(cgSize.height, 31.5)
    }
}
