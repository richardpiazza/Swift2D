@testable import Swift2D
import XCTest
#if canImport(CoreGraphics)
import CoreGraphics
#else
import Foundation
#endif

final class SizeTests: XCTestCase {
    func testInitializers() throws {
        var size: Size = .zero

        size = Size()
        XCTAssertEqual(size.width, 0.0)
        XCTAssertEqual(size.height, 0.0)

        size = Size(width: 5, height: 8)
        XCTAssertEqual(size.width, 5.0)
        XCTAssertEqual(size.height, 8.0)

        size = Size(width: 5.876, height: 8.123)
        XCTAssertEqual(size.width, 5.876)
        XCTAssertEqual(size.height, 8.123)

        size = Size(width: 0.123456789, height: 0.987654321)
        XCTAssertEqual(size.width, 0.123456789)
        XCTAssertEqual(size.height, 0.987654321)
    }

    func testCustomStringConvertible() throws {
        let size = Size(width: 43.21, height: 87.65)
        XCTAssertEqual(size.description, "Size(width: 43.21, height: 87.65)")
    }

    func testEquatable() throws {
        var s1: Size = .zero
        var s2: Size = .zero
        XCTAssertTrue(s1 == s2)

        s1 = .nan
        s2 = .nan
        XCTAssertTrue(s1 == s2)

        s1 = .infinite
        s2 = .infinite
        XCTAssertTrue(s1 == s2)

        s1 = Size(width: 54.44, height: 65.55)
        s2 = Size(width: 55.56, height: 44.45)
        XCTAssertFalse(s1 == s2)
    }

    func testCodable() throws {
        let json = """
        {
            "width": 8.8,
            "height": 4
        }
        """

        let data = try XCTUnwrap(json.data(using: .utf8))
        var size = try JSONDecoder().decode(Size.self, from: data)
        XCTAssertEqual(size.width, 8.8)
        XCTAssertEqual(size.height, 4.0)

        size = size.width(0.111234).height(45.763)

        let encoded = try JSONEncoder().encode(size)
        #if canImport(ObjectiveC)
        let dictionary = try XCTUnwrap(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Double])
        XCTAssertEqual(dictionary["width"], 0.111234)
        XCTAssertEqual(dictionary["height"], 45.763)
        #else
        // On Linux systems the cast to 'Float' fails.
        let dictionary = try XCTUnwrap(JSONSerialization.jsonObject(with: encoded, options: .init()) as? [String: Double])
        XCTAssertEqual(dictionary["width"]!, 0.111234, accuracy: 0.0001)
        XCTAssertEqual(dictionary["height"]!, 45.763, accuracy: 0.001)
        #endif
    }

    func testStaticReferences() {
        var size: Size = .zero
        XCTAssertEqual(size.width, 0.0)
        XCTAssertEqual(size.height, 0.0)
        XCTAssertTrue(size.isZero)
        XCTAssertFalse(size.isNaN)

        size = .nan
        XCTAssertTrue(size.width.isNaN)
        XCTAssertTrue(size.height.isNaN)
        XCTAssertFalse(size.isZero)
        XCTAssertTrue(size.isNaN)
    }

    func testComputedProperties() {
        let size = Size(width: 15.0, height: -5.0)
        XCTAssertEqual(size.widthRadius, 7.5)
        XCTAssertEqual(size.heightRadius, 2.5)
        XCTAssertEqual(size.maxRadius, 7.5)
        XCTAssertEqual(size.minRadius, 2.5)
        XCTAssertEqual(size.center, Point(x: 7.5, y: 2.5))
    }

    func testCoreGraphics() throws {
        let size = Size(width: 45, height: 60)
        var cgSize = CGSize(size)
        XCTAssertEqual(cgSize.width, 45.0)
        XCTAssertEqual(cgSize.height, 60.0)
        XCTAssertEqual(Size(cgSize), Size(width: 45.0, height: 60.0))
        cgSize = CGSize(Size(width: 24.7, height: 31.5))
        XCTAssertEqual(cgSize.width, 24.7, accuracy: 0.0001)
        XCTAssertEqual(cgSize.height, 31.5)
    }
}
