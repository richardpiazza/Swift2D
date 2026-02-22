#if canImport(CoreGraphics)
import CoreGraphics
#endif
import Foundation
@testable import Swift2D
import Testing

struct PointTests {
    @Test func initializers() {
        var point: Point = .zero

        point = Point()
        #expect(point.x == 0.0)
        #expect(point.y == 0.0)

        point = Point(x: 5, y: 8)
        #expect(point.x == 5.0)
        #expect(point.y == 8.0)

        point = Point(x: 5.876, y: 8.123)
        #expect(point.x == 5.876)
        #expect(point.y == 8.123)

        point = Point(x: 0.123456789, y: 0.987654321)
        #expect(point.x == 0.123456789)
        #expect(point.y == 0.987654321)
    }

    @Test func customStringConvertible() {
        let point = Point(x: 5.0, y: -5.0)
        #expect(point.description == "Point(x: 5.0, y: -5.0)")
    }

    @Test func equatable() {
        var p1: Point = .zero
        var p2: Point = .zero
        #expect(p1 == p2)

        p1 = .nan
        p2 = .nan
        #expect(p1 == p2)

        p1 = .infinite
        p2 = .infinite
        #expect(p1 == p2)

        p1 = .null
        p2 = .null
        #expect(p1 == p2)

        p1 = Point(x: 2.5, y: 1.75)
        p2 = Point(x: 4, y: 7)
        #expect(p1 != p2)
    }

    @Test func codable() throws {
        let json = """
        {
            "x": 8.8,
            "y": 4
        }
        """

        let data = try #require(json.data(using: .utf8))
        var point = try JSONDecoder().decode(Point.self, from: data)
        #expect(point.x == 8.8)
        #expect(point.y == 4.0)

        point = point.x(0.111234).y(45.763)

        let encoded = try JSONEncoder().encode(point)
        let dictionary = try #require(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Double])
        #expect(dictionary["x"] == 0.111234)
        #expect(dictionary["y"] == 45.763)
    }

    @Test func staticReferences() {
        var point: Point = .zero
        #expect(point.x == 0.0)
        #expect(point.y == 0.0)
        #expect(point.isZero)
        #expect(!point.isNaN)

        point = .nan
        #expect(point.x.isNaN)
        #expect(point.y.isNaN)
        #expect(!point.isZero)
        #expect(point.isNaN)
    }

    @Test func computedProperties() {
        let point = Point(x: -5, y: 5)
        let reflection = point.reflecting(around: .zero)
        #expect(reflection.x == 5)
        #expect(reflection.y == -5)
    }

    @Test func coreGraphics() {
        let point = Point(x: 45, y: 60)
        var cgPoint = CGPoint(point)
        #expect(cgPoint.x == 45.0)
        #expect(cgPoint.y == 60.0)
        #expect(Point(cgPoint) == Point(x: 45.0, y: 60.0))
        cgPoint = CGPoint(Point(x: 24.7, y: 31.5))
        #expect(cgPoint.x == 24.7)
        #expect(cgPoint.y == 31.5)
    }

    @Test func reflection() {
        let rect = Rect(origin: .zero, size: Size(width: 500, height: 500))
        let center = rect.center

        // x=x y=y
        var point = Point(x: 250, y: 250)
        var reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 250, y: 250))

        // x→x y↓y
        point = Point(x: 150, y: 50)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 350, y: 450))

        // x→x y=y
        point = Point(x: 150, y: 250)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 350, y: 250))

        // x=x y↓y
        point = Point(x: 250, y: 50)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 250, y: 450))

        // x←x y↑y
        point = Point(x: 350, y: 450)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 150, y: 50))

        // x=x y↑y
        point = Point(x: 250, y: 450)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 250, y: 50))

        // x←x y=y
        point = Point(x: 350, y: 250)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 150, y: 250))

        // x→x y↑y
        point = Point(x: 150, y: 450)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 350, y: 50))

        // x←x y↓y
        point = Point(x: 350, y: 50)
        reflection = point.reflecting(around: center)
        #expect(reflection == Point(x: 150, y: 450))
    }
}
