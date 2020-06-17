import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#endif
@testable import Swift2D

final class PointTests: XCTestCase {
    
    static var allTests = [
        ("testPoint", testPoint),
        ("testPointCoreGraphics", testPointCoreGraphics),
    ]
    
    func testPoint() throws {
        var point: Point = .zero
        XCTAssertEqual(point.x, 0.0)
        XCTAssertEqual(point.y, 0.0)
        
        point = .nan
        XCTAssertTrue(point.x.isNaN)
        XCTAssertTrue(point.y.isNaN)
        
        point = .init(x: 47.0, y: 42.0)
        XCTAssertNotEqual(point, Point(x: 124.0, y: 56.0))
        
        point = .init(x: 5.0, y: -5.0)
        XCTAssertEqual(point.x, 5.0)
        XCTAssertEqual(point.y, -5.0)
        XCTAssertEqual(point.description, "Point(x: 5.0, y: -5.0)")
    }
    
    func testPointCoreGraphics() throws {
        #if canImport(CoreGraphics)
        let point = Point(x: 45, y: 60)
        var cgPoint = point.cgPoint
        XCTAssertEqual(cgPoint.x, 45.0)
        XCTAssertEqual(cgPoint.y, 60.0)
        XCTAssertEqual(cgPoint.point, .init(x: 45.0, y: 60.0))
        cgPoint = CGPoint(Point(x: 24.7, y: 31.5))
        XCTAssertEqual(cgPoint.x, 24.7, accuracy: 0.0001)
        XCTAssertEqual(cgPoint.y, 31.5)
        #else
        XCTSkip("This test requires the CoreGraphics framework.")
        #endif
    }
}
