#if canImport(CoreGraphics)
import CoreGraphics
#endif
import Foundation
@testable import Swift2D
import Testing

struct RectTests {
    @Test func initializers() {
        var rect: Rect = .zero

        rect = Rect()
        #expect(rect.origin.x == 0.0)
        #expect(rect.origin.y == 0.0)
        #expect(rect.size.width == 0.0)
        #expect(rect.size.height == 0.0)

        rect = Rect(origin: Point(x: 4, y: 5), size: Size(width: 1.4, height: 5.2))
        #expect(rect.origin.x == 4.0)
        #expect(rect.origin.y == 5.0)
        #expect(rect.size.width == 1.4)
        #expect(rect.size.height == 5.2)

        rect = Rect(x: 1.2, y: 3.4, width: 5.6, height: 7.8)
        #expect(rect.origin.x == 1.2)
        #expect(rect.origin.y == 3.4)
        #expect(rect.size.width == 5.6)
        #expect(rect.size.height == 7.8)

        rect = Rect(x: 1, y: 2, width: 3, height: 4)
        #expect(rect.origin.x == 1.0)
        #expect(rect.origin.y == 2.0)
        #expect(rect.size.width == 3.0)
        #expect(rect.size.height == 4.0)

        rect = Rect(
            origin: Point(x: 4.87654321, y: 5.87654321),
            size: Size(width: 6.87654321, height: 7.87654321)
        )
        #expect(rect.origin.x == 4.87654321)
        #expect(rect.origin.y == 5.87654321)
        #expect(rect.size.width == 6.87654321)
        #expect(rect.size.height == 7.87654321)
    }

    @Test func customStringConvertible() {
        var rect: Rect = .zero

        rect = Rect(
            origin: Point(x: 15.0, y: 20.0),
            size: Size(width: 25.0, height: 10.0)
        )
        #expect(rect.description == "Rect(origin: Point(x: 15.0, y: 20.0), size: Size(width: 25.0, height: 10.0))")

        rect = Rect(
            origin: Point(x: 15.0, y: 20.0),
            size: Size(width: -25.0, height: -10.0)
        )
        #expect(rect.description == "Rect(origin: Point(x: 15.0, y: 20.0), size: Size(width: -25.0, height: -10.0))")

        rect = Rect(
            origin: Point(x: -15.0, y: -20.0),
            size: Size(width: -25.0, height: -10.0)
        )
        #expect(rect.description == "Rect(origin: Point(x: -15.0, y: -20.0), size: Size(width: -25.0, height: -10.0))")
    }

    @Test func equatable() {
        var r1: Rect = .zero
        var r2: Rect = .zero
        #expect(r1 == r2)

        r1 = .nan
        r2 = .nan
        #expect(r1 == r2)

        r1 = .infinite
        r2 = .infinite
        #expect(r1 == r2)

        r1 = .null
        r2 = .null
        #expect(r1 == r2)

        r1 = Rect(x: 10, y: 10, width: 20, height: 20)
        r2 = Rect(x: 100, y: 100, width: 200, height: 200)
        #expect(r1 != r2)

        r2 = r1
        #expect(r1 == r2)
    }

    @Test func codable() throws {
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

        let data = try #require(json.data(using: .utf8))
        var rect = try JSONDecoder().decode(Rect.self, from: data)
        #expect(rect.origin.x == 1.2)
        #expect(rect.origin.y == 2.3)
        #expect(rect.size.width == 3.4)
        #expect(rect.size.height == 4.5)

        rect = rect
            .origin(Point(x: 9.8, y: 8.7))
            .size(Size(width: 7.6, height: 6.5))

        let encoded = try JSONEncoder().encode(rect)
        let dictionary = try #require(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: [String: Double]])
        #expect(dictionary["origin"]?["x"] == 9.8)
        #expect(dictionary["origin"]?["y"] == 8.7)
        #expect(dictionary["size"]?["width"] == 7.6)
        #expect(dictionary["size"]?["height"] == 6.5)
    }

