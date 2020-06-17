import XCTest
@testable import Swift2D

final class RectTests: XCTestCase {
    
    static var allTests = [
        ("testRect", testRect),
        ("testRectCoreGraphics", testRectCoreGraphics),
    ]
    
    func testRect() throws {
        XCTAssertEqual(Rect.zero, Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 0.0, height: 0.0)))
        var rect: Rect = .nan
        XCTAssertTrue(rect.origin.x.isNaN)
        XCTAssertTrue(rect.origin.y.isNaN)
        XCTAssertTrue(rect.size.width.isNaN)
        XCTAssertTrue(rect.size.height.isNaN)
        
        rect = Rect(origin: .init(x: 15.0, y: 20.0), size: .init(width: 25.0, height: 10.0))
        XCTAssertEqual(rect.description, "Rect(origin: Point(x: 15.0, y: 20.0), size: Size(width: 25.0, height: 10.0))")
        XCTAssertEqual(rect.x, 15.0)
        XCTAssertEqual(rect.y, 20.0)
        XCTAssertEqual(rect.width, 25.0)
        XCTAssertEqual(rect.height, 10.0)
        XCTAssertEqual(rect.center, Point(x: 27.5, y: 25.0))
        XCTAssertEqual(rect.minX, 15.0)
        XCTAssertEqual(rect.midX, 27.5)
        XCTAssertEqual(rect.maxX, 40.0)
        XCTAssertEqual(rect.minY, 20.0)
        XCTAssertEqual(rect.midY, 25.0)
        XCTAssertEqual(rect.maxY, 30.0)
        
        rect = Rect(origin: .init(x: 15.0, y: 20.0), size: .init(width: -25.0, height: -10.0))
        XCTAssertEqual(rect.description, "Rect(origin: Point(x: 15.0, y: 20.0), size: Size(width: -25.0, height: -10.0))")
        XCTAssertEqual(rect.x, 15.0)
        XCTAssertEqual(rect.y, 20.0)
        XCTAssertEqual(rect.width, -25.0)
        XCTAssertEqual(rect.height, -10.0)
        XCTAssertEqual(rect.center, Point(x: 2.5, y: 15.0))
        XCTAssertEqual(rect.minX, -10.0)
        XCTAssertEqual(rect.midX, 2.5)
        XCTAssertEqual(rect.maxX, 15.0)
        XCTAssertEqual(rect.minY, 10.0)
        XCTAssertEqual(rect.midY, 15.0)
        XCTAssertEqual(rect.maxY, 20.0)
        
        rect = Rect(origin: .init(x: -15.0, y: -20.0), size: .init(width: -25.0, height: -10.0))
        XCTAssertEqual(rect.description, "Rect(origin: Point(x: -15.0, y: -20.0), size: Size(width: -25.0, height: -10.0))")
        XCTAssertEqual(rect.x, -15.0)
        XCTAssertEqual(rect.y, -20.0)
        XCTAssertEqual(rect.width, -25.0)
        XCTAssertEqual(rect.height, -10.0)
        XCTAssertEqual(rect.center, Point(x: -27.5, y: -25.0))
        XCTAssertEqual(rect.minX, -40.0)
        XCTAssertEqual(rect.midX, -27.5)
        XCTAssertEqual(rect.maxX, -15.0)
        XCTAssertEqual(rect.minY, -30.0)
        XCTAssertEqual(rect.midY, -25.0)
        XCTAssertEqual(rect.maxY, -20.0)
    }
    
    func testRectCoreGraphics() throws {
        #if canImport(CoreGraphics)
        var cgRect = Rect(x: 1.2, y: 3.4, width: 5.6, height: 7.8).cgRect
        XCTAssertEqual(cgRect.origin.x, 1.2, accuracy: 0.00001)
        XCTAssertEqual(cgRect.origin.y, 3.4, accuracy: 0.00001)
        XCTAssertEqual(cgRect.width, 5.6, accuracy: 0.00001)
        XCTAssertEqual(cgRect.height, 7.8, accuracy: 0.00001)
        cgRect = CGRect(.init(origin: Point(x: 12, y: 21), size: Size(width: 34, height: 43)))
        let rect = cgRect.rect
        XCTAssertEqual(rect.x, 12.0, accuracy: 0.00001)
        XCTAssertEqual(rect.y, 21.0, accuracy: 0.00001)
        XCTAssertEqual(rect.width, 34.0, accuracy: 0.00001)
        XCTAssertEqual(rect.height, 43.0, accuracy: 0.00001)
        #else
        XCTSkip("This test requires the CoreGraphics framework.")
        #endif
    }
}
