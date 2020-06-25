import XCTest
@testable import Swift2D
#if canImport(CoreGraphics)
import CoreGraphics
#endif

final class PointTests: XCTestCase {
    
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
        var point: Point = .zero
            
        point = .init(x: 5, y: 8)
        XCTAssertEqual(point.x, 5.0)
        XCTAssertEqual(point.y, 8.0)
        
        point = .init(x: 5.876, y: 8.123)
        XCTAssertEqual(point.x, 5.876)
        XCTAssertEqual(point.y, 8.123)
        
        point = .init(x: 0.123456789, y: 0.987654321)
        XCTAssertEqual(point.x, 0.12345679)
        XCTAssertEqual(point.y, 0.9876543)
    }
    
    func testCustomStringConvertible() throws {
        let point = Point(x: 5.0, y: -5.0)
        XCTAssertEqual(point.description, "Point(x: 5.0, y: -5.0)")
    }
    
    func testEquatable() throws {
        var p1: Point = .zero
        var p2: Point = .zero
        XCTAssertTrue(p1 == p2)
        
        p1 = .nan
        p2 = .nan
        XCTAssertTrue(p1 == p2)
        
        p1 = .infinite
        p2 = .infinite
        XCTAssertTrue(p1 == p2)
        
        p1 = .null
        p2 = .null
        XCTAssertTrue(p1 == p2)
        
        p1 = .init(x: 2.5, y: 1.75)
        p2 = .init(x: 4, y: 7)
        XCTAssertFalse(p1 == p2)
    }
    
    func testCodable() throws {
        let json = """
        {
            "x": 8.8,
            "y": 4
        }
        """
        
        let data = try XCTUnwrap(json.data(using: .utf8))
        var point = try JSONDecoder().decode(Point.self, from: data)
        XCTAssertEqual(point.x, 8.8)
        XCTAssertEqual(point.y, 4.0)
        
        point.x = 0.111234
        point.y = 45.763
        
        let encoded = try JSONEncoder().encode(point)
        let dictionary = try XCTUnwrap(try JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Float])
        XCTAssertEqual(dictionary["x"], 0.111234)
        XCTAssertEqual(dictionary["y"], 45.763)
    }
    
    func testStaticReferences() {
        XCTAssertEqual(Point.zero.x, 0.0)
        XCTAssertEqual(Point.zero.y, 0.0)
        XCTAssertTrue(Point.nan.x.isNaN)
        XCTAssertTrue(Point.nan.y.isNaN)
    }
    
    func testComputedProperties() {
        XCTAssertTrue(Point.zero.isZero)
        XCTAssertTrue(Point.nan.isNaN)
        XCTAssertFalse(Point(x: 2, y: 9).isZero)
        XCTAssertFalse(Point(x: 88.8, y: 88.8).isNaN)
    }
    
    func testCoreGraphics() throws {
        let point = Point(x: 45, y: 60)
        var cgPoint = point.cgPoint
        XCTAssertEqual(cgPoint.x, 45.0)
        XCTAssertEqual(cgPoint.y, 60.0)
        XCTAssertEqual(cgPoint.point, .init(x: 45.0, y: 60.0))
        cgPoint = CGPoint(Point(x: 24.7, y: 31.5))
        XCTAssertEqual(cgPoint.x, 24.7, accuracy: 0.0001)
        XCTAssertEqual(cgPoint.y, 31.5)
    }
}
