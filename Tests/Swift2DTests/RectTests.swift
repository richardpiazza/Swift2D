import XCTest
@testable import Swift2D
#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

final class RectTests: XCTestCase {
    
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
        XCTAssertEqual(rect.origin.x, 4.87654321)
        XCTAssertEqual(rect.origin.y, 5.87654321)
        XCTAssertEqual(rect.size.width, 6.87654321)
        XCTAssertEqual(rect.size.height, 7.87654321)
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
        #if canImport(ObjectiveC)
        let dictionary = try XCTUnwrap(try JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: [String: Double]])
        XCTAssertEqual(dictionary["origin"]?["x"], 9.8)
        XCTAssertEqual(dictionary["origin"]?["y"], 8.7)
        XCTAssertEqual(dictionary["size"]?["width"], 7.6)
        XCTAssertEqual(dictionary["size"]?["height"], 6.5)
        #else
        // On Linux systems the cast to 'Float' fails.
        let dictionary = try XCTUnwrap(try JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: [String: Double]])
        XCTAssertEqual(dictionary["origin"]!["x"]!, 9.8, accuracy: 0.1)
        XCTAssertEqual(dictionary["origin"]!["y"]!, 8.7, accuracy: 0.1)
        XCTAssertEqual(dictionary["size"]!["width"]!, 7.6, accuracy: 0.1)
        XCTAssertEqual(dictionary["size"]!["height"]!, 6.5, accuracy: 0.1)
        #endif
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
        XCTAssertEqual(rect.origin.x, -Double.greatestFiniteMagnitude / 2)
        XCTAssertEqual(rect.origin.y, -Double.greatestFiniteMagnitude / 2)
        XCTAssertEqual(rect.size.width, Double.greatestFiniteMagnitude)
        XCTAssertEqual(rect.size.height, Double.greatestFiniteMagnitude)
        XCTAssertFalse(rect.isZero)
        XCTAssertFalse(rect.isNaN)
        XCTAssertTrue(rect.isInfinite)
        XCTAssertTrue(rect.isNull)
        XCTAssertTrue(rect.isEmpty)
        
        rect = .null
        XCTAssertEqual(rect.origin.x, Double.infinity)
        XCTAssertEqual(rect.origin.y, Double.infinity)
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
        var cgRect = CGRect(Rect(x: 1.2, y: 3.4, width: 5.6, height: 7.8))
        XCTAssertEqual(cgRect.origin.x, 1.2, accuracy: 0.00001)
        XCTAssertEqual(cgRect.origin.y, 3.4, accuracy: 0.00001)
        XCTAssertEqual(cgRect.width, 5.6, accuracy: 0.00001)
        XCTAssertEqual(cgRect.height, 7.8, accuracy: 0.00001)
        cgRect = CGRect(.init(origin: Point(x: 12, y: 21), size: Size(width: 34, height: 43)))
        let rect = Rect(cgRect)
        XCTAssertEqual(rect.x, 12.0, accuracy: 0.00001)
        XCTAssertEqual(rect.y, 21.0, accuracy: 0.00001)
        XCTAssertEqual(rect.width, 34.0, accuracy: 0.00001)
        XCTAssertEqual(rect.height, 43.0, accuracy: 0.00001)
    }
    
    func testContains() {
        var rect: Rect = Rect(x: 0, y: 0, width: 100, height: 100)
        var point: Point = Point(x: 50, y: 50)
        var subRect: Rect = Rect(x: 25, y: 25, width: 50, height: 50)
        
        XCTAssertTrue(rect.contains(point))
        XCTAssertTrue(rect.contains(subRect))
        
        point = Point(x: 150, y: 150)
        subRect = Rect(x: 51, y: 51, width: 50, height: 50)
        
        XCTAssertFalse(rect.contains(point))
        XCTAssertFalse(rect.contains(subRect))
        
        rect = .null
        XCTAssertFalse(rect.contains(point))
        rect = .zero
        XCTAssertFalse(rect.contains(point))
    }
    
    func testIntersects() {
        let rect1: Rect = Rect(x: 0, y: 0, width: 100, height: 100)
        var rect2: Rect = Rect(x: 75, y: 75, width: 100, height: 100)
        XCTAssertTrue(rect1.intersects(rect2))
        rect2.origin = Point(x: 101, y: 101)
        XCTAssertFalse(rect1.intersects(rect2))
    }
    
    func testIntersection() {
        var rect1: Rect = .null
        var rect2: Rect = .null
        XCTAssertTrue(rect1.intersection(rect2).isNull)
        
        rect1 = Rect(x: 25, y: 25, width: 50, height: 50)
        XCTAssertTrue(rect1.intersection(rect2).isNull)
        
        rect2 = Rect(x: 50, y: 50, width: 50, height: 50)
        
        var rect = rect1.intersection(rect2)
        XCTAssertEqual(rect.origin.x, 50)
        XCTAssertEqual(rect.origin.y, 50)
        XCTAssertEqual(rect.size.width, 25)
        XCTAssertEqual(rect.size.height, 25)
        
        rect2 = Rect(x: 75.1, y: 75, width: 25, height: 25)
        rect = rect1.intersection(rect2)
        XCTAssertTrue(rect.isNull)
    }
    
    func testUnion() {
        var rect1: Rect = .null
        var rect2: Rect = .null
        XCTAssertTrue(rect1.union(rect2).isNull)
        
        rect1 = Rect(x: 25, y: 25, width: 25, height: 25)
        var rect = rect1.union(rect2)
        XCTAssertEqual(rect.origin.x, 25)
        XCTAssertEqual(rect.origin.y, 25)
        XCTAssertEqual(rect.size.width, 25)
        XCTAssertEqual(rect.size.height, 25)
        
        rect2 = Rect(x: 50, y: 50, width: 25, height: 25)
        rect = rect1.union(rect2)
        
        XCTAssertEqual(rect.origin.x, 25)
        XCTAssertEqual(rect.origin.y, 25)
        XCTAssertEqual(rect.size.width, 50)
        XCTAssertEqual(rect.size.height, 50)
    }
    
    func testOffsetBy() {
        let rect: Rect = .init(x: 40, y: 50, width: 60, height: 70)
        
        var r: Rect = Rect.null.offsetBy(dx: 10, dy: 10)
        XCTAssertTrue(r.isNull)
            
        r = rect.offsetBy(dx: 10, dy: 10)
        XCTAssertEqual(r.origin.x, 50)
        XCTAssertEqual(r.origin.y, 60)
        XCTAssertEqual(r.size.width, 60)
        XCTAssertEqual(r.size.height, 70)
        
        r = rect.offsetBy(dx: -10, dy: -10)
        XCTAssertEqual(r.origin.x, 30)
        XCTAssertEqual(r.origin.y, 40)
        XCTAssertEqual(r.size.width, 60)
        XCTAssertEqual(r.size.height, 70)
    }
    
    func testInsetBy() {
        var rect: Rect = .null
        var r = rect.insetBy(dx: 10.0, dy: 10.0)
        XCTAssertTrue(r.isNull)
        
        rect = .init(x: 44.33, y: 22.11, width: 11.22, height: 33.44)
        r = rect.insetBy(dx: 10.0, dy: 10.0)
        XCTAssertTrue(r.isNull)
        
        rect = .init(x: 44.33, y: 22.11, width: 44.33, height: 22.11)
        r = rect.insetBy(dx: 10.0, dy: 10.0)
        XCTAssertEqual(r.origin.x, 54.33)
        XCTAssertEqual(r.origin.y, 32.11)
        XCTAssertEqual(r.size.width, 24.33, accuracy: 0.01)
        XCTAssertEqual(r.size.height, 2.11, accuracy: 0.01)
        
        r = rect.insetBy(dx: -10.0, dy: -10.0)
        XCTAssertEqual(r.origin.x, 34.33)
        XCTAssertEqual(r.origin.y, 12.11, accuracy: 0.01)
        XCTAssertEqual(r.size.width, 64.33, accuracy: 0.01)
        XCTAssertEqual(r.size.height, 42.11, accuracy: 0.01)
    }
    
    func testExpandedBy() {
        let rect = Rect(x: 44.33, y: 22.11, width: 44.33, height: 22.11)
        let r = rect.expandedBy(dx: 10.0, dy: 10.0)
        XCTAssertEqual(r.origin.x, 34.33)
        XCTAssertEqual(r.origin.y, 12.11, accuracy: 0.01)
        XCTAssertEqual(r.size.width, 64.33, accuracy: 0.01)
        XCTAssertEqual(r.size.height, 42.11, accuracy: 0.01)
    }
}