    @Test func staticReferences() {
        var rect: Rect = .zero
        #expect(rect.origin.x == 0.0)
        #expect(rect.origin.y == 0.0)
        #expect(rect.size.width == 0.0)
        #expect(rect.size.height == 0.0)
        #expect(rect.isZero)
        #expect(!rect.isNaN)
        #expect(!rect.isInfinite)
        #expect(!rect.isNull)
        #expect(rect.isEmpty)

        rect = .nan
        #expect(rect.origin.x.isNaN)
        #expect(rect.origin.y.isNaN)
        #expect(rect.size.width.isNaN)
        #expect(rect.size.height.isNaN)
        #expect(!rect.isZero)
        #expect(rect.isNaN)
        #expect(!rect.isInfinite)
        #expect(!rect.isNull)
        #expect(!rect.isEmpty)

        rect = .infinite
        #expect(rect.origin.x == -Double.greatestFiniteMagnitude / 2)
        #expect(rect.origin.y == -Double.greatestFiniteMagnitude / 2)
        #expect(rect.size.width == Double.greatestFiniteMagnitude)
        #expect(rect.size.height == Double.greatestFiniteMagnitude)
        #expect(!rect.isZero)
        #expect(!rect.isNaN)
        #expect(rect.isInfinite)
        #expect(rect.isNull)
        #expect(rect.isEmpty)

        rect = .null
        #expect(rect.origin.x == Double.infinity)
        #expect(rect.origin.y == Double.infinity)
        #expect(rect.size.width == 0.0)
        #expect(rect.size.height == 0.0)
        #expect(!rect.isZero)
        #expect(!rect.isNaN)
        #expect(!rect.isInfinite)
        #expect(rect.isNull)
        #expect(rect.isEmpty)
    }

    @Test func computedProperties() {
        var rect: Rect = .zero

        rect = Rect(x: 50.0, y: 50.0, width: 80.0, height: 80.0)
        #expect(rect.x == 50.0)
        #expect(rect.y == 50.0)
        #expect(rect.width == 80.0)
        #expect(rect.height == 80.0)
        #expect(rect.center == Point(x: 90.0, y: 90.0))
        #expect(rect.minX == 50.0)
        #expect(rect.midX == 90.0)
        #expect(rect.maxX == 130.0)
        #expect(rect.minY == 50.0)
        #expect(rect.midY == 90.0)
        #expect(rect.maxY == 130.0)
        #expect(rect.standardized == Rect(x: 50.0, y: 50.0, width: 80.0, height: 80.0))

        rect = Rect(x: 50.0, y: 50.0, width: -80.0, height: -80.0)
        #expect(rect.x == 50.0)
        #expect(rect.y == 50.0)
        #expect(rect.width == -80.0)
        #expect(rect.height == -80.0)
        #expect(rect.center == Point(x: 10.0, y: 10.0))
        #expect(rect.minX == -30.0)
        #expect(rect.midX == 10.0)
        #expect(rect.maxX == 50.0)
        #expect(rect.minY == -30.0)
        #expect(rect.midY == 10.0)
        #expect(rect.maxY == 50.0)
        #expect(rect.standardized == Rect(x: -30.0, y: -30.0, width: 80.0, height: 80.0))

        rect = .null
        #expect(rect.standardized.isNull)
    }

    @Test func coreGraphics() {
        var cgRect = CGRect(Rect(x: 1.2, y: 3.4, width: 5.6, height: 7.8))
        #expect(cgRect.origin.x == 1.2)
        #expect(cgRect.origin.y == 3.4)
        #expect(cgRect.width == 5.6)
        #expect(cgRect.height == 7.8)
        cgRect = CGRect(Rect(origin: Point(x: 12, y: 21), size: Size(width: 34, height: 43)))
        let rect = Rect(cgRect)
        #expect(rect.x == 12.0)
        #expect(rect.y == 21.0)
        #expect(rect.width == 34.0)
        #expect(rect.height == 43.0)
    }

    @Test func contains() {
        var rect = Rect(x: 0, y: 0, width: 100, height: 100)
        var point = Point(x: 50, y: 50)
        var subRect = Rect(x: 25, y: 25, width: 50, height: 50)

        #expect(rect.contains(point))
        #expect(rect.contains(subRect))

        point = Point(x: 150, y: 150)
        subRect = Rect(x: 51, y: 51, width: 50, height: 50)

        #expect(!rect.contains(point))
        #expect(!rect.contains(subRect))

        rect = .null
        #expect(!rect.contains(point))
        rect = .zero
        #expect(!rect.contains(point))
    }

