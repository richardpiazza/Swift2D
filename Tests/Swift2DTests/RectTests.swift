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
        var r1: Rect = .zero
        var r2: Rect = .zero
        XCTAssertTrue(r1 == r2)
        
        r1 = .nan
        r2 = .nan
        XCTAssertTrue(r1 == r2)
        
        r1 = .infinite
        r2 = .infinite
        XCTAssertTrue(r1 == r2)
        
        r1 = .null
        r2 = .null
        XCTAssertTrue(r1 == r2)
        
        r1 = Rect(x: 10, y: 10, width: 20, height: 20)
        r2 = Rect(x: 100, y: 100, width: 200, height: 200)
        XCTAssertFalse(r1 == r2)
        
        r2 = r1
        XCTAssertTrue(r1 == r2)
    }
    
    func testCodable() throws {
        let json = """
        {
            "origin": {
                "x": 1.2,
                "y": 2.3
            },
            "size": {
                "width": 3.4,
                "height": 4.5
            }
        }
        """
        
        let data = try XCTUnwrap(json.data(using: .utf8))
        var rect = try JSONDecoder().decode(Rect.self, from: data)
        XCTAssertEqual(rect.origin.x, 1.2)
        XCTAssertEqual(rect.origin.y, 2.3)
        XCTAssertEqual(rect.size.width, 3.4)
        XCTAssertEqual(rect.size.height, 4.5)
        
        rect.origin = Point(x: 9.8, y: 8.7)
        rect.size = Size(width: 7.6, height: 6.5)
        
        let encoded = try JSONEncoder().encode(rect)
        let dictionary = try XCTUnwrap(try JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: [String: Float]])
        XCTAssertEqual(dictionary["origin"]?["x"], 9.8)
        XCTAssertEqual(dictionary["origin"]?["y"], 8.7)
        XCTAssertEqual(dictionary["size"]?["width"], 7.6)
        XCTAssertEqual(dictionary["size"]?["height"], 6.5)
    }
    
    func testStaticReferences() {
        var rect: Rect = .zero
        XCTAssertEqual(rect.origin.x, 0.0)
        XCTAssertEqual(rect.origin.y, 0.0)
        XCTAssertEqual(rect.size.width, 0.0)
        XCTAssertEqual(rect.size.height, 0.0)
        XCTAssertTrue(rect.isZero)
        XCTAssertFalse(rect.isNaN)
        XCTAssertFalse(rect.isInfinite)
        XCTAssertFalse(rect.isNull)
        XCTAssertTrue(rect.isEmpty)
        
        rect = .nan
        XCTAssertTrue(rect.origin.x.isNaN)
        XCTAssertTrue(rect.origin.y.isNaN)
        XCTAssertTrue(rect.size.width.isNaN)
        XCTAssertTrue(rect.size.height.isNaN)
        XCTAssertFalse(rect.isZero)
        XCTAssertTrue(rect.isNaN)
        XCTAssertFalse(rect.isInfinite)
        XCTAssertFalse(rect.isNull)
        XCTAssertFalse(rect.isEmpty)
        
        rect = .infinite
        XCTAssertEqual(rect.origin.x, -Float.greatestFiniteMagnitude / 2)
        XCTAssertEqual(rect.origin.y, -Float.greatestFiniteMagnitude / 2)
        XCTAssertEqual(rect.size.width, Float.greatestFiniteMagnitude)
        XCTAssertEqual(rect.size.height, Float.greatestFiniteMagnitude)
        XCTAssertFalse(rect.isZero)
        XCTAssertFalse(rect.isNaN)
        XCTAssertTrue(rect.isInfinite)
        XCTAssertTrue(rect.isNull)
        XCTAssertTrue(rect.isEmpty)
        
        rect = .null
        XCTAssertEqual(rect.origin.x, Float.infinity)
        XCTAssertEqual(rect.origin.y, Float.infinity)
        XCTAssertEqual(rect.size.width, 0.0)
        XCTAssertEqual(rect.size.height, 0.0)
        XCTAssertFalse(rect.isZero)
        XCTAssertFalse(rect.isNaN)
        XCTAssertFalse(rect.isInfinite)
        XCTAssertTrue(rect.isNull)
        XCTAssertTrue(rect.isEmpty)
    }
    
    func testComputedProperties() {
        var rect: Rect = .zero
        
        rect = Rect(x: 50.0, y: 50.0, width: 80.0, height: 80.0)
        XCTAssertEqual(rect.x, 50.0)
        XCTAssertEqual(rect.y, 50.0)
        XCTAssertEqual(rect.width, 80.0)
        XCTAssertEqual(rect.height, 80.0)
        XCTAssertEqual(rect.center, Point(x: 90.0, y: 90.0))
        XCTAssertEqual(rect.minX, 50.0)
        XCTAssertEqual(rect.midX, 90.0)
        XCTAssertEqual(rect.maxX, 130.0)
        XCTAssertEqual(rect.minY, 50.0)
        XCTAssertEqual(rect.midY, 90.0)
        XCTAssertEqual(rect.maxY, 130.0)
        XCTAssertEqual(rect.standardized, Rect(x: 50.0, y: 50.0, width: 80.0, height: 80.0))
        
        rect = Rect(x: 50.0, y: 50.0, width: -80.0, height: -80.0)
        XCTAssertEqual(rect.x, 50.0)
        XCTAssertEqual(rect.y, 50.0)
        XCTAssertEqual(rect.width, -80.0)
        XCTAssertEqual(rect.height, -80.0)
        XCTAssertEqual(rect.center, Point(x: 10.0, y: 10.0))
        XCTAssertEqual(rect.minX, -30.0)
        XCTAssertEqual(rect.midX, 10.0)
        XCTAssertEqual(rect.maxX, 50.0)
        XCTAssertEqual(rect.minY, -30.0)
        XCTAssertEqual(rect.midY, 10.0)
        XCTAssertEqual(rect.maxY, 50.0)
        XCTAssertEqual(rect.standardized, Rect(x: -30.0, y: -30.0, width: 80.0, height: 80.0))
        
        rect = .null
        XCTAssertTrue(rect.standardized.isNull)
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
