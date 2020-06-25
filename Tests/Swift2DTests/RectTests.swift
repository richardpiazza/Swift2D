import XCTest
@testable import Swift2D
#if canImport(CoreGraphics)
import CoreGraphics
#endif

final class RectTests: XCTestCase {
    
    static var allTests = [
        ("testInitializers", testInitializers),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testEquatable", testEquatable),
        ("testCodable", testCodable),
        ("testStaticReferences", testStaticReferences),
        ("testComputedProperties", testComputedProperties),
        ("testCoreGraphics", testCoreGraphics),
    ]
    
    func testInitializers() throws {
        var rect: Rect = .zero
        
        rect = .init()
        XCTAssertEqual(rect.origin.x, 0.0)
        XCTAssertEqual(rect.origin.y, 0.0)
        XCTAssertEqual(rect.size.width, 0.0)
        XCTAssertEqual(rect.size.height, 0.0)
        
        rect = .init(origin: Point(x: 4, y: 5), size: Size(width: 1.4, height: 5.2))
        XCTAssertEqual(rect.origin.x, 4.0)
        XCTAssertEqual(rect.origin.y, 5.0)
        XCTAssertEqual(rect.size.width, 1.4)
        XCTAssertEqual(rect.size.height, 5.2)
        
        rect = .init(x: 1.2, y: 3.4, width: 5.6, height: 7.8)
        XCTAssertEqual(rect.origin.x, 1.2)
        XCTAssertEqual(rect.origin.y, 3.4)
        XCTAssertEqual(rect.size.width, 5.6)
        XCTAssertEqual(rect.size.height, 7.8)
        
        rect = .init(x: 1, y: 2, width: 3, height: 4)
        XCTAssertEqual(rect.origin.x, 1.0)
        XCTAssertEqual(rect.origin.y, 2.0)
        XCTAssertEqual(rect.size.width, 3.0)
        XCTAssertEqual(rect.size.height, 4.0)
        
        rect = .init(origin: Point(x: 4.87654321, y: 5.87654321), size: Size(width: 6.87654321, height: 7.87654321))
        XCTAssertEqual(rect.origin.x, 4.8765432)
        XCTAssertEqual(rect.origin.y, 5.8765432)
        XCTAssertEqual(rect.size.width, 6.8765432)
        XCTAssertEqual(rect.size.height, 7.8765432)
    }
    
    func testCustomStringConvertible() throws {
        var rect: Rect = .zero
        
        rect = Rect(origin: .init(x: 15.0, y: 20.0), size: .init(width: 25.0, height: 10.0))
        XCTAssertEqual(rect.description, "Rect(origin: Point(x: 15.0, y: 20.0), size: Size(width: 25.0, height: 10.0))")
        
        rect = Rect(origin: .init(x: 15.0, y: 20.0), size: .init(width: -25.0, height: -10.0))
        XCTAssertEqual(rect.description, "Rect(origin: Point(x: 15.0, y: 20.0), size: Size(width: -25.0, height: -10.0))")
        
        rect = Rect(origin: .init(x: -15.0, y: -20.0), size: .init(width: -25.0, height: -10.0))
        XCTAssertEqual(rect.description, "Rect(origin: Point(x: -15.0, y: -20.0), size: Size(width: -25.0, height: -10.0))")
    }
    
    func testEquatable() throws {
    }
    
    func testCodable() throws {
    }
    
    func testStaticReferences() {
    }
    
    func testComputedProperties() {
    }
    
    func testCoreGraphics() throws {
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
    }
}
