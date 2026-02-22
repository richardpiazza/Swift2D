#if canImport(CoreGraphics)
import CoreGraphics
#endif
import Foundation
@testable import Swift2D
import Testing

struct SizeTests {
    @Test func initializers() {
        var size: Size = .zero

        size = Size()
        #expect(size.width == 0.0)
        #expect(size.height == 0.0)

        size = Size(width: 5, height: 8)
        #expect(size.width == 5.0)
        #expect(size.height == 8.0)

        size = Size(width: 5.876, height: 8.123)
        #expect(size.width == 5.876)
        #expect(size.height == 8.123)

        size = Size(width: 0.123456789, height: 0.987654321)
        #expect(size.width == 0.123456789)
        #expect(size.height == 0.987654321)
    }

    @Test func customStringConvertible() {
        let size = Size(width: 43.21, height: 87.65)
        #expect(size.description == "Size(width: 43.21, height: 87.65)")
    }

    @Test func equatable() {
        var s1: Size = .zero
        var s2: Size = .zero
        #expect(s1 == s2)

        s1 = .nan
        s2 = .nan
        #expect(s1 == s2)

        s1 = .infinite
        s2 = .infinite
        #expect(s1 == s2)

        s1 = Size(width: 54.44, height: 65.55)
        s2 = Size(width: 55.56, height: 44.45)
        #expect(s1 != s2)
    }

    @Test func codable() throws {
        let json = """
        {
            "width": 8.8,
            "height": 4
        }
        """

        let data = try #require(json.data(using: .utf8))
        var size = try JSONDecoder().decode(Size.self, from: data)
        #expect(size.width == 8.8)
        #expect(size.height == 4.0)

        size = size.width(0.111234).height(45.763)

        let encoded = try JSONEncoder().encode(size)
        let dictionary = try #require(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Double])
        #expect(dictionary["width"] == 0.111234)
        #expect(dictionary["height"] == 45.763)
    }

    @Test func staticReferences() {
        var size: Size = .zero
        #expect(size.width == 0.0)
        #expect(size.height == 0.0)
        #expect(size.isZero)
        #expect(!size.isNaN)

        size = .nan
        #expect(size.width.isNaN)
        #expect(size.height.isNaN)
        #expect(!size.isZero)
        #expect(size.isNaN)
    }

    @Test func computedProperties() {
        let size = Size(width: 15.0, height: -5.0)
        #expect(size.widthRadius == 7.5)
        #expect(size.heightRadius == 2.5)
        #expect(size.maxRadius == 7.5)
        #expect(size.minRadius == 2.5)
        #expect(size.center == Point(x: 7.5, y: 2.5))
    }

    @Test func coreGraphics() {
        let size = Size(width: 45, height: 60)
        var cgSize = CGSize(size)
        #expect(cgSize.width == 45.0)
        #expect(cgSize.height == 60.0)
        #expect(Size(cgSize) == Size(width: 45.0, height: 60.0))
        cgSize = CGSize(Size(width: 24.7, height: 31.5))
        #expect(cgSize.width == 24.7)
        #expect(cgSize.height == 31.5)
    }
}
