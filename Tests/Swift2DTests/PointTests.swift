@testable import Swift2D
import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

final class PointTests: XCTestCase {
    func testInitializers() throws {
        var point: Point = .zero

        point = .init()
        XCTAssertEqual(point.x, 0.0)
        XCTAssertEqual(point.y, 0.0)

        point = .init(x: 5, y: 8)
        XCTAssertEqual(point.x, 5.0)
        XCTAssertEqual(point.y, 8.0)

        point = .init(x: 5.876, y: 8.123)
        XCTAssertEqual(point.x, 5.876)
        XCTAssertEqual(point.y, 8.123)

        point = .init(x: 0.123456789, y: 0.987654321)
        XCTAssertEqual(point.x, 0.123456789)
        XCTAssertEqual(point.y, 0.987654321)
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

        point = point.with(x: 0.111234).with(y: 45.763)

        let encoded = try JSONEncoder().encode(point)
        #if canImport(ObjectiveC)
        let dictionary = try XCTUnwrap(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Double])
        XCTAssertEqual(dictionary["x"], 0.111234)
        XCTAssertEqual(dictionary["y"], 45.763)
        #else
        // On Linux systems the cast to 'Float' fails.
        let dictionary = try XCTUnwrap(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Double])
        XCTAssertEqual(dictionary["x"]!, 0.111234, accuracy: 0.0001)
        XCTAssertEqual(dictionary["y"]!, 45.763, accuracy: 0.001)
        #endif
    }

    func testStaticReferences() {
        var point: Point = .zero
        XCTAssertEqual(point.x, 0.0)
        XCTAssertEqual(point.y, 0.0)
        XCTAssertTrue(point.isZero)
        XCTAssertFalse(point.isNaN)

        point = .nan
        XCTAssertTrue(point.x.isNaN)
        XCTAssertTrue(point.y.isNaN)
        XCTAssertFalse(point.isZero)
        XCTAssertTrue(point.isNaN)
    }

    func testComputedProperties() {
        let point = Point(x: -5, y: 5)
        let reflection = point.reflection(using: .zero)
        XCTAssertEqual(reflection.x, 5)
        XCTAssertEqual(reflection.y, -5)
    }

    func testCoreGraphics() throws {
        let point = Point(x: 45, y: 60)
        var cgPoint = CGPoint(point)
        XCTAssertEqual(cgPoint.x, 45.0)
        XCTAssertEqual(cgPoint.y, 60.0)
        XCTAssertEqual(Point(cgPoint), .init(x: 45.0, y: 60.0))
        cgPoint = CGPoint(Point(x: 24.7, y: 31.5))
        XCTAssertEqual(cgPoint.x, 24.7, accuracy: 0.0001)
        XCTAssertEqual(cgPoint.y, 31.5)
    }

    func testReflection() throws {
        let rect = Rect(origin: .zero, size: Size(width: 500, height: 500))
        let center = rect.center

        // x=x y=y
        var point = Point(x: 250, y: 250)
        var reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 250, y: 250))

        // x→x y↓y
        point = Point(x: 150, y: 50)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 350, y: 450))

        // x→x y=y
        point = Point(x: 150, y: 250)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 350, y: 250))

        // x=x y↓y
        point = Point(x: 250, y: 50)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 250, y: 450))

        // x←x y↑y
        point = Point(x: 350, y: 450)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 150, y: 50))

        // x=x y↑y
        point = Point(x: 250, y: 450)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 250, y: 50))

        // x←x y=y
        point = Point(x: 350, y: 250)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 150, y: 250))

        // x→x y↑y
        point = Point(x: 150, y: 450)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 350, y: 50))

        // x←x y↓y
        point = Point(x: 350, y: 50)
        reflection = point.reflection(using: center)
        XCTAssertEqual(reflection, Point(x: 150, y: 450))
    }
}