    @Test func intersects() {
        let rect1 = Rect(x: 0, y: 0, width: 100, height: 100)
        var rect2 = Rect(x: 75, y: 75, width: 100, height: 100)
        #expect(rect1.intersects(rect2))
        rect2 = rect2.origin(Point(x: 101, y: 101))
        #expect(!rect1.intersects(rect2))
    }

    @Test func intersection() {
        var rect1: Rect = .null
        var rect2: Rect = .null
        #expect(rect1.intersection(rect2).isNull)

        rect1 = Rect(x: 25, y: 25, width: 50, height: 50)
        #expect(rect1.intersection(rect2).isNull)

        rect2 = Rect(x: 50, y: 50, width: 50, height: 50)

        var rect = rect1.intersection(rect2)
        #expect(rect.origin.x == 50)
        #expect(rect.origin.y == 50)
        #expect(rect.size.width == 25)
        #expect(rect.size.height == 25)

        rect2 = Rect(x: 75.1, y: 75, width: 25, height: 25)
        rect = rect1.intersection(rect2)
        #expect(rect.isNull)
    }

    @Test func union() {
        var rect1: Rect = .null
        var rect2: Rect = .null
        #expect(rect1.union(rect2).isNull)

        rect1 = Rect(x: 25, y: 25, width: 25, height: 25)
        var rect = rect1.union(rect2)
        #expect(rect.origin.x == 25)
        #expect(rect.origin.y == 25)
        #expect(rect.size.width == 25)
        #expect(rect.size.height == 25)

        rect2 = Rect(x: 50, y: 50, width: 25, height: 25)
        rect = rect1.union(rect2)

        #expect(rect.origin.x == 25)
        #expect(rect.origin.y == 25)
        #expect(rect.size.width == 50)
        #expect(rect.size.height == 50)
    }

    @Test func offsetBy() {
        let rect: Rect = Rect(x: 40, y: 50, width: 60, height: 70)

        var r = Rect.null.offsetBy(dx: 10, dy: 10)
        #expect(r.isNull)

        r = rect.offsetBy(dx: 10, dy: 10)
        #expect(r.origin.x == 50)
        #expect(r.origin.y == 60)
        #expect(r.size.width == 60)
        #expect(r.size.height == 70)

        r = rect.offsetBy(dx: -10, dy: -10)
        #expect(r.origin.x == 30)
        #expect(r.origin.y == 40)
        #expect(r.size.width == 60)
        #expect(r.size.height == 70)
    }

    @Test func insetBy() {
        var rect: Rect = .null
        var r = rect.insetBy(dx: 10.0, dy: 10.0)
        #expect(r.isNull)

        rect = Rect(x: 44.33, y: 22.11, width: 11.22, height: 33.44)
        r = rect.insetBy(dx: 10.0, dy: 10.0)
        #expect(r.isNull)

        rect = Rect(x: 44.33, y: 22.11, width: 44.33, height: 22.11)
        r = rect.insetBy(dx: 10.0, dy: 10.0)
        #expect(r.origin.x == 54.33)
        #expect(r.origin.y == 32.11)
        #expect(r.size.width == 24.33)
        #expect((r.size.height - 2.11) < 0.01)

        r = rect.insetBy(dx: -10.0, dy: -10.0)
        #expect(r.origin.x == 34.33)
        #expect(r.origin.y == 12.11)
        #expect(r.size.width == 64.33)
        #expect(r.size.height == 42.11)
    }

    @Test func expandedBy() {
        let rect = Rect(x: 44.33, y: 22.11, width: 44.33, height: 22.11)
        let r = rect.expandedBy(dx: 10.0, dy: 10.0)
        #expect(r.origin.x == 34.33)
        #expect(r.origin.y == 12.11)
        #expect(r.size.width == 64.33)
        #expect(r.size.height == 42.11)
    }
}
